// To parse this JSON data, do
//
//     final addSignatureDeck = addSignatureDeckFromJson(jsonString);

import 'dart:convert';

AddSignatureDeck addSignatureDeckFromJson(String str) =>
    AddSignatureDeck.fromJson(json.decode(str));

String addSignatureDeckToJson(AddSignatureDeck data) =>
    json.encode(data.toJson());

class AddSignatureDeck {
  String? status;
  String? message;
  Data? data;

  AddSignatureDeck({
    this.status,
    this.message,
    this.data,
  });

  factory AddSignatureDeck.fromJson(Map<String, dynamic> json) =>
      AddSignatureDeck(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        // data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? signatureDecksId;
  int? usersCustomersId;
  int? usersCustomersDecksId;
  int? signaturesId;
  DateTime? addedDate;
  String? status;

  Data({
    this.signatureDecksId,
    this.usersCustomersId,
    this.usersCustomersDecksId,
    this.signaturesId,
    this.addedDate,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        signatureDecksId: json["signature_decks_id"],
        usersCustomersId: json["users_customers_id"],
        usersCustomersDecksId: json["users_customers_decks_id"],
        signaturesId: json["signatures_id"],
        addedDate: DateTime.parse(json["added_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "signature_decks_id": signatureDecksId,
        "users_customers_id": usersCustomersId,
        "users_customers_decks_id": usersCustomersDecksId,
        "signatures_id": signaturesId,
        "added_date": addedDate!.toIso8601String(),
        "status": status,
      };
}
