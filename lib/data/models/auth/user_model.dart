import 'package:isar/isar.dart';

part 'user_model.g.dart';


@collection
class UserModel {
  final Id id;
  final String? email;
  final String? phone;

  UserModel({
    required this.id,
    this.email,
    this.phone
  });

  factory UserModel.fromMap(data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      phone: data['phone']
    );
  }
}