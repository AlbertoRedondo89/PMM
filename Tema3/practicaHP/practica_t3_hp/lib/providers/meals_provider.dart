import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_t3_hp/models/meal_random.dart';
import 'package:practica_t3_hp/models/models.dart';

class MealsProvider extends ChangeNotifier {
  final String _baseUrl = 'themealdb.com';

  List<Meal> mealsPrincipales = [];
  List<MealRandom> mealsSugeridos = [];

  MealsProvider() {
    getMealsDePrueba();
    getMealsSugeridos();
  }

  getMealsDePrueba() async {
    var url = Uri.https(_baseUrl, '/api/json/v1/1/random.php');

    for (int i = 0; i < 10; i++) {
      final result = await http.get(url);

      if (result.statusCode == 200) {
        final mealRandom = MealRandom.fromJson(result.body);
        print(mealRandom);
        mealsSugeridos.add(mealRandom);
        notifyListeners();
      } else {
        print('Error: ${result.statusCode}');
      }
    }
  }

  getMealsSugeridos() async {
    var url =
        Uri.https(_baseUrl, '/api/json/v1/1/filter.php', {'c': 'Seafood'});

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
}
