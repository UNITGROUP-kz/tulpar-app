import 'package:fform/fform.dart';

import '../fields/confirm_password_field.dart';
import '../fields/email_phone_field.dart';
import '../fields/name_field.dart';
import '../fields/password_field.dart';

class RegisterForm extends FForm {
  final EmailPhoneField emailPhone;
  final PasswordField password;
  final ConfirmPasswordField confirmPassword;
  final NameField name;


  RegisterForm({
    required this.emailPhone,
    required this.password,
    required this.confirmPassword,
    required this.name
  });

  factory RegisterForm.parse({
    required String emailPhone,
    required String password,
    required String confirmPassword,
    required String name,
  }) {
    return RegisterForm(
        emailPhone: EmailPhoneField.dirty(emailPhone),
        password: PasswordField.dirty(password),
        confirmPassword: ConfirmPasswordField.dirty(confirmPassword, password),
        name: NameField.dirty(name)
    );
  }

  @override
  List<FFormField> get fields => [emailPhone, password, confirmPassword];
}

