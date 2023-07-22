import 'package:fform/fform.dart';

import '../fields/description_field.dart';
import '../fields/name_field.dart';

class ChangeStoreForm extends FForm {
  final NameField name;
  final DescriptionField description;

  ChangeStoreForm({
    required this.name,
    required this.description
  });

  factory ChangeStoreForm.parse({
    required String name,
    required String description,
  }) {
    return ChangeStoreForm(
        name: NameField.dirty(name),
        description: DescriptionField.dirty(description)
    );
  }

  @override
  List<FFormField> get fields => [name, description];
}

