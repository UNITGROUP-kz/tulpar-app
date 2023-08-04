import 'package:fform/fform.dart';
import 'package:garage/data/fform/fields/description_field.dart';

import '../fields/number_field.dart';


class CreateOfferForm extends FForm {
  final DescriptionField producer;
  final DescriptionField delivery;
  final PriceField price;

  CreateOfferForm({
    required this.producer,
    required this.delivery,
    required this.price
  });


  factory CreateOfferForm.parse({
    required String producer,
    required String delivery,
    required String price,
  }) {
    return CreateOfferForm(
      producer: DescriptionField.dirty(producer),
      delivery: DescriptionField.dirty(delivery),
      price: PriceField.dirty(price)
    );
  }


  @override
  List<FFormField> get fields => [producer, delivery, price];

}