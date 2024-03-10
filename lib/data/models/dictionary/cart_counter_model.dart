import 'package:isar/isar.dart';

part 'cart_counter_model.g.dart';

@collection
class CartCounterModel {
  Id id = Isar.autoIncrement;

  late int partId;

  late int count;
}