// To parse this JSON data, do
//
//     final loungeDetailsModel = loungeDetailsModelFromJson(jsonString);

import 'dart:convert';

LoungeDetailsModel loungeDetailsModelFromJson(String str) =>
    LoungeDetailsModel.fromJson(json.decode(str));

String loungeDetailsModelToJson(LoungeDetailsModel data) =>
    json.encode(data.toJson());

class LoungeDetailsModel {
  int code;
  String message;
  LoungeDetailsDataModel data;

  LoungeDetailsModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoungeDetailsModel.fromJson(Map<String, dynamic> json) =>
      LoungeDetailsModel(
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
  int capacity;
  int dinner;
  int dinnerPrice;
  int mixed;
  int mixedPrice;
  List<ActiveTime> activeTimes;
  String name;
  String address;

  LoungeDetailsDataModel({
    required this.id,
    required this.photos,
    required this.rate,
    required this.services,
    required this.capacity,
    required this.dinner,
    required this.dinnerPrice,
    required this.mixed,
    required this.mixedPrice,
    required this.activeTimes,
    required this.name,
    required this.address,
  });

  factory LoungeDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      LoungeDetailsDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        capacity: json["capacity"],
        dinner: json["dinner"],
        dinnerPrice: json["dinner_price"],
        mixed: json["mixed"],
        mixedPrice: json["mixed_price"],
        activeTimes: List<ActiveTime>.from(
            json["active_times"].map((x) => ActiveTime.fromJson(x))),
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rate": rate,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "capacity": capacity,
        "dinner": dinner,
        "dinner_price": dinnerPrice,
        "mixed": mixed,
        "mixed_price": mixedPrice,
        "active_times": List<dynamic>.from(activeTimes.map((x) => x.toJson())),
        "name": name,
      };
}

class ActiveTime {
  String startTime;
  String endTime;

  ActiveTime({
    required this.startTime,
    required this.endTime,
  });

  factory ActiveTime.fromJson(Map<String, dynamic> json) => ActiveTime(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
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
