import 'dart:convert';

ListServicesForSecondSlideReservationModel listServicesForSecondSlideReservationModelFromJson(String str) => ListServicesForSecondSlideReservationModel.fromJson(json.decode(str));

String listServicesForSecondSlideReservationModelToJson(ListServicesForSecondSlideReservationModel data) => json.encode(data.toJson());

class ListServicesForSecondSlideReservationModel {
    int code;
    String message;
    List<ListServicesForSecondSlideReservationDataModel> data;

    ListServicesForSecondSlideReservationModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ListServicesForSecondSlideReservationModel.fromJson(Map<String, dynamic> json) => ListServicesForSecondSlideReservationModel(
        code: json["code"],
        message: json["message"],
        data: List<ListServicesForSecondSlideReservationDataModel>.from(json["data"].map((x) => ListServicesForSecondSlideReservationDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ListServicesForSecondSlideReservationDataModel {
    int id;
    String name;
    String kind;

    ListServicesForSecondSlideReservationDataModel({
        required this.id,
        required this.name,
        required this.kind,
    });

    factory ListServicesForSecondSlideReservationDataModel.fromJson(Map<String, dynamic> json) => ListServicesForSecondSlideReservationDataModel(
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
