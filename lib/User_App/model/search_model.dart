import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  int code;
  String message;
  List<SearchDataModel> data;

  SearchModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        code: json["code"],
        message: json["message"],
        data: List<SearchDataModel>.from(
            json["data"].map((x) => SearchDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SearchDataModel {
  int id;
  List<String> photos;
  int rate;
  List<Service> services;
  bool isFavorite;
  int? capacity;
  int? dinner;
  String? dinnerPrice;
  int? mixed;
  String? address;
  String? mixedPrice;
  List<ActiveTime>? activeTimes;
  String? name;
  String? startTime;
  String? endTime;

  SearchDataModel({
    required this.id,
    required this.photos,
    required this.rate,
    required this.services,
    required this.isFavorite,
    this.capacity,
    this.dinner,
    this.dinnerPrice,
    this.mixed,
    this.address,
    this.mixedPrice,
    this.activeTimes,
    this.name,
    this.startTime,
    this.endTime,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> json) =>
      SearchDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        isFavorite: json["is_favorite"],
        capacity: json["capacity"],
        dinner: json["dinner"],
        dinnerPrice: json["dinner_price"],
        mixed: json["mixed"],
        address: json["address"],
        mixedPrice: json["mixed_price"],
        activeTimes: json["active_times"] == null
            ? []
            : List<ActiveTime>.from(
                json["active_times"]!.map((x) => ActiveTime.fromJson(x))),
        name: json["name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
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
        "active_times": activeTimes == null
            ? []
            : List<dynamic>.from(activeTimes!.map((x) => x.toJson())),
        "name": name,
        "start_time": startTime,
        "end_time": endTime,
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
  int? proportion;

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
