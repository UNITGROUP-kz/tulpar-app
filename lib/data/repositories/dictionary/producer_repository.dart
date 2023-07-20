import 'package:garage/data/models/dictionary/producer_model.dart';
import 'package:garage/data/params/dictionary/index_producer_params.dart';

import '../../../core/services/api/api_service.dart';

class ProducerRepository {
  static Future<List<ProducerModel>> index(IndexProducerParams params) => ApiService.I
      .get('/producers', queryParameters: params.toData())
      .then((value) => ProducerModel.fromListMap(value.data['list']));
}