
import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/order/create_order_params.dart';
import 'package:garage/data/params/order/index_order_params.dart';

import '../../models/dictionary/order_model.dart';

class OrderUserRepository {
    static create(CreateOrderParams params) => ApiService.I
        .post('/order', data: params.toData());

    static indexMy(IndexOrderParams params) => ApiService.I
        .get('/order', queryParameters: params.toData())
        .then((value) => OrderModel.fromListMap(value.data['list']));

    static info(OrderModel order) => ApiService.I
        .get('/order/${order.id}')
        .then((value) => OrderModel.fromMap(value.data['order']));

}