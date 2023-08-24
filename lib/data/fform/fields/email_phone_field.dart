
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum EmailPhoneError {
  empty, not;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Телефон или почта пустая';
      case not: return 'Телефон или почта не верного формата';
      default: return 'Телефон или почта не верного формата';
    }
  }
}

class EmailPhoneField extends FFormField {
  EmailPhoneField.dirty(super.value) : super.dirty();

  @override
  EmailPhoneError? validator(value) {
    if(value.isEmpty) return EmailPhoneError.empty;
    if(!Check.isPhone(value) || !Check.isEmail(value)) EmailPhoneError.not;
    return null;
  }
}
