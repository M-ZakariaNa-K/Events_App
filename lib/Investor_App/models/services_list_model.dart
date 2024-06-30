// To parse this JSON data, do
//
//     final servicesListModel = servicesListModelFromJson(jsonString);

import 'dart:convert';

ServicesListModel servicesListModelFromJson(String str) => ServicesListModel.fromJson(json.decode(str));

String servicesListModelToJson(ServicesListModel data) => json.encode(data.toJson());

class ServicesListModel {
    int code;
    String message;
    List<ServicesListDataModel> data;

    ServicesListModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ServicesListModel.fromJson(Map<String, dynamic> json) => ServicesListModel(
        code: json["code"],
        message: json["message"],
        data: List<ServicesListDataModel>.from(json["data"].map((x) => ServicesListDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ServicesListDataModel {
    int id;
    String name;
    String kind;

    ServicesListDataModel({
        required this.id,
        required this.name,
        required this.kind,
    });

    factory ServicesListDataModel.fromJson(Map<String, dynamic> json) => ServicesListDataModel(
        id: json["id"],
        name: json["name"],
        kind: json["kind"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kind": kind,
    };
}
