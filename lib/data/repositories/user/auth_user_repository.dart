import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/core/services/api/interceptors/auth_interceptor.dart';
import 'package:garage/core/services/isar_service.dart';
import 'package:garage/data/models/auth/auth_model.dart';
import 'package:garage/data/models/auth/user_model.dart';
import 'package:garage/data/params/auth/auth_user_params.dart';
import 'package:garage/data/params/profile/change_profile_params.dart';
import 'package:isar/isar.dart';


class AuthUserRepository {
    static AuthInterceptor? interceptor;
    static AuthModel? auth;

    static Future register(RegisterUserParams params) =>
        ApiService.I.post('/register', data: params.toData());

    static Future<AuthModel> login(LoginUserParams params) =>
        ApiService.I.post('/login', data: params.toData()).then((value) async {
            final token = value.data['token'];
            final user = UserModel.fromMap(value.data['user']);
            auth = AuthModel()..user.value = user
              ..token = token;
            await write(auth!);
            _addInterceptor(auth!);

            return auth!;
        });

    static Future<AuthModel> code(ConfirmUserParams params) =>
        ApiService.I.post('/confirmCode', data: params.toData()).then((value) async {
          final token = value.data['token'];
          final user = UserModel.fromMap(value.data['user']);
          auth = AuthModel()..user.value = user
            ..token = token;
          await write(auth!);
          _addInterceptor(auth!);

          return auth!;
        });
    
    static Future<AuthModel> update(ChangeProfileParams params) => ApiService.I.post('/user/update', data: params.toData()).then((value) async {
        UserModel user = UserModel.fromMap(value.data['user']);
        auth?.user.value = user;
        await write(auth!);
        return auth!;
      });

    static Future write(AuthModel auth) async {
        await IsarService.I.writeTxn(() async {
            await IsarService.I.authModels.put(auth);
            await IsarService.I.userModels.put(auth.user.value!);
            await auth.user.save();
        });
    }

    static Future clear() async {
      await IsarService.I.writeTxn(() async {
        await IsarService.I.authModels.clear();
      });
    }

    static Future<AuthModel?> read() async {
      List<AuthModel> auths = await IsarService.I.authModels.where().findAll();
      if(auths.isNotEmpty) {
        auth = auths[0];
        _addInterceptor(auth!);
        return auth;
      } else {
        return null;
      }
    }

    static _addInterceptor(AuthModel auth) {
      if(interceptor != null) {
        ApiService.removerInterceptor(interceptor!);
      }
      interceptor = AuthInterceptor(auth.token);
      ApiService.addInterceptor(interceptor!);
    }
}