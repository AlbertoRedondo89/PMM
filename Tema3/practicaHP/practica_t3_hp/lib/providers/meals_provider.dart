import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_t3_hp/models/models.dart';

class MealsProvider extends ChangeNotifier {
  final String _baseUrl = 'themealdb.com';
  final String categoriaPorDefecto = 'Seafood';

  List<Meal> mealsPrincipales = [];
  List<MealReceta> mealsSugeridos = [];
  List<String> fotos = [];

  MealsProvider() {
    setMealsPrincipales(categoriaPorDefecto);
    getMealsSugeridos();
  }

  setMealsPrincipales(String categoria) async {
    var url =
        Uri.https(_baseUrl, '/api/json/v1/1/filter.php', {'c': categoria});

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final mealsResponse = MealsResponse.fromJson(result.body);
      print(mealsResponse);
      mealsPrincipales = mealsResponse.meals;
      notifyListeners();
    } else {
      print('Error: ${result.statusCode}');
    }
  }

  getMealsSugeridos() async {
    var url = Uri.https(_baseUrl, '/api/json/v1/1/random.php');

    for (int i = 0; i < 10; i++) {
      final result = await http.get(url);
      if (result.statusCode == 200) {
        final mealRandom = MealReceta.fromJson(result.body);
        print(mealRandom);
        mealsSugeridos.add(mealRandom);
        notifyListeners();
      } else {
        print('Error: ${result.statusCode}');
      }
    }
  }

  Future<MealReceta> getDatosReceta(String dato, bool idNombre) async {
    final url;
    if (idNombre) {
      url = Uri.https(_baseUrl, '/api/json/v1/1/lookup.php', {'i': dato});
    } else {
      url = Uri.https(_baseUrl, '/api/json/v1/1/search.php', {'s': dato});
    }
    final MealReceta recetaDetalle;

    final result = await http.get(url);
    if (result.statusCode == 200) {
      recetaDetalle = MealReceta.fromJson(result.body);
      notifyListeners();
    } else {
      print('Error: ${result.statusCode}');
      recetaDetalle = MealReceta(meals: []);
    }
    return recetaDetalle;
  }

  List<String> getoFotos(MealReceta receta) {
    List<String> ingredients = [];
    if (receta.meals.isNotEmpty) {
      Map<String, String?> meal = receta.meals.first;
      for (int i = 1; i <= 20; i++) {
        String key = 'strIngredient$i';
        if (meal.containsKey(key) &&
            meal[key] != null &&
            meal[key]!.isNotEmpty) {
          ingredients.add(
              'https://www.themealdb.com/images/ingredients/${meal[key]}!');
        }
      }
    }
    return ingredients;
  }
}
