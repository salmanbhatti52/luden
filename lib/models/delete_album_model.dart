// To parse this JSON data, do
//
//     final deleteAlbumModel = deleteAlbumModelFromJson(jsonString);

import 'dart:convert';

DeleteAlbumModel deleteAlbumModelFromJson(String str) =>
    DeleteAlbumModel.fromJson(json.decode(str));

String deleteAlbumModelToJson(DeleteAlbumModel data) =>
    json.encode(data.toJson());

class DeleteAlbumModel {
  String? status;
  String? message;
  String? data;

  DeleteAlbumModel({
    this.status,
    this.message,
    this.data,
  });

  factory DeleteAlbumModel.fromJson(Map<String, dynamic> json) =>
      DeleteAlbumModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
