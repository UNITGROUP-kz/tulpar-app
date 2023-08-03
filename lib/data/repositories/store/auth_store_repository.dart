import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/auth/auth_store_params.dart';
import 'package:garage/data/params/change_image_params.dart';
import 'package:isar/isar.dart';

import '../../../core/services/api/interceptors/auth_interceptor.dart';
import '../../../core/services/database/isar_service.dart';
import '../../models/auth/auth_store_model.dart';
import '../../models/auth/store_model.dart';
import '../../params/store/change_store_params.dart';

class AuthStoreRepository {

  static AuthInterceptor? interceptor;
  static AuthStoreModel? auth;

  static Future<AuthStoreModel> login(LoginStoreParams params) => ApiService.I.post('/store/login', data: params.toData()).then((value) async {
        final token = value.data['token'];
        final user = StoreModel.fromMap(value.data['store']);
        auth = AuthStoreModel()..store.value = user
          ..token = token;
        await write(auth!);
        _addInterceptor(auth!);

        return auth!;
      });


  static Future<AuthStoreModel> update(ChangeStoreParams params) => ApiService.I.post('/store/${auth!.store.value!.id}', data: params.toData())
      .then((value) async {
    final store = StoreModel.fromMap(value.data['store']);
    auth?.store.value = store;
    await write(auth!);
    return auth!;
  });

  static Future<AuthStoreModel> changeImage(ChangeImageParams params) => ApiService.I.post('/store/${auth!.store.value!.id}', data: params.toData())
      .then((value) async {
    final store = StoreModel.fromMap(value.data['store']);
    auth?.store.value = store;
    await write(auth!);
    return auth!;
  });

  static Future write(AuthStoreModel auth) async {
    await IsarService.I.writeTxn(() async {
      await IsarService.I.authStoreModels.put(auth);
      await IsarService.I.storeModels.put(auth.store.value!);
      await auth.store.save();
    });
  }

  static Future clear() async {
    _removeInterceptor();
    auth = null;
    await IsarService.I.writeTxn(() async {
      await IsarService.I.authStoreModels.clear();
    });
  }

  static Future<AuthStoreModel?> read() async {
    List<AuthStoreModel> auths = await IsarService.I.authStoreModels.where().findAll();
    if(auths.isNotEmpty) {
      auth = auths[0];
      _addInterceptor(auth!);
      return auth;
    } else {
      return null;
    }
  }

  static _addInterceptor(AuthStoreModel auth) {
    _removeInterceptor();
    interceptor = AuthInterceptor(auth.token);
    ApiService.addInterceptor(interceptor!);
  }

  static _removeInterceptor() {
    if(interceptor != null) {
      ApiService.removerInterceptor(interceptor!);
    }
  }
}