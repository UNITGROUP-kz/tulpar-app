import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/models/offer_model.dart';
import 'package:garage/data/params/offers/create_offer_params.dart';
import 'package:garage/data/params/offers/index_offer_params.dart';

class OfferStoreRepository {
  static Future<List<OfferModel>> indexMy(IndexOfferParams params) => ApiService.I
      .get('/offers/my', queryParameters: params.toData())
      .then((value) => OfferModel.fromListMap(value.data['list']));

  static Future create(CreateOfferParams params) => ApiService.I
      .post('/offers/create', data: params.toData());
}