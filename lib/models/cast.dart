// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

class Cast {
  Cast({
    required this.adult,
    required this.creditId,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.castId,
    this.character,
    this.department,
    this.job,
    this.order,
    this.profilePath,
  });

  bool adult;
  double popularity;
  int gender;
  int id;
  int? castId;
  int? order;
  String creditId;
  String knownForDepartment;
  String name;
  String originalName;
  String? character;
  String? department;
  String? job;
  String? profilePath;

  String getFullPosterImage() {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }

    return 'https://i.stack.imgur.com/GNhx0.png';
  }

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));
  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        castId: json["cast_id"] ?? null,
        character: json["character"] ?? null,
        creditId: json["credit_id"],
        department: json["department"] ?? null,
        gender: json["gender"],
        id: json["id"],
        job: json["job"] ?? null,
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        order: json["order"] ?? null,
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] ?? null,
      );
}
