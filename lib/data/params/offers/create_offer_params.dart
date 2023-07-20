
import '../../models/dictionary/order_model.dart';

enum ConditionOffer {
  used, new1;

  String get name {
    switch(this) {
      case ConditionOffer.used: return used.name;
      case ConditionOffer.new1: return 'new';
    }
  }
}

class CreateOfferParams {
  final OrderModel order;
  final int price;
  final String delivery;
  final String producer;
  final ConditionOffer condition;

  CreateOfferParams({
    required this.order,
    required this.price,
    required this.delivery,
    required this.producer,
    required this.condition
  });

  toData() {
    return {
      'order_id': order.id,
      'price': price,
      'delivery': delivery,
      'producer': producer,
      'condition': condition.name
    };
  }
}