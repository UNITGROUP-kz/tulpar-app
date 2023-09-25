import 'package:garage/core/utils/parser.dart';

import 'car_api_model.dart';

class CarModel {
  final int id;
  final CarApiModel car;

  CarModel({
    required this.id,
    required this.car,
  });

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
        id: map['id'],
        car: CarApiModel.fromMap(map['car'])
    );
  }

  static List<CarModel> fromListMap(data) {
    return data.map<CarModel>((map) {
      return CarModel.fromMap(map);
    }).toList();
  }
}