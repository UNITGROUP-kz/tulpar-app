import 'package:fform/fform.dart';

import '../fields/email_phone_field.dart';
import '../fields/password_field.dart';

class LoginForm extends FForm {
  final EmailPhoneField emailPhone;
  final PasswordField password;

  LoginForm({
    required this.emailPhone,
    required this.password
  });

  factory LoginForm.parse({
    required String emailPhone,
    required String password
  }) {
    return LoginForm(
        emailPhone: EmailPhoneField.dirty(emailPhone),
        password: PasswordField.dirty(password)
    );
  }

  @override
  List<FFormField> get fields => [emailPhone, password];
}

