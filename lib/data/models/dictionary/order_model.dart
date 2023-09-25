import 'package:garage/data/models/dictionary/car_api_model.dart';
import 'package:garage/data/models/dictionary/car_model.dart';
import 'package:garage/data/models/dictionary/group_model.dart';
import 'package:garage/data/models/auth/store_model.dart';

import 'city_model.dart';


enum OrderStatus {
  moderation, active, canceled, completed;

  static parse(data) {
    switch(data) {
      case 'moderation': return OrderStatus.moderation;
      case 'active': return OrderStatus.active;
      case 'canceled': return OrderStatus.canceled;
      case 'completed': return OrderStatus.completed;
    }
  }

  @override
  String toString() {
    switch(this) {
      case OrderStatus.moderation: return 'На модерации';
      case OrderStatus.active: return 'Активный';
      case OrderStatus.canceled: return 'Закрыт';
      case OrderStatus.completed: return 'Законче';

    }
  }
}

class OrderModel {
  final int id;
  final String title;
  final CarApiModel? car;
  final GroupModel? group;
  final String? comment;
  final OrderStatus status;
  final StoreModel? store;
  final CityModel? city;

  factory OrderModel.fromMap(map) {
    return OrderModel(
        id: map['id'],
        title: map['title'],
        comment: map['comment'],
        status: OrderStatus.parse(map['status']),
        car: map['car'] != null ? CarApiModel.fromMap(map['car']) : null,
        group: map['part'] != null ? GroupModel.fromMap(map['part']) : null,
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
    required this.group,
    required this.comment,
    required this.status,
    required this.store,
    required this.city
  });
}