import 'package:fform/fform.dart';

enum PasswordError {
  empty;
  @override
  String toString() {
    switch(this) {
      case empty: return 'Пароль пустой';
      default: return 'Пароль не верный';
    }
  }
}

class PasswordField extends FFormField {

  final bool isRequired;

  PasswordField.dirty(super.value, [this.isRequired = true]) : super.dirty();

  @override
  PasswordError? validator(value) {
    return isRequired && value.isEmpty ? PasswordError.empty : null;
  }
}