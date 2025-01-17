import 'package:app_persistencia/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcProvider with ChangeNotifier {
  String _historial = Preferences.calculo;
  String _expresion = "";
  String _user = Preferences.user;
  ThemeData current;

  CalcProvider({required bool darkMode}) 
  : current = darkMode ? ThemeData.dark() : ThemeData.light();

  String get historial => _historial;
  String get expresion => _expresion;

  void allClear([String? _]) {
    _historial = "";
    _expresion = "";
    Preferences.calculo = "";
    notifyListeners();
  }

  void clear([String? _]) {
    _expresion = "";
    notifyListeners();
  }

  void numClick(String text) {
    _expresion += text;
    notifyListeners();
  }

  void evaluar([String? _]) {
    Parser p = Parser();
    Expression exp = p.parse(_expresion);
    ContextModel cm = ContextModel();
    _historial = _expresion;
    Preferences.calculo = expresion;
    _expresion = exp.evaluate(EvaluationType.REAL, cm).toString();
    notifyListeners();
  }

  setLight() {
    current = ThemeData.light();
    Preferences.darkMode = false;
    notifyListeners();
  }
  setNight() {
    current = ThemeData.dark();
    Preferences.darkMode = true;
    notifyListeners();
  }

  void renombras(String valor) {
    _user = valor;
    Preferences.user = valor;
    notifyListeners();
  }

  String get user {
    return _user;
  }

}
