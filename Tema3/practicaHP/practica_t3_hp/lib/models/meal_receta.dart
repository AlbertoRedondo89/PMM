import 'dart:convert';

import 'package:provider/provider.dart';

class MealReceta {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strInstructions;

  MealReceta({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strInstructions,
  });

  factory MealReceta.fromJson(String str) =>
      MealReceta.fromMap(json.decode(str)['meals'][0]);

  factory MealReceta.fromMap(Map<String, dynamic> json) => MealReceta(
        idMeal: json['idMeal'] ?? '',
        strMeal: json['strMeal'] ?? '',
        strMealThumb: json['strMealThumb'] ?? '', 
        strInstructions: json['strInstructions'] ?? '',
      );

  String getImage() => strMealThumb;

  String getTitulo() => strMeal;

  String getIdMeal() => idMeal;

  String getInstructions() => strInstructions;
}

/*
class MealReceta {
  List<Map<String, String?>> meals;

  MealReceta({
    required this.meals,
  });

  factory MealReceta.fromJson(String str) =>
      MealReceta.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory MealReceta.fromMap(Map<String, dynamic> json) => MealReceta(
        meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );
/*
  Map<String, dynamic> toMap() => {
        "meals": List<dynamic>.from(meals.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
      */

// Metodos para obtener datos concretos, ya que la clase no tiene atributos fijos. 
  String getImage() {
    if (meals.isNotEmpty && meals.first.containsKey('strMealThumb')) {
      return meals.first['strMealThumb'] ?? "";
    }
    return ""; // Retorna una cadena vacía si no hay imagen disponible.
  }

  String getTitulo() {
    if (meals.isNotEmpty && meals.first.containsKey('strMeal')) {
      return meals.first['strMeal'] ?? "";
    }
    return "";
  }

  String getIdMeal() {
    if (meals.isNotEmpty && meals.first.containsKey('idMeal')) {
      return meals.first['idMeal'] ?? "";
    }
    return "";
  }
  */
  

