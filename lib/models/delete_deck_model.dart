// To parse this JSON data, do
//
//     final deleteDeckModel = deleteDeckModelFromJson(jsonString);

import 'dart:convert';

DeleteDeckModel deleteDeckModelFromJson(String str) =>
    DeleteDeckModel.fromJson(json.decode(str));

String deleteDeckModelToJson(DeleteDeckModel data) =>
    json.encode(data.toJson());

class DeleteDeckModel {
  String? status;
  String? message;
  String? data;

  DeleteDeckModel({
    this.status,
    this.message,
    this.data,
  });

  factory DeleteDeckModel.fromJson(Map<String, dynamic> json) =>
      DeleteDeckModel(
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
