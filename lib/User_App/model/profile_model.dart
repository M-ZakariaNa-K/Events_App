
import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    int code;
    String message;
    ProfileDataModel data;

    ProfileModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        message: json["message"],
        data: ProfileDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class ProfileDataModel {
    int id;
    String firstName;
    String lastName;
    String username;
    String email;
    String address;
    String phoneNumber;
    dynamic photo;
    dynamic money;

    ProfileDataModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.address,
        required this.phoneNumber,
        required this.photo,
        required this.money,
    });

    factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        photo: json["photo"],
        money: json["money"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "address": address,
        "phone_number": phoneNumber,
        "photo": photo,
        "money": money,
    };
}
