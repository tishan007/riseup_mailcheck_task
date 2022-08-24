// To parse this JSON data, do
//
//     final createAccount = createAccountFromJson(jsonString);

import 'dart:convert';

CreateAccount createAccountFromJson(String str) => CreateAccount.fromJson(json.decode(str));

String createAccountToJson(CreateAccount data) => json.encode(data.toJson());

class CreateAccount {
  CreateAccount({
    required this.context,
    required this.id,
    required this.type,
    required this.createAccountId,
    required this.address,
    required this.quota,
    required this.used,
    required this.isDisabled,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic context;
  dynamic id;
  dynamic type;
  String createAccountId;
  String address;
  int quota;
  int used;
  bool isDisabled;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory CreateAccount.fromJson(Map<String, dynamic> json) => CreateAccount(
    context: json["context"],
    id: json["id"],
    type: json["type"],
    createAccountId: json["id"],
    address: json["address"],
    quota: json["quota"],
    used: json["used"],
    isDisabled: json["isDisabled"],
    isDeleted: json["isDeleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "context": context,
    "id": id,
    "type": type,
    "id": createAccountId,
    "address": address,
    "quota": quota,
    "used": used,
    "isDisabled": isDisabled,
    "isDeleted": isDeleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
