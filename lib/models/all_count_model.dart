// To parse this JSON data, do
//
//     final getAllCountModel = getAllCountModelFromJson(jsonString);

import 'dart:convert';

GetAllCountModel getAllCountModelFromJson(String str) =>
    GetAllCountModel.fromJson(json.decode(str));

String getAllCountModelToJson(GetAllCountModel data) =>
    json.encode(data.toJson());

class GetAllCountModel {
  String? status;
  Data? data;

  GetAllCountModel({
    this.status,
    this.data,
  });

  factory GetAllCountModel.fromJson(Map<String, dynamic> json) =>
      GetAllCountModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  int? totalAlbums;
  int? totalImagesDecks;
  int? totalSignatureImages;

  Data({
    this.totalAlbums,
    this.totalImagesDecks,
    this.totalSignatureImages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalAlbums: json["Total albums"],
        totalImagesDecks: json["Total images/decks"],
        totalSignatureImages: json["Total signature images"],
      );

  Map<String, dynamic> toJson() => {
        "Total albums": totalAlbums,
        "Total images/decks": totalImagesDecks,
        "Total signature images": totalSignatureImages,
      };
}
