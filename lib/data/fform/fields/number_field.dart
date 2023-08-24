import 'package:fform/fform.dart';

enum PriceError {
  empty, min, not;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Цена пустая';
      default: return 'Цена не верного формата';
    }
  }
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
