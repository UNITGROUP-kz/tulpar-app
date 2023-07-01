import 'package:garage/core/utils/parser.dart';

class CarModelModel {
  final int id;
  final String name;
  final int startYear;
  final int endYear;

  factory CarModelModel.fromMap(Map<String, dynamic> map) {
    return CarModelModel(
        id: map['id'],
        name: map['name'],
        startYear: Parser.toInt(map['start_year']),
        endYear: Parser.toInt(map['end_year'])
    );
  }

  CarModelModel({
    required this.id,
    required this.name,
    required this.startYear,
    required this.endYear
  });
}