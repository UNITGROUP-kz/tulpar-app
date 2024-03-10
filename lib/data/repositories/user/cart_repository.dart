import 'package:garage/logic/bloc/user/cart/cart_cubit.dart';

import '../../../core/services/api/api_service.dart';
import '../../models/dictionary/cart_model.dart';

class CartRepository {
  static Future<List<CartModel>> fetch() => ApiService.I
      .get('/cart', queryParameters: {'rowsPerPage': 10000})
      .then((value) => CartModel.fromListMap(value.data['list']));

  static Future add(int id) => ApiService.I
      .post('/cart/add/$id');

  static Future delete(int id) => ApiService.I
      .delete('/cart/delete/$id');
}