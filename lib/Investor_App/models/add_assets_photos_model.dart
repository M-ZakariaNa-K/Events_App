// To parse this JSON data, do
//
//     final addAssetsPhotosModel = addAssetsPhotosModelFromJson(jsonString);

import 'dart:convert';

AddAssetsPhotosModel addAssetsPhotosModelFromJson(String str) => AddAssetsPhotosModel.fromJson(json.decode(str));

String addAssetsPhotosModelToJson(AddAssetsPhotosModel data) => json.encode(data.toJson());

class AddAssetsPhotosModel {
    int code;
    String message;
    AddAssetsPhotosDataModel data;

    AddAssetsPhotosModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory AddAssetsPhotosModel.fromJson(Map<String, dynamic> json) => AddAssetsPhotosModel(
        code: json["code"],
        message: json["message"],
        data: AddAssetsPhotosDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class AddAssetsPhotosDataModel {
    int id;

    AddAssetsPhotosDataModel({
        required this.id,
    });

    factory AddAssetsPhotosDataModel.fromJson(Map<String, dynamic> json) => AddAssetsPhotosDataModel(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
