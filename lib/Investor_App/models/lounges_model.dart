import 'dart:convert';

LoungesModel loungesModelFromJson(String str) =>
    LoungesModel.fromJson(json.decode(str));

String loungesModelToJson(LoungesModel data) => json.encode(data.toJson());

class LoungesModel {
  int code;
  String message;
  List<LoungesDataModel> data;

  LoungesModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoungesModel.fromJson(Map<String, dynamic> json) => LoungesModel(
        code: json["code"],
        message: json["message"],
        data: List<LoungesDataModel>.from(
            json["data"].map((x) => LoungesDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LoungesDataModel {
  int id;
  List<String> photos;
  int rate;
  List<LoungesService> services;
  int capacity;
  int dinner;
  int dinnerPrice;
  int mixed;
  int mixedPrice;
  List<LoungesActiveTime> activeTimes;
  String name;
  String address;

  LoungesDataModel({
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

  factory LoungesDataModel.fromJson(Map<String, dynamic> json) =>
      LoungesDataModel(
          id: json["id"],
          photos: List<String>.from(json["photos"].map((x) => x)),
          rate: json["rate"],
          services: List<LoungesService>.from(
              json["services"].map((x) => LoungesService.fromJson(x))),
          capacity: json["capacity"],
          dinner: json["dinner"],
          dinnerPrice: json["dinner_price"],
          mixed: json["mixed"],
          mixedPrice: json["mixed_price"],
          activeTimes: List<LoungesActiveTime>.from(
              json["active_times"].map((x) => LoungesActiveTime.fromJson(x))),
          name: json["name"],
          address: json["address"]);

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
        "address": address,
      };
}

class LoungesActiveTime {
  String startTime;
  String endTime;

  LoungesActiveTime({
    required this.startTime,
    required this.endTime,
  });

  factory LoungesActiveTime.fromJson(Map<String, dynamic> json) =>
      LoungesActiveTime(
        startTime: json["start_time"],
        endTime: json["end_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
      };
}

class LoungesService {
  int id;
  String name;
  String kind;
  String price;
  dynamic discountedPrice;

  LoungesService({
    required this.id,
    required this.name,
    required this.kind,
    required this.price,
    required this.discountedPrice,
  });

  factory LoungesService.fromJson(Map<String, dynamic> json) => LoungesService(
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
