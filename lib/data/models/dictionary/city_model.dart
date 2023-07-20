import 'package:isar/isar.dart';

part 'city_model.g.dart';

@collection
class CityModel {
  late Id id;

  late String name;

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
        id: map['id'],
        name: map['name']
    );
  }

  static List<CityModel> fromListMap(data) {
    return data.map<CityModel>((producer) {
      return CityModel.fromMap(producer);
    }).toList();
  }

  CityModel({
    required this.id,
    required this.name
  });
}