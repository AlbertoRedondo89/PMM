import 'dart:convert';

// Clase básica de recetas, contiene los datos esenciales para mostrar foto y nombre de las recetas además del ID
// para buscar sus detalles si es necesario. 

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
