import '../../../core/utils/parser.dart';

class CarApiModel {
  final int id;
  final String apiId;
  final String name;
  final String producerName;
  final String producerId;
  final String modelName;
  final String modelId;

  CarApiModel({
    required this.apiId,
    required this.id,
    required this.name,
    required this.producerName,
    required this.producerId,
    required this.modelName,
    required this.modelId,
  });

  factory CarApiModel.fromMap(Map<String, dynamic> map) {
    return CarApiModel(
        id: map['id'],
        apiId: map['api_id'],
        name: map['name'],
        producerName: map['brand'],
        modelName: map['model'],
        modelId: map['modelId'],
        producerId: map['catalogId'],
    );
  }

  static List<CarApiModel> fromListMap(data) {
    return data.map<CarApiModel>((map) {
      return CarApiModel.fromMap(map);
    }).toList();
  }
}