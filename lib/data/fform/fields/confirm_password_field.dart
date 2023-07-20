import 'package:fform/fform.dart';

enum ConfirmPasswordError {
  empty, doesNotMatch
}

class ConfirmPasswordField<String> extends FFormField {
  final String password;
  ConfirmPasswordField.dirty(super.value, this.password) : super.dirty();

  @override
  ConfirmPasswordError? validator(value) {
    if(value.isEmpty) return ConfirmPasswordError.empty;
    else if(value != password) return ConfirmPasswordError.doesNotMatch;
    return null;
  }
}