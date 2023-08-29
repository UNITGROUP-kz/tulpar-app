import 'package:garage/core/utils/parser.dart';

class CarModel {
  final int id;
  final String? vinNumber;
  final String name;
  final String producerName;
  final int producerId;
  final String modelName;
  final int modelId;
  final int year;
  final double volumeEngine;

  CarModel({
    required this.id,
    this.vinNumber,
    required this.name,
    required this.producerName,
    required this.producerId,
    required this.modelName,
    required this.modelId,
    required this.year,
    required this.volumeEngine
  });

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
        id: map['id'],
        name: map['name'],
        vinNumber: map['vin_number'],
        producerName: map['producer_name'],
        modelName: map['model_name'],
        modelId: Parser.toInt(map['model_id'] ?? 0),
        producerId: Parser.toInt(map['producer_id'] ?? 0),
        year: map['year'],
        volumeEngine: Parser.toDouble(map['engine_volume'])
    );
  }

  static List<CarModel> fromListMap(data) {
    return data.map<CarModel>((map) {
      return CarModel.fromMap(map);
    }).toList();
  }
}