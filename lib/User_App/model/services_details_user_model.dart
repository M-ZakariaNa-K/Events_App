// To parse this JSON data, do
//
//     final servicesDetailsUserModel = servicesDetailsUserModelFromJson(jsonString);

import 'dart:convert';

ServicesDetailsUserModel servicesDetailsUserModelFromJson(String str) => ServicesDetailsUserModel.fromJson(json.decode(str));

String servicesDetailsUserModelToJson(ServicesDetailsUserModel data) => json.encode(data.toJson());

class ServicesDetailsUserModel {
    int code;
    String message;
    ServicesDetailsUserDataModel data;

    ServicesDetailsUserModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ServicesDetailsUserModel.fromJson(Map<String, dynamic> json) => ServicesDetailsUserModel(
        code: json["code"],
        message: json["message"],
        data: ServicesDetailsUserDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class ServicesDetailsUserDataModel {
    int id;
    List<String> photos;
    int rate;
    List<Service> services;
    bool isFavorite;
    String startTime;
    String endTime;

    ServicesDetailsUserDataModel({
        required this.id,
        required this.photos,
        required this.rate,
        required this.services,
        required this.isFavorite,
        required this.startTime,
        required this.endTime,
    });

    factory ServicesDetailsUserDataModel.fromJson(Map<String, dynamic> json) => ServicesDetailsUserDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        isFavorite: json["is_favorite"],
        startTime: json["start_time"],
        endTime: json["end_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rate": rate,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "is_favorite": isFavorite,
        "start_time": startTime,
        "end_time": endTime,
    };
}

class Service {
    int id;
    String name;
    String kind;
    String price;
    dynamic discountedPrice;

    Service({
        required this.id,
        required this.name,
        required this.kind,
        required this.price,
        required this.discountedPrice,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        kind: json["kind"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kind": kind,
        "price": price,
        "discounted_price": discountedPrice,
    };
}
