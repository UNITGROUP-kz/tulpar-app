import 'package:fform/fform.dart';

enum PasswordError {
  empty
}

class PasswordField extends FFormField {
  PasswordField.dirty(super.value) : super.dirty();

  @override
  PasswordError? validator(value) {
    if(value.isEmpty) return PasswordError.empty;
    return null;
  }
}