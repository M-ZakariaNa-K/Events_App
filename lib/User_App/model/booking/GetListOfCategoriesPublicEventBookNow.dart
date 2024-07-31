import 'dart:convert';

GetPublicEventsCategoryBookNowModel getPublicEventsCategoryBookNowModelFromJson(String str) => GetPublicEventsCategoryBookNowModel.fromJson(json.decode(str));

String getPublicEventsCategoryBookNowModelToJson(GetPublicEventsCategoryBookNowModel data) => json.encode(data.toJson());

class GetPublicEventsCategoryBookNowModel {
    List<GetPublicEventsCategoryBookNowDataModel> data;

    GetPublicEventsCategoryBookNowModel({
        required this.data,
    });

    factory GetPublicEventsCategoryBookNowModel.fromJson(Map<String, dynamic> json) => GetPublicEventsCategoryBookNowModel(
        data: List<GetPublicEventsCategoryBookNowDataModel>.from(json["data"].map((x) => GetPublicEventsCategoryBookNowDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetPublicEventsCategoryBookNowDataModel {
    int id;
    String name;

    GetPublicEventsCategoryBookNowDataModel({
        required this.id,
        required this.name,
    });

    factory GetPublicEventsCategoryBookNowDataModel.fromJson(Map<String, dynamic> json) => GetPublicEventsCategoryBookNowDataModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
