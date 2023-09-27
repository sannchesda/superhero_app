// To parse this JSON data, do
//
//     final superhero = superheroFromJson(jsonString);

import 'dart:convert';

import 'package:superhero_app/models/appearance.dart';
import 'package:superhero_app/models/biography.dart';
import 'package:superhero_app/models/connections.dart';
import 'package:superhero_app/models/powerstats.dart';
import 'package:superhero_app/models/superhero_image.dart';
import 'package:superhero_app/models/work.dart';

List<Superhero> superheroFromJson(String str) =>
    List<Superhero>.from(json.decode(str).map((x) => Superhero.fromJson(x)));

String superheroToJson(List<Superhero> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Superhero {
  int? id;
  String? name;
  String? slug;
  Powerstats? powerstats;
  Appearance? appearance;
  Biography? biography;
  Work? work;
  Connections? connections;
  SuperheroImages? images;

  Superhero({
    this.id,
    this.name,
    this.slug,
    this.powerstats,
    this.appearance,
    this.biography,
    this.work,
    this.connections,
    this.images,
  });

  factory Superhero.fromJson(Map<String, dynamic> json) => Superhero(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        powerstats: json["powerstats"] == null
            ? null
            : Powerstats.fromJson(json["powerstats"]),
        appearance: json["appearance"] == null
            ? null
            : Appearance.fromJson(json["appearance"]),
        biography: json["biography"] == null
            ? null
            : Biography.fromJson(json["biography"]),
        work: json["work"] == null ? null : Work.fromJson(json["work"]),
        connections: json["connections"] == null
            ? null
            : Connections.fromJson(json["connections"]),
        images: json["images"] == null
            ? null
            : SuperheroImages.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "powerstats": powerstats?.toJson(),
        "appearance": appearance?.toJson(),
        "biography": biography?.toJson(),
        "work": work?.toJson(),
        "connections": connections?.toJson(),
        "images": images?.toJson(),
      };
}
