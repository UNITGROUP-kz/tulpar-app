
import 'package:fform/fform.dart';

enum VinError {
  empty, symbol;
}

class VinField extends FFormField {
  VinField.dirty(super.value) : super.dirty();

  @override
  VinError? validator(value) {
    if(value.isEmpty) return VinError.empty;
    if(value.length != 17) return VinError.symbol;

    return null;
  }
}
