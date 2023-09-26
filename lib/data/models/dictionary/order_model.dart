import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/models/auth/store_model.dart';
import 'package:garage/data/models/dictionary/part_model.dart';

import 'city_model.dart';


enum OrderStatus {
  moderation, active, done, canceled, completed;

  static parse(data) {
    print(data);
    switch(data) {
      case 'moderation': return OrderStatus.moderation;
      case 'active': return OrderStatus.active;
      case 'done': return OrderStatus.done;
      case 'canceled': return OrderStatus.canceled;
      case 'completed': return OrderStatus.completed;
    }
  }

  @override
  String toString() {
    switch(this) {
      case OrderStatus.moderation: return 'На модерации';
      case OrderStatus.active: return 'Активный';
      case OrderStatus.done: return 'Обрабатывается';
      case OrderStatus.canceled: return 'Закрыт';
      case OrderStatus.completed: return 'Закончен';

    }
  }
}

class OrderModel {
  final int id;
  final String title;
  final CarApiModel? car;
  final PartModel? part;
  final String? comment;
  final OrderStatus status;
  final StoreModel? store;
  final CityModel? city;

  factory OrderModel.fromMap(map) {
    print(map['store']);
    return OrderModel(
        id: map['id'],
        title: map['title'],
        comment: map['comment'],
        status: OrderStatus.parse(map['status']),
        car: map['car'] != null ? CarApiModel.fromMap(map['car']) : null,
        part: map['part'] != null ? PartModel.fromMap(map['part']) : null,
        store: map['store'] != null ? StoreModel.fromMap(map['store']) : null,
        city: map['city'] != null ? CityModel.fromMap(map['city']) : null,
    );

  }

  static List<OrderModel> fromListMap(data) {
    print(data);
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
    required this.store,
    required this.city
  });
}