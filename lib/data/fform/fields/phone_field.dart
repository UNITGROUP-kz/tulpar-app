
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum PhoneError {
  empty, not;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Телефон пустой';
      case not: return 'Не верный формат телефона';

      default: return 'Телефона не верный';
    }
  }
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
