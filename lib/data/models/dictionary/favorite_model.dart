import 'package:isar/isar.dart';

part 'favorite_model.g.dart';

@collection
class FavoriteModel {
  Id id = Isar.autoIncrement;

  late int carId;
}