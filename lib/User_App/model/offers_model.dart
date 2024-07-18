import 'dart:convert';

ShowOffersModel showOffersModelFromJson(String str) =>
    ShowOffersModel.fromJson(json.decode(str));

String showOffersModelToJson(ShowOffersModel data) =>
    json.encode(data.toJson());

class ShowOffersModel {
  int code;
  String message;
  List<ShowOffersDataModel> data;

  ShowOffersModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ShowOffersModel.fromJson(Map<String, dynamic> json) =>
      ShowOffersModel(
        code: json["code"],
        message: json["message"],
        data: List<ShowOffersDataModel>.from(
            json["data"].map((x) => ShowOffersDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShowOffersDataModel {
  int assetId;
  int eventId;
  int discountPercentage;
  String name;
  dynamic oldPrice;
  dynamic newPrice;

  ShowOffersDataModel({
    required this.assetId,
    required this.eventId,
    required this.discountPercentage,
    required this.name,
    required this.oldPrice,
    required this.newPrice,
  });

  factory ShowOffersDataModel.fromJson(Map<String, dynamic> json) =>
      ShowOffersDataModel(
        assetId: json["asset_id"],
        eventId: json["event_id"],
        discountPercentage: json["discount_percentage"],
        name: json["name"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
      );

  Map<String, dynamic> toJson() => {
        "asset_id": assetId,
        "event_id": eventId,
        "discount_percentage": discountPercentage,
        "name": name,
        "old_price": oldPrice,
        "new_price": newPrice,
      };
}
