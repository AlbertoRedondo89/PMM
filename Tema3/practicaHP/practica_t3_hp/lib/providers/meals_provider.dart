import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_t3_hp/models/meal.dart';
import 'package:practica_t3_hp/models/meals_response.dart';

class MealsProvider extends ChangeNotifier {
  final String _baseUrl = 'themealdb.com';

  List<Meal> mealsDePrueba = [];

  MealsProvider() {
    print('povider llamado');
    getMealsDePrueba();
  }

  getMealsDePrueba() async {
    var url =
        Uri.https(_baseUrl, '/api/json/v1/1/filter.php', {'c': 'Seafood'});

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final mealsResponse = MealsResponse.fromJson(result.body);
      print(mealsResponse);
      mealsDePrueba = mealsResponse.meals;
      notifyListeners();
    } else {
      print('Error: ${result.statusCode}');
    }
  }
}
