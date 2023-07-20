
import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/producer_model.dart';

class CreateCarParams {
  final CarModelModel model;
  final ProducerModel producer;
  final String vinNumber;

  CreateCarParams({
    required this.model,
    required this.producer,
    required this.vinNumber
  });

  toData() {
    return {
      'model_id': model.id,
      'producer_id': producer.id,
      'vin_number': vinNumber
    };
  }


}