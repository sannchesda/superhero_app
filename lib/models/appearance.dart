class Appearance {
  String? gender;
  String? race;
  List<String>? height;
  List<String>? weight;
  String? eyeColor;
  String? hairColor;

  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) => Appearance(
        gender: json["gender"],
        race: json["race"],
        height: json["height"] == null
            ? []
            : List<String>.from(json["height"]!.map((x) => x)),
        weight: json["weight"] == null
            ? []
            : List<String>.from(json["weight"]!.map((x) => x)),
        eyeColor: json["eyeColor"],
        hairColor: json["hairColor"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "race": race,
        "height":
            height == null ? [] : List<dynamic>.from(height!.map((x) => x)),
        "weight":
            weight == null ? [] : List<dynamic>.from(weight!.map((x) => x)),
        "eyeColor": eyeColor,
        "hairColor": hairColor,
      };
}
