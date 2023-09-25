
import '../../models/dictionary/car_api_model.dart';
import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/producer_model.dart';

class CreateCarParams {
  final CarModelModel model;
  final ProducerModel producer;
  final CarApiModel carApi;

  CreateCarParams({
    required this.model,
    required this.producer,
    required this.carApi,
  });

  toData() {
    return {
      'model_id': model.apiId,
      'producer_id': producer.apiId,
      'car_id': carApi.id,
    };
  }
}