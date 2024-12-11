import 'dart:convert';

class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(String str) => Meal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meal.fromMap(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toMap() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
