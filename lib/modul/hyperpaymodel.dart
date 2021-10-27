// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.result,
    required this.buildNumber,
    required this.timestamp,
    required this.ndc,
    required this.id,
  });

  final Result result;
  final String buildNumber;
  final String timestamp;
  final String ndc;
  final String id;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        result: Result.fromJson(json["result"]),
        buildNumber: json["buildNumber"],
        timestamp: json["timestamp"],
        ndc: json["ndc"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "buildNumber": buildNumber,
        "timestamp": timestamp,
        "ndc": ndc,
        "id": id,
      };
}

class Result {
  Result({
    required this.code,
    required this.description,
  });

  final String code;
  final String description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
