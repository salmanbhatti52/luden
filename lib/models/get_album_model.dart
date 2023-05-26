// To parse this JSON data, do
//
//     final getAlbumModel = getAlbumModelFromJson(jsonString);

import 'dart:convert';

GetAlbumModel getAlbumModelFromJson(String str) => GetAlbumModel.fromJson(json.decode(str));

String getAlbumModelToJson(GetAlbumModel data) => json.encode(data.toJson());

class GetAlbumModel {
    String? status;
    List<Datum>? data;

    GetAlbumModel({
        this.status,
        this.data,
    });

    factory GetAlbumModel.fromJson(Map<String, dynamic> json) => GetAlbumModel(
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

    Datum({
        this.usersCustomersAlbumsId,
        this.usersCustomersId,
        this.name,
        this.addedDate,
        this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        usersCustomersAlbumsId: json["users_customers_albums_id"],
        usersCustomersId: json["users_customers_id"],
        name: json["name"],
        addedDate: DateTime.parse(json["added_date"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "users_customers_albums_id": usersCustomersAlbumsId,
        "users_customers_id": usersCustomersId,
        "name": name,
        "added_date": addedDate!.toIso8601String(),
        "status": status,
    };
}
