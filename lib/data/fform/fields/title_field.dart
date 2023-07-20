
import 'package:fform/fform.dart';

enum TitleError {
  empty, symbol;
}

class TitleField extends FFormField {
  TitleField.dirty(super.value) : super.dirty();

  @override
  TitleError? validator(value) {
    if(value.isEmpty) return TitleError.empty;
    if(value.length != 17) return TitleError.symbol;

    return null;
  }
}
