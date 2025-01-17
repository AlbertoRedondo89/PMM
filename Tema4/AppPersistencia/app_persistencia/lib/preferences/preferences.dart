import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _user = "Usuario";
  static String _calculo = "";
  static bool _darkMode = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static String get user {
    return _prefs.getString('user') ?? _user;
  }
  static set user (String valor) {
    _user = user;
    _prefs.setString('user', valor);
  }

  static String get calculo {
    return _prefs.getString('calculo') ?? _calculo;
  }
  static set calculo (String valor) {
    _calculo = valor;
    _prefs.setString('calculo', valor);
  }

  static bool get darkMode {
    return _prefs.getBool('darkMode') ?? _darkMode;
  }
  static set darkMode (bool valor) {
    _darkMode = valor;
    _prefs.setBool('darkMode', valor);
  }
}