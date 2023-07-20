
import 'package:fform/fform.dart';

enum NameError {
  empty;
}

class NameField extends FFormField {
  NameField.dirty(super.value) : super.dirty();

  @override
  NameError? validator(value) {
    if(value.isEmpty) return NameError.empty;
    return null;
  }
}
