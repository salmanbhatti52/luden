// To parse this JSON data, do
//
//     final addSignatureDeck = addSignatureDeckFromJson(jsonString);

import 'dart:convert';

AddSignatureDeck2 addSignatureDeck2FromJson(String str) =>
    AddSignatureDeck2.fromJson(json.decode(str));

String addSignatureDeck2ToJson(AddSignatureDeck2 data) =>
    json.encode(data.toJson());

class AddSignatureDeck2 {
  String? status;
  String? message;
  Data? data;

  AddSignatureDeck2({
    this.status,
    this.message,
    this.data,
  });

  factory AddSignatureDeck2.fromJson(Map<String, dynamic> json) =>
      AddSignatureDeck2(
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
  String? usersCustomersId;
  String? usersCustomersDecksId;
  String? signaturesId;
  String? addedDate;
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
        addedDate: json["added_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "signature_decks_id": signatureDecksId,
        "users_customers_id": usersCustomersId,
        "users_customers_decks_id": usersCustomersDecksId,
        "signatures_id": signaturesId,
        "added_date": addedDate,
        "status": status,
      };
}
