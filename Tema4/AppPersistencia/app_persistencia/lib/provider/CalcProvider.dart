import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcProvider with ChangeNotifier {
  String _historial = "";
  String _expresion = "";

  String get historial => _historial;
  String get expresion => _expresion;

  void allClear() {
    _historial = "";
    _expresion = "";
    notifyListeners();
  }

  void clear() {
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
    _expresion = exp.evaluate(EvaluationType.REAL, cm).toString();
    notifyListeners();
  }
}
