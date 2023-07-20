import 'package:garage/data/models/dictionary/part_model.dart';

import '../../../core/services/api/api_service.dart';
import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/producer_model.dart';
import '../../params/dictionary/index_car_model_params.dart';
import '../../params/dictionary/index_part_params.dart';
import '../../params/dictionary/index_producer_params.dart';

class DictionaryRepository {
  static Future<List<ProducerModel>> indexProducers(IndexProducerParams params) => ApiService.I
      .get('/producers', queryParameters: params.toData())
      .then((value) => ProducerModel.fromListMap(value.data['list']));

  static Future<List<PartModel>> indexParts(IndexPartParams params) => ApiService.I
      .get('/parts', queryParameters: params.toData())
      .then((value) => PartModel.fromListMap(value.data['list']));

  static Future<List<CarModelModel>> indexCarModels(IndexCarModelParams params) => ApiService.I
      .get('/carModels', queryParameters: params.toData())
      .then((value) => CarModelModel.fromListMap(value.data['list']));
}