import 'package:garage/core/services/api/api_service.dart';

import '../../models/dictionary/offer_model.dart';
import '../../models/dictionary/order_model.dart';


class OfferUserRepository {


  static Future<List<OfferModel>> index(OrderModel order) => ApiService.I
      .get('/order/${order.id}/offers')
      .then((value) => OfferModel.fromListMap(value.data['list']));

  static Future accept(OfferModel offer) => ApiService.I
      .post('/offers/${offer.id}/accept');
}