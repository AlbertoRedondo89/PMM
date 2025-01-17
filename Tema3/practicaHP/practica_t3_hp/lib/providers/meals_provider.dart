import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_t3_hp/models/models.dart';

/*
Provider de la aplicación, conecta con la API https://www.themealdb.com/api.php
Obtiene las listas de recetas y recetas detalladas que necesita la aplicación.
Los métodos permiten actualizar las listas de recetas que se muestran, además de recibir las recetas completas en base a un id o nombre. 
*/

class MealsProvider extends ChangeNotifier {
  final String _baseUrl = 'themealdb.com';
  final String categoriaPorDefecto = 'Seafood';
  String categoriaSeleccionada = 'Seafood';

  List<Meal> mealsPrincipales = [];
  List<MealReceta> mealsSugeridos = [];
  List<String> fotos = [];

  MealsProvider() {
    setMealsPrincipales(categoriaPorDefecto);
    getMealsSugeridos();
  }

// Método para generar la lista principal de recetas. Recibe por parámetro la categoría de las recetas que buscará. 
  setMealsPrincipales(String categoria) async {
    var url =
        Uri.https(_baseUrl, '/api/json/v1/1/filter.php', {'c': categoria});

    final result = await http.get(url);

    if (result.statusCode == 200) {
      final mealsResponse = MealsResponse.fromJson(result.body);
      print(mealsResponse);
      mealsPrincipales = mealsResponse.meals;
      categoriaSeleccionada = categoria;
      notifyListeners();
    } else {
      print('Error: ${result.statusCode}');
    }
  }

  // Metodo para enerar lista de recetas aleatorias. Hace diez llamadas a la api para obtener recetas aleatorias y unirlas en una lista. 
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

  // Método para acceder a la información completa de una receta. 
  // Recibe un String por parámetro y un bool. En función del bool, buscará el String como id o como nombre en la API.
  Future<MealReceta> getDatosReceta(String dato, bool idNombre) async {
    final Uri url;
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

  // Método para generar la lista de urls en función de una lista de ingredientes que recibe por parámetro. 
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
