import 'package:fform/fform.dart';

enum ConfirmPasswordError {
  empty, doesNotMatch;
  @override
  String toString() {
    switch(this) {
      case empty: return '"Повторите пароль" пустой';
      case doesNotMatch: return '"Повторите пароль" не похож на пароль';
      default: return 'Описание не верного формата';
    }
  }
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