
import 'package:fform/fform.dart';

enum VinError {
  empty, symbol;

  @override
  String toString() {
    switch(this) {
      case empty: return 'VIN-код пустой';
      case symbol: return 'VIN-код состоит из 17 символов';
      default: return 'VIN-код не верный';
    }
  }
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
