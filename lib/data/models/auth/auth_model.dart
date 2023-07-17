import 'package:garage/data/models/auth/user_model.dart';
import 'package:isar/isar.dart';

part 'auth_model.g.dart';

@collection
class AuthModel {
  Id id = Isar.autoIncrement;

  late String token;

  IsarLink<UserModel> user = IsarLink<UserModel>();
}