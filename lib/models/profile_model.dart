// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? status;
  String? message;
  Data? data;

  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  int? usersCustomersId;
  String? oneSignalId;
  String? fullName;
  String? username;
  dynamic phone;
  DateTime? dob;
  String? favoriteSportsTeam;
  dynamic systemCountriesId;
  dynamic systemStatesId;
  dynamic location;
  dynamic longitude;
  dynamic lattitude;
  String? email;
  String? password;
  dynamic profilePic;
  String? notifications;
  String? accountType;
  String? socialAccType;
  String? googleAccessToken;
  String? verifyCode;
  String? verifiedBadge;
  DateTime? dateAdded;
  String? status;

  Data({
    this.usersCustomersId,
    this.oneSignalId,
    this.fullName,
    this.username,
    this.phone,
    this.dob,
    this.favoriteSportsTeam,
    this.systemCountriesId,
    this.systemStatesId,
    this.location,
    this.longitude,
    this.lattitude,
    this.email,
    this.password,
    this.profilePic,
    this.notifications,
    this.accountType,
    this.socialAccType,
    this.googleAccessToken,
    this.verifyCode,
    this.verifiedBadge,
    this.dateAdded,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersCustomersId: json["users_customers_id"],
        oneSignalId: json["one_signal_id"],
        fullName: json["full_name"],
        username: json["username"],
        phone: json["phone"],
        dob: DateTime.parse(json["dob"]),
        favoriteSportsTeam: json["favorite_sports_team"],
        systemCountriesId: json["system_countries_id"],
        systemStatesId: json["system_states_id"],
        location: json["location"],
        longitude: json["longitude"],
        lattitude: json["lattitude"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profile_pic"],
        notifications: json["notifications"],
        accountType: json["account_type"],
        socialAccType: json["social_acc_type"],
        googleAccessToken: json["google_access_token"],
        verifyCode: json["verify_code"],
        verifiedBadge: json["verified_badge"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "users_customers_id": usersCustomersId,
        "one_signal_id": oneSignalId,
        "full_name": fullName,
        "username": username,
        "phone": phone,
        "dob": dob!.toIso8601String(),
        "favorite_sports_team": favoriteSportsTeam,
        "system_countries_id": systemCountriesId,
        "system_states_id": systemStatesId,
        "location": location,
        "longitude": longitude,
        "lattitude": lattitude,
        "email": email,
        "password": password,
        "profile_pic": profilePic,
        "notifications": notifications,
        "account_type": accountType,
        "social_acc_type": socialAccType,
        "google_access_token": googleAccessToken,
        "verify_code": verifyCode,
        "verified_badge": verifiedBadge,
        "date_added": dateAdded!.toIso8601String(),
        "status": status,
      };
}
