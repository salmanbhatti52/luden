// To parse this JSON data, do
//
//     final getAllSignatures = getAllSignaturesFromJson(jsonString);

import 'dart:convert';

GetAllSignatures getAllSignaturesFromJson(String str) =>
    GetAllSignatures.fromJson(json.decode(str));

String getAllSignaturesToJson(GetAllSignatures data) =>
    json.encode(data.toJson());

class GetAllSignatures {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllSignatures({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllSignatures.fromJson(Map<String, dynamic> json) =>
      GetAllSignatures(
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
  int? signaturesId;
  String? name;
  String? signatureImage;
  DateTime? addedDate;
  String? status;

  Datum({
    this.signaturesId,
    this.name,
    this.signatureImage,
    this.addedDate,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        signaturesId: json["signatures_id"],
        name: json["name"],
        signatureImage: json["signature_image"],
        addedDate: DateTime.parse(json["added_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "signatures_id": signaturesId,
        "name": name,
        "signature_image": signatureImage,
        "added_date": addedDate!.toIso8601String(),
        "status": status,
      };
}
