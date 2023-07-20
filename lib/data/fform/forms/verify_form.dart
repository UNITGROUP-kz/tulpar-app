import 'package:fform/fform.dart';
import 'package:garage/data/fform/fields/code_field.dart';

import '../fields/confirm_password_field.dart';
import '../fields/email_phone_field.dart';
import '../fields/password_field.dart';

class VerifyForm extends FForm {
  final EmailPhoneField emailPhone;
  final CodeField code;


  VerifyForm({
    required this.emailPhone,
    required this.code
  });

  factory VerifyForm.parse({
    required String emailPhone,
    required String code
  }) {
    return VerifyForm(
        emailPhone: EmailPhoneField.dirty(emailPhone),
        code: CodeField.dirty(code)
    );
  }

  @override
  List<FFormField> get fields => [emailPhone, code];
}

