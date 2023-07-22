import 'package:fform/fform.dart';
import 'package:garage/data/fform/fields/phone_field.dart';

import '../fields/password_field.dart';

class StoreLoginForm extends FForm {
  final PhoneField phone;
  final PasswordField password;

  StoreLoginForm({
    required this.phone,
    required this.password
  });

  factory StoreLoginForm.parse({
    required String phone,
    required String password
  }) {
    return StoreLoginForm(
        phone: PhoneField.dirty(phone),
        password: PasswordField.dirty(password)
    );
  }

  @override
  List<FFormField> get fields => [phone, password];
}