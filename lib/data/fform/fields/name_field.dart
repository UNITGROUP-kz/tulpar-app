
import 'package:fform/fform.dart';

enum NameError {
  empty;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Название пустое';
      default: return 'Название не верное';
    }
  }
}

class NameField extends FFormField {
  NameField.dirty(super.value) : super.dirty();

  @override
  NameError? validator(value) {
    if(value.isEmpty) return NameError.empty;
    return null;
  }
}
