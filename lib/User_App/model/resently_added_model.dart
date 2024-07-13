import 'dart:convert';

RecentlyAddedModel recentlyAddedModelFromJson(String str) => RecentlyAddedModel.fromJson(json.decode(str));

String recentlyAddedModelToJson(RecentlyAddedModel data) => json.encode(data.toJson());

class RecentlyAddedModel {
    int code;
    String message;
    List<RecentlyAddedDataModel> data;

    RecentlyAddedModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory RecentlyAddedModel.fromJson(Map<String, dynamic> json) => RecentlyAddedModel(
        code: json["code"],
        message: json["message"],
        data: List<RecentlyAddedDataModel>.from(json["data"].map((x) => RecentlyAddedDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RecentlyAddedDataModel {
    String name;
    String? photo;

    RecentlyAddedDataModel({
        required this.name,
        required this.photo,
    });

    factory RecentlyAddedDataModel.fromJson(Map<String, dynamic> json) => RecentlyAddedDataModel(
        name: json["name"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "photo": photo,
    };
}
