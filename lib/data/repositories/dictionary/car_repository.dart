import 'package:garage/data/models/dictionary/car_model_model.dart';
import 'package:garage/data/params/dictionary/index_car_model_params.dart';
import '../../../core/services/api/api_service.dart';

class CarRepository {
  static Future<List<CarModelModel>> index(IndexCarModelParams params) => ApiService.I
      .get('/carModels', queryParameters: params.toData())
      .then((value) => CarModelModel.fromListMap(value.data['list']));
}