import 'dart:convert';

ReservaionFilterModel reservaionFilterModelFromJson(String str) => ReservaionFilterModel.fromJson(json.decode(str));

String reservaionFilterModelToJson(ReservaionFilterModel data) => json.encode(data.toJson());

class ReservaionFilterModel {
    int code;
    String message;
    List<ReservaionFilterDataModel> data;

    ReservaionFilterModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ReservaionFilterModel.fromJson(Map<String, dynamic> json) => ReservaionFilterModel(
        code: json["code"],
        message: json["message"],
        data: List<ReservaionFilterDataModel>.from(json["data"].map((x) => ReservaionFilterDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ReservaionFilterDataModel {
    int id;
    List<String> photos;
    int rate;
    List<Service> services;
    int capacity;
    int dinner;
    int dinnerPrice;
    int mixed;
    String address;
    int mixedPrice;
    List<ActiveTime> activeTimes;
    String name;

    ReservaionFilterDataModel({
        required this.id,
        required this.photos,
        required this.rate,
        required this.services,
        required this.capacity,
        required this.dinner,
        required this.dinnerPrice,
        required this.mixed,
        required this.address,
        required this.mixedPrice,
        required this.activeTimes,
        required this.name,
    });

    factory ReservaionFilterDataModel.fromJson(Map<String, dynamic> json) => ReservaionFilterDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        capacity: json["capacity"],
        dinner: json["dinner"],
        dinnerPrice: json["dinner_price"],
        mixed: json["mixed"],
        address: json["address"],
        mixedPrice: json["mixed_price"],
        activeTimes: List<ActiveTime>.from(json["active_times"].map((x) => ActiveTime.fromJson(x))),
        name: json["name"],
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
        "address": address,
        "mixed_price": mixedPrice,
        "active_times": List<dynamic>.from(activeTimes.map((x) => x.toJson())),
        "name": name,
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
