import 'dart:convert';

class MealReceta {
  List<Map<String, String?>> meals;
  late final List<String> ingredientes;
  late final List<String> ingredientesDetalles;

  MealReceta({
    required this.meals,
  }) {
    _generaIngredientes();
  }

  factory MealReceta.fromJson(String str) =>
      MealReceta.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory MealReceta.fromMap(Map<String, dynamic> json) => MealReceta(
        meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );

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

  String getInstructions() {
    if (meals.isNotEmpty && meals.first.containsKey('strInstructions')) {
      return meals.first['strInstructions'] ?? "";
    }
    return "";
  }

  void _generaIngredientes() {
    ingredientes = [];
    ingredientesDetalles = [];
    if (meals.isNotEmpty) {
      Map<String, String?> meal = meals.first;
      for (int i = 1; i <= 20; i++) {
        String key = 'strIngredient$i';
        String keyCantidad = 'strMeasure$i';
        if (meal.containsKey(key) &&
            meal[key] != null &&
            meal[key]!.isNotEmpty) {
          ingredientes.add(meal[key]!);
          if (meal.containsKey(keyCantidad) &&
              meal[keyCantidad] != null &&
              meal[keyCantidad]!.isNotEmpty) {
            ingredientesDetalles.add('${meal[keyCantidad]!} - ${meal[key]}');
          } else {
            ingredientesDetalles.add(meal[key]!); // Solo el ingrediente
          }
        }
      }
    }
  }

  List<String> getIngredients() {
    return ingredientes;
  }

  List<String> getIngredientesDetalles() {
    return ingredientesDetalles;
  }
}

/*
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

*/
