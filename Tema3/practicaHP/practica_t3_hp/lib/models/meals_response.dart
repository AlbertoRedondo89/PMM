import 'package:practica_t3_hp/models/models.dart';

class MealsResponse {
  List<Meal> meals;

  MealsResponse({
    required this.meals,
  });

  factory MealsResponse.fromJson(String str) =>
      MealsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MealsResponse.fromMap(Map<String, dynamic> json) => MealsResponse(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toMap())),
      };
}
