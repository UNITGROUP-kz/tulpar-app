import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/models/offer_model.dart';
import 'package:garage/data/models/order_model.dart';
import 'package:garage/data/params/offers/create_offer_params.dart';
import 'package:garage/data/params/offers/index_offer_params.dart';


class OfferUserRepository {


  static Future<List<OfferModel>> index(OrderModel order) => ApiService.I
      .get('/order/${order.id}/offers')
      .then((value) => OfferModel.fromListMap(value.data['list']));

  static Future accept(OfferModel offer) => ApiService.I
      .post('/offers/${offer.id}/accept');
}