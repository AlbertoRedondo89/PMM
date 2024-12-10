import 'dart:convert';

class StudentsResponse {
  String id;
  String name;
  List<String> alternateNames;
  String species;
  String gender;
  String house;
  String? dateOfBirth;
  int? yearOfBirth;
  bool wizard;
  String ancestry;
  String eyeColour;
  String hairColour;
  Wand wand;
  String patronus;
  bool hogwartsStudent;
  bool hogwartsStaff;
  String actor;
  List<String> alternateActors;
  bool alive;
  String image;

  StudentsResponse({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });

  factory StudentsResponse.fromJson(String str) =>
      StudentsResponse.fromMap(json.decode(str));

  factory StudentsResponse.fromMap(Map<String, dynamic> json) =>
      StudentsResponse(
        id: json["id"],
        name: json["name"],
        alternateNames:
            List<String>.from(json["alternate_names"].map((x) => x)),
        species: json["species"]!,
        gender: json["gender"]!,
        house: json["house"]!,
        dateOfBirth: json["dateOfBirth"],
        yearOfBirth: json["yearOfBirth"],
        wizard: json["wizard"],
        ancestry: json["ancestry"]!,
        eyeColour: json["eyeColour"]!,
        hairColour: json["hairColour"]!,
        wand: Wand.fromMap(json["wand"]),
        patronus: json["patronus"]!,
        hogwartsStudent: json["hogwartsStudent"],
        hogwartsStaff: json["hogwartsStaff"],
        actor: json["actor"],
        alternateActors:
            List<String>.from(json["alternate_actors"].map((x) => x)),
        alive: json["alive"],
        image: json["image"],
      );
}

class Wand {
  Wood wood;
  Core core;
  double? length;

  Wand({
    required this.wood,
    required this.core,
    required this.length,
  });

  factory Wand.fromJson(String str) => Wand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Wand.fromMap(Map<String, dynamic> json) => Wand(
        wood: woodValues.map[json["wood"]]!,
        core: coreValues.map[json["core"]]!,
        length: json["length"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "wood": woodValues.reverse[wood],
        "core": coreValues.reverse[core],
        "length": length,
      };
}

enum Core {
  DRAGON_HEARTSTRING,
  EMPTY,
  PHOENIX_TAIL_FEATHER,
  UNICORN_HAIR,
  UNICORN_TAIL_HAIR
}

final coreValues = EnumValues({
  "dragon heartstring": Core.DRAGON_HEARTSTRING,
  "": Core.EMPTY,
  "phoenix tail feather": Core.PHOENIX_TAIL_FEATHER,
  "unicorn hair": Core.UNICORN_HAIR,
  "unicorn tail hair": Core.UNICORN_TAIL_HAIR
});

enum Wood { ASH, CHERRY, EMPTY, HAWTHORN, HOLLY, VINE, WILLOW, YEW }

final woodValues = EnumValues({
  "ash": Wood.ASH,
  "cherry": Wood.CHERRY,
  "": Wood.EMPTY,
  "hawthorn": Wood.HAWTHORN,
  "holly": Wood.HOLLY,
  "vine": Wood.VINE,
  "willow": Wood.WILLOW,
  "yew": Wood.YEW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
