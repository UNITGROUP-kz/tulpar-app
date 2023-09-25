import 'package:garage/core/services/api/api_service.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/params/car/create_car_params.dart';
import 'package:garage/data/params/car/index_car_params.dart';


class CarUserRepository {
  static Future<List<CarModel>> indexMy(IndexMyCarParams params) => ApiService.I
      .get('/car/my', queryParameters: params.toData())
      .then((value) => CarModel.fromListMap(value.data['list']));

  static Future<CarModel> create(CreateCarParams params) => ApiService.I
      .post('/car', data: params.toData())
      .then((value) => CarModel.fromMap(value.data['car']));

  static Future<CarModel> getByVIN(String vinCode) => ApiService.I
      .get('/car', queryParameters: { 'q': vinCode})
      .then((value) => CarModel.fromMap(value.data['car']));
}