// To parse this JSON data, do
//
//     final createDeckModel = createDeckModelFromJson(jsonString);

import 'dart:convert';

CreateDeckModel createDeckModelFromJson(String str) =>
    CreateDeckModel.fromJson(json.decode(str));

String createDeckModelToJson(CreateDeckModel data) =>
    json.encode(data.toJson());

class CreateDeckModel {
  String? status;
  String? message;
  Data? data;

  CreateDeckModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateDeckModel.fromJson(Map<String, dynamic> json) =>
      CreateDeckModel(
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
  int? usersCustomersDecksId;
  int? usersCustomersAlbumsId;
  String? name;
  String? albumPicture;
  DateTime? addedDate;
  String? status;

  Data({
    this.usersCustomersDecksId,
    this.usersCustomersAlbumsId,
    this.name,
    this.albumPicture,
    this.addedDate,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersCustomersDecksId: json["users_customers_decks_id"],
        usersCustomersAlbumsId: json["users_customers_albums_id"],
        name: json["name"],
        albumPicture: json["album_picture"],
        addedDate: DateTime.parse(json["added_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "users_customers_decks_id": usersCustomersDecksId,
        "users_customers_albums_id": usersCustomersAlbumsId,
        "name": name,
        "album_picture": albumPicture,
        "added_date": addedDate!.toIso8601String(),
        "status": status,
      };
}
