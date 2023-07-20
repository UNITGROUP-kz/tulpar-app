
import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/order/index_order_params.dart';

import '../../models/dictionary/order_model.dart';

class OrderStoreRepository {

  static index(IndexOrderParams params) => ApiService.I
      .get('/order', queryParameters: params.toData())
      .then((value) => OrderModel.fromListMap(value.data['list']));

  static info(OrderModel order) => ApiService.I
      .get('/order/${order.id}')
      .then((value) => OrderModel.fromMap(value.data['order']));

}