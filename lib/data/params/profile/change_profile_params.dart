
import 'package:dio/dio.dart';

class ChangeProfileParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  ChangeProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  FormData toData() {
    FormData data = FormData.fromMap({
      'name': name,
    });
    if(phone.isNotEmpty) {
      data.fields.add(MapEntry('phone', phone));
    }
    if(password.isNotEmpty) {
      data.fields.add(MapEntry('password', password));
    }
    if(email.isNotEmpty) {
      data.fields.add(MapEntry('email', email));
    }

    return data;
  }

}
