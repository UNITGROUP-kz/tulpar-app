class ChangeProfileParams {
  final String name;
  final String? email;
  final String? phone;
  final String? password;

  ChangeProfileParams({
    required this.name,
    this.email,
    this.phone,
    this.password,
  });

  toData() {
    final data = {
      'name': name,
    };

    if(phone != null) {
      data.addAll({'phone': phone ?? ''});
    }
    if(password != null) {
      data.addAll({'password': password ?? ''});
    }
    if(email != null) {
      data.addAll({'email': email ?? ''});
    }
    print(data);

    return data;
  }

}