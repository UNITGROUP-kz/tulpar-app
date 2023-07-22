import 'package:garage/data/models/auth/store_model.dart';
import 'package:isar/isar.dart';

part 'auth_store_model.g.dart';

@collection
class AuthStoreModel {
  Id id = Isar.autoIncrement;

  late String token;

  IsarLink<StoreModel> store = IsarLink<StoreModel>();
}