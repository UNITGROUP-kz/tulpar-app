
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum EmailPhoneError {
  empty, not;
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
