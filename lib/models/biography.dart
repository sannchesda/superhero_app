import 'package:superhero_app/utils/functions.dart';

class Biography {
  String? fullName;
  String? alterEgos;
  List<String>? aliases;
  String? placeOfBirth;
  String? firstAppearance;
  String? publisher;
  String? alignment;

  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  String get aliasesString {
    return listStringToString(aliases ?? []);
  }

  factory Biography.fromJson(Map<String, dynamic> json) => Biography(
        fullName: json["fullName"],
        alterEgos: json["alterEgos"],
        aliases: json["aliases"] == null
            ? []
            : List<String>.from(json["aliases"]!.map((x) => x)),
        placeOfBirth: json["placeOfBirth"],
        firstAppearance: json["firstAppearance"],
        publisher: json["publisher"],
        alignment: json["alignment"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "alterEgos": alterEgos,
        "aliases":
            aliases == null ? [] : List<dynamic>.from(aliases!.map((x) => x)),
        "placeOfBirth": placeOfBirth,
        "firstAppearance": firstAppearance,
        "publisher": publisher,
        "alignment": alignment,
      };
}
