// To parse this JSON data, do
//
//     final servicesHomepageModel = servicesHomepageModelFromJson(jsonString);

import 'dart:convert';

ServicesHomepageModel servicesHomepageModelFromJson(String str) => ServicesHomepageModel.fromJson(json.decode(str));

String servicesHomepageModelToJson(ServicesHomepageModel data) => json.encode(data.toJson());

class ServicesHomepageModel {
    int code;
    String message;
    List<ServicesHomepageDataModel> data;

    ServicesHomepageModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ServicesHomepageModel.fromJson(Map<String, dynamic> json) => ServicesHomepageModel(
        code: json["code"],
        message: json["message"],
        data: List<ServicesHomepageDataModel>.from(json["data"].map((x) => ServicesHomepageDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ServicesHomepageDataModel {
    int id;
    String name;
    String kind;
    String price;
    dynamic discountedPrice;

    ServicesHomepageDataModel({
        required this.id,
        required this.name,
        required this.kind,
        required this.price,
        required this.discountedPrice,
    });

    factory ServicesHomepageDataModel.fromJson(Map<String, dynamic> json) => ServicesHomepageDataModel(
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
