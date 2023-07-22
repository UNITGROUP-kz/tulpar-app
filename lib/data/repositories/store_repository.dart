import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/store/edit_store_params.dart';

import '../models/auth/store_model.dart';

class StoreRepository {
  static Future edit(StoreModel store, EditStoreParams params) => ApiService.I
      .post('/store/${store.id}', data: params.toData());

  static Future editImage(StoreModel store, EditImageStoreParams params) => ApiService.I
      .post('/store/${store.id}', data: params.toData());

  static Future<StoreModel> info(int storeId) => ApiService.I
      .get('/store/$storeId')
      .then((value) => StoreModel.fromMap(value.data['store']));
}