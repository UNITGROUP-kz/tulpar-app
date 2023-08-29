import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/models/dictionary/producer_model.dart';
import 'package:garage/data/params/auth/auth_store_params.dart';
import 'package:garage/data/params/change_image_params.dart';
import 'package:isar/isar.dart';

import '../../../core/services/api/interceptors/auth_interceptor.dart';
import '../../../core/services/database/isar_service.dart';
import '../../models/auth/auth_store_model.dart';
import '../../models/auth/store_model.dart';
import '../../params/profile/change_category_params.dart';
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

  static Future<AuthStoreModel> info() => ApiService.I.get('/store/${auth!.store.value!.id}')
      .then((value) async {
    final store = StoreModel.fromMap(value.data['store']);
    auth?.store.value = store;
    await write(auth!);
    return auth!;
  });

  static Future<AuthStoreModel> updateCategory(ChangeCategoryParams params) => ApiService.I.post('/store/updateСategory', data: params.toData()).then((value) async {
    final store = StoreModel.fromMap(value.data['store']);
    print(value.data['store']);
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
    StoreModel store = auth.store.value!;

    await IsarService.I.writeTxn(() async {
      await IsarService.I.authStoreModels.put(auth);
      await IsarService.I.storeModels.put(store);
      await auth.store.save();
    });
  }

  static Future clear() async {
    _removeInterceptor();
    auth = null;
    await IsarService.I.writeTxn(() async {
      await IsarService.I.authStoreModels.clear();
      await IsarService.I.storeModels.clear();
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