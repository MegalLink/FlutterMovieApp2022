import 'dart:convert';

import 'package:flutter_movie_app/models/models.dart';

class CreditsResponse {
  CreditsResponse({
    required this.cast,
    required this.id,
  });

  int id;
  List<Cast> cast;

  factory CreditsResponse.fromJson(String str) =>
      CreditsResponse.fromMap(json.decode(str));
  factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        id: json["id"],
      );
}
