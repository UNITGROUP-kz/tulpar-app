import 'package:garage/core/utils/parser.dart';

class CarModelModel {
  final int id;
  final String name;
  final String apiId;
  final String? image;

  factory CarModelModel.fromMap(Map<String, dynamic> map) {
    return CarModelModel(
        id: map['id'],
        name: map['name'],
        apiId: map['api_id'],
        image: map['img']
    );
  }

  static List<CarModelModel> fromListMap(data) {
    return data.map<CarModelModel>((producer) {
      return CarModelModel.fromMap(producer);
    }).toList();
  }

  CarModelModel({
    required this.id,
    required this.name,
    required this.apiId,
    this.image,
  });
}