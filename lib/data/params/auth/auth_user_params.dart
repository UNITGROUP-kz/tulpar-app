enum AuthorizationRequestType {
  email, phone
}

class RegisterUserParams {
  final AuthorizationRequestType type;
  final String name;
  final String? email;
  final String? phone;
  final String password;
  final String passwordConfirmation;

  RegisterUserParams({
    required this.type,
    required this.name,
    this.email,
    this.phone,
    required this.password,
    required this.passwordConfirmation
  });

  toData() {
    final data = {
      'name': name,
      'type': type.name,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    if(type == AuthorizationRequestType.phone) {
      data.addAll({'phone': phone ?? ''});
    } else if(type == AuthorizationRequestType.email) {
      data.addAll({'email': email ?? ''});
    }
    
    return data;
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