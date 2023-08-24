
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum CodeError {
  empty, min;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Код пустой';
      case min: return 'Код меншьше 6';
      default: return 'Код не верного формата';
    }
  }
}

class CodeField extends FFormField {
  CodeField.dirty(super.value) : super.dirty();

  @override
  CodeError? validator(value) {
    if(value.isEmpty) return CodeError.empty;
    if(value.length != 6) return CodeError.min;

    return null;
  }
}
