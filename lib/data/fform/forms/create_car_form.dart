import 'package:fform/fform.dart';

import '../fields/vin_field.dart';

class CreateCarForm extends FForm {
  final VinField vin;

  CreateCarForm({
    required this.vin
  });


  factory CreateCarForm.parse({
    required String vin,
  }) {
    return CreateCarForm(
        vin: VinField.dirty(vin),
    );
  }


  @override
  List<FFormField> get fields => [vin];

}