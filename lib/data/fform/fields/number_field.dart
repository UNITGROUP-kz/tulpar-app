import 'package:fform/fform.dart';
import 'package:garage/core/utils/check.dart';

enum PriceError {
  empty, min, not;
}

class PriceField extends FFormField {
  PriceField.dirty(super.value) : super.dirty();

  @override
  PriceError? validator(value) {
    if(value.isEmpty) return PriceError.empty;
    if(double.tryParse(value) == null) return PriceError.not;
    return null;
  }
}
