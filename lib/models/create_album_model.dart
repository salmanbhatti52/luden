// To parse this JSON data, do
//
//     final createAlbumModel = createAlbumModelFromJson(jsonString);

import 'dart:convert';

CreateAlbumModel createAlbumModelFromJson(String str) => CreateAlbumModel.fromJson(json.decode(str));

String createAlbumModelToJson(CreateAlbumModel data) => json.encode(data.toJson());

class CreateAlbumModel {
    String? status;
    String? message;
    Data? data;

    CreateAlbumModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreateAlbumModel.fromJson(Map<String, dynamic> json) => CreateAlbumModel(
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
    int? usersCustomersAlbumsId;
    int? usersCustomersId;
    String? name;
    DateTime? addedDate;
    String? status;

    Data({
        this.usersCustomersAlbumsId,
        this.usersCustomersId,
        this.name,
        this.addedDate,
        this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
