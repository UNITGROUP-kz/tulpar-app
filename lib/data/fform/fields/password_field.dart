import 'package:fform/fform.dart';

enum PasswordError {
  empty
}

class PasswordField extends FFormField {

  final bool isRequired;

  PasswordField.dirty(super.value, [this.isRequired = true]) : super.dirty();

  @override
  PasswordError? validator(value) {
    return isRequired && value.isEmpty ? PasswordError.empty : null;
  }
}