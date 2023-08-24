import 'package:fform/fform.dart';

enum DescriptionError {
  empty;

  @override
  String toString() {
    switch(this) {
      case empty: return 'Описание пустое';
      default: return 'Описание не верного формата';
    }
  }
}

class DescriptionField extends FFormField {

  final bool isRequired;

  DescriptionField.dirty(super.value, [this.isRequired = true]) : super.dirty();

  @override
  DescriptionError? validator(value) {
    if(isRequired) {
      if(value.isEmpty) return DescriptionError.empty;
    }
    return null;
  }
}