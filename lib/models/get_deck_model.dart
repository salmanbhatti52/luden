// To parse this JSON data, do
//
//     final getDeckModel = getDeckModelFromJson(jsonString);

import 'dart:convert';

GetDeckModel getDeckModelFromJson(String str) => GetDeckModel.fromJson(json.decode(str));

String getDeckModelToJson(GetDeckModel data) => json.encode(data.toJson());

class GetDeckModel {
  String? status;
  List<Datum>? data;

  GetDeckModel({
    this.status,
    this.data,
  });

  factory GetDeckModel.fromJson(Map<String, dynamic> json) => GetDeckModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? usersCustomersAlbumsId;
  int? usersCustomersId;
  String? name;
  DateTime? addedDate;
  String? status;
  int? countAlbumPictures;
  List<Deck>? deck;

  Datum({
    this.usersCustomersAlbumsId,
    this.usersCustomersId,
    this.name,
    this.addedDate,
    this.status,
    this.countAlbumPictures,
    this.deck,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    usersCustomersAlbumsId: json["users_customers_albums_id"],
    usersCustomersId: json["users_customers_id"],
    name: json["name"],
    addedDate: DateTime.parse(json["added_date"]),
    status: json["status"],
    countAlbumPictures: json["count_album_pictures"],
    deck: List<Deck>.from(json["deck"].map((x) => Deck.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users_customers_albums_id": usersCustomersAlbumsId,
    "users_customers_id": usersCustomersId,
    "name": name,
    "added_date": addedDate!.toIso8601String(),
    "status": status,
    "count_album_pictures": countAlbumPictures,
    "deck": List<dynamic>.from(deck!.map((x) => x.toJson())),
  };
}

class Deck {
  int? usersCustomersDecksId;
  int? usersCustomersAlbumsId;
  String? name;
  String? albumPicture;
  DateTime? addedDate;
  String? status;
  Signature? signature;

  Deck({
    this.usersCustomersDecksId,
    this.usersCustomersAlbumsId,
    this.name,
    this.albumPicture,
    this.addedDate,
    this.status,
    this.signature,
  });

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
    usersCustomersDecksId: json["users_customers_decks_id"],
    usersCustomersAlbumsId: json["users_customers_albums_id"],
    name: json["name"],
    albumPicture: json["album_picture"],
    addedDate: DateTime.parse(json["added_date"]),
    status: json["status"],
    // signature: Signature.fromJson(json["signature"]),
    signature : json["signature"] != null ? Signature.fromJson(json["signature"]) : null,




  );

  Map<String, dynamic> toJson() => {
    "users_customers_decks_id": usersCustomersDecksId,
    "users_customers_albums_id": usersCustomersAlbumsId,
    "name": name,
    "album_picture": albumPicture,
    "added_date": addedDate!.toIso8601String(),
    "status": status,
    "signature": signature!.toJson(),
  };
}

class Signature {
  int? signatureDecksId;
  int? usersCustomersId;
  int? usersCustomersDecksId;
  int? signaturesId;
  DateTime? addedDate;
  String? status;
  dynamic signatureDetail;

  Signature({
    this.signatureDecksId,
    this.usersCustomersId,
    this.usersCustomersDecksId,
    this.signaturesId,
    this.addedDate,
    this.status,
    this.signatureDetail,
  });

  factory Signature.fromJson(Map<String, dynamic> json) => Signature(
    signatureDecksId: json["signature_decks_id"],
    usersCustomersId: json["users_customers_id"],
    usersCustomersDecksId: json["users_customers_decks_id"],
    signaturesId: json["signatures_id"],
    addedDate: DateTime.parse(json["added_date"]),
    status: json["status"],
    signatureDetail: json["signature_detail"],
  );

  Map<String, dynamic> toJson() => {
    "signature_decks_id": signatureDecksId,
    "users_customers_id": usersCustomersId,
    "users_customers_decks_id": usersCustomersDecksId,
    "signatures_id": signaturesId,
    "added_date": addedDate!.toIso8601String(),
    "status": status,
    "signature_detail": signatureDetail,
  };
}
