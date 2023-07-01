import 'package:garage/core/services/api/api_service.dart';

enum AuthorizationRequestType {
  email, phone
}

class RegisterUserParams {
  final AuthorizationRequestType type;
  final String? email;
  final String? phone;
  final String password;
  final String passwordConfirmation;

  RegisterUserParams({
    required this.type,
    this.email,
    this.phone,
    required this.password,
    required this.passwordConfirmation
  });

  toData() {
    return {
      'type': type.name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
  }

}

class LoginUserParams {
  final String? email;
  final String? phone;
  final String password;

  LoginUserParams({
    this.email,
    this.phone,
    required this.password,
  });

  toData() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

}

class ConfirmUserParams {
  final String? email;
  final String? phone;
  final String code;

  ConfirmUserParams({
    this.email,
    this.phone,
    required this.code,
  });

  toData() {
    return {
      'email': email,
      'phone': phone,
      'code': code,
    };
  }
}

class AuthUserRepository {
    Future register(RegisterUserParams params) =>
        ApiService.I.post('/register', data: params.toData());

    Future login(LoginUserParams params) =>
        ApiService.I.post('/login', data: params.toData());

    Future code(ConfirmUserParams params) =>
        ApiService.I.post('/confirmCode', data: params.toData());
}