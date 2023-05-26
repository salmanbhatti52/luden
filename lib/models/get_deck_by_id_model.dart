// To parse this JSON data, do
//
//     final getDecksByIdModel = getDecksByIdModelFromJson(jsonString);

import 'dart:convert';

GetDecksByIdModel getDecksByIdModelFromJson(String str) => GetDecksByIdModel.fromJson(json.decode(str));

String getDecksByIdModelToJson(GetDecksByIdModel data) => json.encode(data.toJson());

class GetDecksByIdModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetDecksByIdModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetDecksByIdModel.fromJson(Map<String, dynamic> json) => GetDecksByIdModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? usersCustomersDecksId;
  int? usersCustomersAlbumsId;
  String? name;
  String? albumPicture;
  DateTime? addedDate;
  String? status;
  dynamic signature;

  Datum({
    this.usersCustomersDecksId,
    this.usersCustomersAlbumsId,
    this.name,
    this.albumPicture,
    this.addedDate,
    this.status,
    this.signature,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    usersCustomersDecksId: json["users_customers_decks_id"],
    usersCustomersAlbumsId: json["users_customers_albums_id"],
    name: json["name"],
    albumPicture: json["album_picture"],
    addedDate: DateTime.parse(json["added_date"]),
    status: json["status"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "users_customers_decks_id": usersCustomersDecksId,
    "users_customers_albums_id": usersCustomersAlbumsId,
    "name": name,
    "album_picture": albumPicture,
    "added_date": addedDate!.toIso8601String(),
    "status": status,
    "signature": signature,
  };
}


// // To parse this JSON data, do
// //
// //     final getDecksByIdModel = getDecksByIdModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetDecksByIdModel getDecksByIdModelFromJson(String str) => GetDecksByIdModel.fromJson(json.decode(str));
//
// String getDecksByIdModelToJson(GetDecksByIdModel data) => json.encode(data.toJson());
//
// class GetDecksByIdModel {
//   String? status;
//   String? message;
//   List<Datum>? data;
//
//   GetDecksByIdModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory GetDecksByIdModel.fromJson(Map<String, dynamic> json) => GetDecksByIdModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int? usersCustomersDecksId;
//   int? usersCustomersAlbumsId;
//   String? name;
//   String? albumPicture;
//   DateTime? addedDate;
//   String? status;
//   Signature? signature;
//
//   Datum({
//     this.usersCustomersDecksId,
//     this.usersCustomersAlbumsId,
//     this.name,
//     this.albumPicture,
//     this.addedDate,
//     this.status,
//     this.signature,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     usersCustomersDecksId: json["users_customers_decks_id"],
//     usersCustomersAlbumsId: json["users_customers_albums_id"],
//     name: json["name"],
//     albumPicture: json["album_picture"],
//     addedDate: DateTime.parse(json["added_date"]),
//     status: json["status"],
//     signature: Signature.fromJson(json["signature"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "users_customers_decks_id": usersCustomersDecksId,
//     "users_customers_albums_id": usersCustomersAlbumsId,
//     "name": name,
//     "album_picture": albumPicture,
//     "added_date": addedDate!.toIso8601String(),
//     "status": status,
//     "signature": signature!.toJson(),
//   };
// }
//
// class Signature {
//   int? signatureDecksId;
//   int? usersCustomersId;
//   int? usersCustomersDecksId;
//   DateTime? addedDate;
//   String? status;
//
//   Signature({
//     this.signatureDecksId,
//     this.usersCustomersId,
//     this.usersCustomersDecksId,
//     this.addedDate,
//     this.status,
//   });
//
//   factory Signature.fromJson(Map<String, dynamic> json) => Signature(
//     signatureDecksId: json["signature_decks_id"],
//     usersCustomersId: json["users_customers_id"],
//     usersCustomersDecksId: json["users_customers_decks_id"],
//     addedDate: DateTime.parse(json["added_date"]),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "signature_decks_id": signatureDecksId,
//     "users_customers_id": usersCustomersId,
//     "users_customers_decks_id": usersCustomersDecksId,
//     "added_date": addedDate!.toIso8601String(),
//     "status": status,
//   };
// }


// // To parse this JSON data, do
// //
// //     final getDecksByIdModel = getDecksByIdModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetDecksByIdModel getDecksByIdModelFromJson(String str) => GetDecksByIdModel.fromJson(json.decode(str));
//
// String getDecksByIdModelToJson(GetDecksByIdModel data) => json.encode(data.toJson());
//
// class GetDecksByIdModel {
//   String? status;
//   String? message;
//   List<Datum>? data;
//
//   GetDecksByIdModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory GetDecksByIdModel.fromJson(Map<String, dynamic> json) => GetDecksByIdModel(
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))): null,
//     // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int? usersCustomersDecksId;
//   int? usersCustomersAlbumsId;
//   String? name;
//   String? albumPicture;
//   DateTime? addedDate;
//   String? status;
//
//   Datum({
//     this.usersCustomersDecksId,
//     this.usersCustomersAlbumsId,
//     this.name,
//     this.albumPicture,
//     this.addedDate,
//     this.status,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     usersCustomersDecksId: json["users_customers_decks_id"],
//     usersCustomersAlbumsId: json["users_customers_albums_id"],
//     name: json["name"],
//     albumPicture: json["album_picture"],
//     addedDate: DateTime.parse(json["added_date"]),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "users_customers_decks_id": usersCustomersDecksId,
//     "users_customers_albums_id": usersCustomersAlbumsId,
//     "name": name,
//     "album_picture": albumPicture,
//     "added_date": addedDate!.toIso8601String(),
//     "status": status,
//   };
// }
