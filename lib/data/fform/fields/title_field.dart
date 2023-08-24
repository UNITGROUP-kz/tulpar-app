
import 'package:fform/fform.dart';

enum TitleError {
  empty;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Заголовок пустой';
      default: return 'Заголовок не верный';
    }
  }
}

class TitleField extends FFormField {
  TitleField.dirty(super.value) : super.dirty();

  @override
  TitleError? validator(value) {
    if(value.isEmpty) return TitleError.empty;

    return null;
  }
}
