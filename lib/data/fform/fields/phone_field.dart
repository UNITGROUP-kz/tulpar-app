
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum PhoneError {
  empty, not;
}

class PhoneField extends FFormField {
  final bool isRequired;

  PhoneField.dirty(super.value, [this.isRequired = true]) : super.dirty();

  @override
  PhoneError? validator(value) {
    if(isRequired) {
      if(value.isEmpty) return PhoneError.empty;
      if(!Check.isPhone(value)) PhoneError.not;
    }
    return null;
  }
}
