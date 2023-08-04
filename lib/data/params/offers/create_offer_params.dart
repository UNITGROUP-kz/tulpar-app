
import '../../models/dictionary/offer_model.dart';
import '../../models/dictionary/order_model.dart';

class CreateOfferParams {
  final OrderModel order;
  final double price;
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