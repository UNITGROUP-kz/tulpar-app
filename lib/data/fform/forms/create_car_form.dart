import 'package:fform/fform.dart';

import '../fields/name_field.dart';
import '../fields/vin_field.dart';

class CreateCarForm extends FForm {
  final VinField vin;
  final NameField name;

  CreateCarForm({
    required this.vin,
    required this.name
  });


  factory CreateCarForm.parse({
    required String vin,
    required String name,
  }) {
    return CreateCarForm(
        vin: VinField.dirty(vin),
        name: NameField.dirty(name)
    );
  }


  @override
  List<FFormField> get fields => [vin, name];

}