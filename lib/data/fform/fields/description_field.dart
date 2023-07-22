import 'package:fform/fform.dart';

enum DescriptionError {
  empty;
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