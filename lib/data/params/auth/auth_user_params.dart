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