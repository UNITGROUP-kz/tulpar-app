
import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum CodeError {
  empty, min;
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
