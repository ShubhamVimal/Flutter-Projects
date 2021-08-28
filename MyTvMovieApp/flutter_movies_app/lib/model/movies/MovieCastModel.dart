// To parse this JSON data, do
//
//     final movieCastModel = movieCastModelFromJson(jsonString);

import 'dart:convert';

MovieCastModel movieCastModelFromJson(String str) =>
    MovieCastModel.fromJson(json.decode(str));

String movieCastModelToJson(MovieCastModel data) => json.encode(data.toJson());

class MovieCastModel {
  MovieCastModel({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory MovieCastModel.fromJson(Map<String, dynamic> json) => MovieCastModel(
        id: json["id"] == null ? 0 : json["id"],
        cast: json["cast"] == null
            ? []
            : List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: json["crew"] == null
            ? []
            : List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cast": cast == null
            ? null
            : List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": crew == null
            ? null
            : List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"] == null ? null : json["adult"],
        gender: json["gender"] == null ? null : json["gender"],
        id: json["id"] == null ? null : json["id"],
        knownForDepartment: json["known_for_department"] == null
            ? ''
            : json["known_for_department"],
        name: json["name"] == null ? null : json["name"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? '' : json["profile_path"],
        castId: json["cast_id"] == null ? 0 : json["cast_id"],
        character: json["character"] == null ? '' : json["character"],
        creditId: json["credit_id"] == null ? null : json["credit_id"],
        order: json["order"] == null ? 0 : json["order"],
        department: json["department"] == null ? '' : json["department"],
        job: json["job"] == null ? '' : json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "gender": gender == null ? null : gender,
        "id": id == null ? null : id,
        "known_for_department":
            knownForDepartment == null ? '' : knownForDepartment,
        "name": name == null ? null : name,
        "original_name": originalName == null ? null : originalName,
        "popularity": popularity == null ? null : popularity,
        "profile_path": profilePath == null ? null : profilePath,
        "cast_id": castId == null ? null : castId,
        "character": character == null ? null : character,
        "credit_id": creditId == null ? null : creditId,
        "order": order == null ? null : order,
        "department": department == null ? '' : department,
        "job": job == null ? null : job,
      };
}
