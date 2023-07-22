import 'package:isar/isar.dart';

part 'user_model.g.dart';


@collection
class UserModel {
  final Id id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.image
  });

  factory UserModel.fromMap(data) {
    print(data);
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      image: data['image']
    );
  }
}