import 'package:fform/fform.dart';

import '../fields/title_field.dart';

class CreateOrderForm extends FForm {
  final TitleField title;

  CreateOrderForm({
    required this.title
  });


  factory CreateOrderForm.parse({
    required String title,
  }) {
    return CreateOrderForm(
      title: TitleField.dirty(title),
    );
  }


  @override
  List<FFormField> get fields => [title];
}