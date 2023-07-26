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

  toData() {
    final data = {
      'name': name,
    };

    if(phone.isNotEmpty) {
      data.addAll({'phone': phone ?? ''});
    }
    if(password.isNotEmpty) {
      data.addAll({'password': password ?? ''});
    }
    if(email.isNotEmpty) {
      data.addAll({'email': email ?? ''});
    }
    print(data);

    return data;
  }

}