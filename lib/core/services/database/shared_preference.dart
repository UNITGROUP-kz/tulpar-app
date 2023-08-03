import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static late SharedPreferences _instance;

  static Future initialize() async {
    _instance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get I => _instance;
}