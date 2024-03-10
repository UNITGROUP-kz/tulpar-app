import 'package:garage/data/models/dictionary/part_model.dart';

import 'group_model.dart';

class CartModel {
  final int id;
  final GroupModel part;

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
        id: map['id'],
        part: GroupModel.fromMap(map['part'])
    );
  }

  static List<CartModel> fromListMap(data) {
    return data.map<CartModel>((producer) {
      return CartModel.fromMap(producer);
    }).toList();
  }

  CartModel({
    required this.id,
    required this.part
  });
}