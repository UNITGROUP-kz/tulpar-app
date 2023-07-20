import 'package:garage/core/utils/parser.dart';

class StoreModel {
  final int id;
  final String name;
  final String description;
  final String phone;
  final String? image;
  final int rating;

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        phone: map['phone'],
        image: map['image'],
        rating: Parser.toInt(map['rating'])
    );
  }

  StoreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.rating,
    this.image,
  });
}