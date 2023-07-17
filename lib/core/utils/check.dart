class Check {
  static bool isPhone(String data) {
    final RegExp regex = RegExp(r'^\+\d{11}$');

    return regex.hasMatch(data);
  }

  static bool isEmail(String data) {
    final RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    return regex.hasMatch(data);
  }
}