import 'dart:convert';

ServicesListUserModel servicesListUserModelFromJson(String str) => ServicesListUserModel.fromJson(json.decode(str));

String servicesListUserModelToJson(ServicesListUserModel data) => json.encode(data.toJson());

class ServicesListUserModel {
    int code;
    String message;
    List<ServicesListUserDataModel> data;

    ServicesListUserModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ServicesListUserModel.fromJson(Map<String, dynamic> json) => ServicesListUserModel(
        code: json["code"],
        message: json["message"],
        data: List<ServicesListUserDataModel>.from(json["data"].map((x) => ServicesListUserDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ServicesListUserDataModel {
    int id;
    List<String> photos;
    int rate;
    List<Service> services;

    ServicesListUserDataModel({
        required this.id,
        required this.photos,
        required this.rate,
        required this.services,
    });

    factory ServicesListUserDataModel.fromJson(Map<String, dynamic> json) => ServicesListUserDataModel(
        id: json["id"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        rate: json["rate"],
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "rate": rate,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
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
