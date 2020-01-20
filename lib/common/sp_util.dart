import 'package:shared_preferences/shared_preferences.dart';

class SP {

  static Future<bool> saveString(String key, dynamic value) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    return _sp.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    return _sp.getString(key);
  }

}

class SPs {
  static const String USER = "user";
}