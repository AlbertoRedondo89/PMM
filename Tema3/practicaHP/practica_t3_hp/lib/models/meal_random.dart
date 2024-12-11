import 'dart:convert';

class MealRandom {
  List<Map<String, String?>> meals;

  MealRandom({
    required this.meals,
  });

  factory MealRandom.fromJson(String str) =>
      MealRandom.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MealRandom.fromMap(Map<String, dynamic> json) => MealRandom(
        meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
      );

  Map<String, dynamic> toMap() => {
        "meals": List<dynamic>.from(meals.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
