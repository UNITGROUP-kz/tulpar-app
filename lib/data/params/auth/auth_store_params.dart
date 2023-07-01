
class LoginStoreParams {
  final String phone;
  final String password;

  LoginStoreParams({
    required this.phone,
    required this.password,
  });

  toData() {
    return {
      'phone': phone,
      'password': password,
    };
  }

}
