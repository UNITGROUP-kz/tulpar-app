
import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/params/order/create_order_params.dart';
import 'package:garage/data/params/order/index_order_params.dart';

import '../../models/dictionary/order_model.dart';

class OrderUserRepository {
    static create(CreateOrderParams params) => ApiService.I
        .post('/order', data: params.toData());

    static Future<List<OrderModel>> indexMy(IndexOrderParams params) => ApiService.I
        .get('/order/my', queryParameters: params.toData())
        .then((value) => OrderModel.fromListMap(value.data['list']));

    static Future<OrderModel> info(int orderId) => ApiService.I
        .get('/order/$orderId')
        .then((value) => OrderModel.fromMap(value.data['order']));

    static Future rate(int orderId, int rate) => ApiService.I
        .post('/order/$orderId/rate', data: { 'rate': rate });

    static Future complete(int orderId) => ApiService.I
        .post('/order/$orderId/complete');

}