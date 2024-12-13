import 'dart:convert';

//Clase para mapear las recetas detalladas
// Al no tener parámetros fijos, he creado métodos para acceder a los que se necesitan. 

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

  factory MealReceta.fromMap(Map<String, dynamic> json) => MealReceta(
        meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );

  String getImage() {
    if (meals.isNotEmpty && meals.first.containsKey('strMealThumb')) {
      return meals.first['strMealThumb'] ?? "";
    }
    return ""; 
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

  // Método para generar las dos listas, la de ingredientes y la de ingredientes con cantidad. 
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
