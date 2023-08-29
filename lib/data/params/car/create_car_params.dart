
import '../../models/dictionary/car_model_model.dart';
import '../../models/dictionary/producer_model.dart';

class CreateCarParams {
  final CarModelModel model;
  final ProducerModel producer;
  final double volume;
  final double engineVolume;
  final String vinNumber;
  final int year;

  CreateCarParams({
    required this.model,
    required this.producer,
    required this.vinNumber,
    required this.volume,
    required this.engineVolume,
    required this.year
  });

  toData() {
    return {
      'model_id': model.id,
      'producer_id': producer.id,
      'vin_number': vinNumber,
      'volume': volume,
      'engine_volume': volume,
      'year': year
    };
  }


}