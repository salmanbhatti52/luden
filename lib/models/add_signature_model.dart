// To parse this JSON data, do
//
//     final addSignatureModel = addSignatureModelFromJson(jsonString);

import 'dart:convert';

AddSignatureModel addSignatureModelFromJson(String str) => AddSignatureModel.fromJson(json.decode(str));

String addSignatureModelToJson(AddSignatureModel data) => json.encode(data.toJson());

class AddSignatureModel {
  String? status;
  String? message;
  Data? data;

  AddSignatureModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddSignatureModel.fromJson(Map<String, dynamic> json) => AddSignatureModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  int? signatureDecksId;
  String? usersCustomersId;
  String? usersCustomersDecksId;
  String? addedDate;
  String? status;

  Data({
    this.signatureDecksId,
    this.usersCustomersId,
    this.usersCustomersDecksId,
    this.addedDate,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signatureDecksId: json["signature_decks_id"],
    usersCustomersId: json["users_customers_id"],
    usersCustomersDecksId: json["users_customers_decks_id"],
    addedDate: json["added_date"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "signature_decks_id": signatureDecksId,
    "users_customers_id": usersCustomersId,
    "users_customers_decks_id": usersCustomersDecksId,
    "added_date": addedDate,
    "status": status,
  };
}
