
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum EmailError {
  empty, not;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Email пустой';
      case not: return 'Email не верного формата';
      default: return 'Email не верного формата';
    }
  }
}

class EmailField extends FFormField {

  final bool isRequired;

  EmailField.dirty(super.value, [this.isRequired = true]) : super.dirty();

  @override
  EmailError? validator(value) {
    if(isRequired) {
      if(value.isEmpty) return EmailError.empty;
      if(!Check.isEmail(value)) EmailError.not;
    }
    return null;
  }
}
