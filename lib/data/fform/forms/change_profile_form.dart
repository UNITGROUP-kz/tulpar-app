import 'package:fform/fform.dart';
import 'package:garage/data/fform/fields/email_field.dart';
import 'package:garage/data/fform/fields/name_field.dart';
import 'package:garage/data/fform/fields/phone_field.dart';

import '../fields/email_phone_field.dart';
import '../fields/password_field.dart';

class ChangeProfileForm extends FForm {
  final NameField name;
  final PhoneField phone;
  final EmailField email;
  final PasswordField password;

  ChangeProfileForm({
    required this.password,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory ChangeProfileForm.parse({
    required String password,
    required String name,
    required String phone,
    required String email
  }) {
    return ChangeProfileForm(
        password: PasswordField.dirty(password, false),
        name: NameField.dirty(name),
        phone: PhoneField.dirty(phone, false),
        email: EmailField.dirty(email, false)
    );
  }

  @override
  List<FFormField> get fields => [name, phone, email, password];
}

