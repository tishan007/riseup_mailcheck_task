// To parse this JSON data, do
//
//     final createAccountError = createAccountErrorFromJson(jsonString);

import 'dart:convert';

CreateAccountError createAccountErrorFromJson(String str) => CreateAccountError.fromJson(json.decode(str));

String createAccountErrorToJson(CreateAccountError data) => json.encode(data.toJson());

class CreateAccountError {
  CreateAccountError({
    required this.context,
    required this.type,
    required this.hydraTitle,
    required this.hydraDescription,
    required this.violations,
  });

  dynamic context;
  dynamic type;
  String hydraTitle;
  String hydraDescription;
  List<Violation> violations;

  factory CreateAccountError.fromJson(Map<String, dynamic> json) => CreateAccountError(
    context: json["context"],
    type: json["type"],
    hydraTitle: json["hydra:title"],
    hydraDescription: json["hydra:description"],
    violations: List<Violation>.from(json["violations"].map((x) => Violation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "context": context,
    "type": type,
    "hydra:title": hydraTitle,
    "hydra:description": hydraDescription,
    "violations": List<dynamic>.from(violations.map((x) => x.toJson())),
  };
}

class Violation {
  Violation({
    required this.propertyPath,
    required this.message,
    required this.code,
  });

  String propertyPath;
  String message;
  String code;

  factory Violation.fromJson(Map<String, dynamic> json) => Violation(
    propertyPath: json["propertyPath"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "propertyPath": propertyPath,
    "message": message,
    "code": code,
  };
}
