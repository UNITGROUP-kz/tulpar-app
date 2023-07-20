import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';
import 'package:garage/data/models/dictionary/store_model.dart';


enum OrderStatus {
  moderation;

  static parse(data) {
    switch(data) {
      case 'moderation': return OrderStatus.moderation;
    }
  }
}

class OrderModel {
  final int id;
  final String title;
  final CarModel? car;
  final PartModel? part;
  final String? comment;
  final OrderStatus status;
  final StoreModel? store;

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        id: map['id'],
        title: map['title'],
        comment: map['comment'],
        status: OrderStatus.parse(map['status']),
        car: map['car'] != null ? CarModel.fromMap(map['car']) : null,
        part: map['part'] != null ? PartModel.fromMap(map['part']) : null,
        store: map['store'] != null ? StoreModel.fromMap(map['store']) : null,
    );
  }

  static List<OrderModel> fromListMap(data) {
    return data.map<OrderModel>((map) {
      return OrderModel.fromMap(map);
    }).toList();
  }

  OrderModel({
    required this.id,
    required this.title,
    required this.car,
    required this.part,
    required this.comment,
    required this.status,
    required this.store
  });
}