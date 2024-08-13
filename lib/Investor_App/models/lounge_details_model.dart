// To parse this JSON data, do
//
//     final loungeDetailsModel = loungeDetailsModelFromJson(jsonString);

import 'dart:convert';

LoungeDetailsModel loungeDetailsModelFromJson(String str) => LoungeDetailsModel.fromJson(json.decode(str));

String loungeDetailsModelToJson(LoungeDetailsModel data) => json.encode(data.toJson());

class LoungeDetailsModel {
    int code;
    String message;
    LoungeDetailsDataModel data;

    LoungeDetailsModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory LoungeDetailsModel.fromJson(Map<String, dynamic> json) => LoungeDetailsModel(
        code: json["code"],
        message: json["message"],
        data: LoungeDetailsDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class LoungeDetailsDataModel {
    int id;
    List<String> photos;
    int rate;
    List<Service> services;
    bool isFavorite;
    int capacity;
    int dinner;
    String dinnerPrice;
    int mixed;
    String address;
    String mixedPrice;
    List<ActiveTime> activeTimes;
    String arName;
    String enName;

    LoungeDetailsDataModel({
        required this.id,
        required this.photos,
        required this.rate,
        required this.services,
        required this.isFavorite,
        required this.capacity,
        required this.dinner,
        required this.dinnerPrice,
        required this.mixed,
        required this.address,
        required this.mixedPrice,
        required this.activeTimes,
        required this.arName,
        required this.enName,
    });

    factory LoungeDetailsDataModel.fromJson(Map<String, dynamic> json) => LoungeDetailsDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        isFavorite: json["is_favorite"],
        capacity: json["capacity"],
        dinner: json["dinner"],
        dinnerPrice: json["dinner_price"],
        mixed: json["mixed"],
        address: json["address"],
        mixedPrice: json["mixed_price"],
        activeTimes: List<ActiveTime>.from(json["active_times"].map((x) => ActiveTime.fromJson(x))),
        arName: json["ar_name"],
        enName: json["en_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rate": rate,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "is_favorite": isFavorite,
        "capacity": capacity,
        "dinner": dinner,
        "dinner_price": dinnerPrice,
        "mixed": mixed,
        "address": address,
        "mixed_price": mixedPrice,
        "active_times": List<dynamic>.from(activeTimes.map((x) => x.toJson())),
        "ar_name": arName,
        "en_name": enName,
    };
}

class ActiveTime {
    int id;
    String startTime;
    String endTime;

    ActiveTime({
        required this.id,
        required this.startTime,
        required this.endTime,
    });

    factory ActiveTime.fromJson(Map<String, dynamic> json) => ActiveTime(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
    dynamic proportion;

    Service({
        required this.id,
        required this.name,
        required this.kind,
        required this.price,
        required this.discountedPrice,
        required this.proportion,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        kind: json["kind"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        proportion: json["proportion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kind": kind,
        "price": price,
        "discounted_price": discountedPrice,
        "proportion": proportion,
    };
}
