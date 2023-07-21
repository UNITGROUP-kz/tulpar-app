
import 'package:fform/fform.dart';

enum TitleError {
  empty,;
}

class TitleField extends FFormField {
  TitleField.dirty(super.value) : super.dirty();

  @override
  TitleError? validator(value) {
    if(value.isEmpty) return TitleError.empty;

    return null;
  }
}
