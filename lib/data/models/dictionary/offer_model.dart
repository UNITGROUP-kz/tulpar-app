
import 'package:garage/core/utils/parser.dart';

import 'order_model.dart';

enum ConditionOffer {
  news, used;

  static ConditionOffer parse(data) {
    switch(data) {
      case 'new': return news;
      case 'used': return used;
      default: return news;
    }
  }

  @override
  String toString() {
    switch(this) {
      case ConditionOffer.news: return 'Новая';
      case ConditionOffer.used: return 'Б/У';
    }
  }

  String toName() {
    switch(this) {
      case ConditionOffer.news: return 'new';
      case ConditionOffer.used: return 'used';
    }
  }

}

class OfferModel {
  final int id;
  final String? delivery;
  final double price;
  final String? producer;
  final ConditionOffer condition;
  final OrderModel? order;

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'],
      delivery: map['delivery'],
      price: Parser.toDouble(map['price']),
      producer: map['producer'],
      condition: ConditionOffer.parse(map['condition']),
      order: map['order'] != null ? OrderModel.fromMap(map['order']) : null
    );
  }

  static List<OfferModel> fromListMap(data) {
    return data.map<OfferModel>((map) {
      return OfferModel.fromMap(map);
    }).toList();
  }

  OfferModel({
    required this.id,
    required this.price,
    required this.condition,
    this.delivery,
    this.producer,
    this.order
  });
}