// To parse this JSON data, do
//
//     final getTimesAvailableListForReserveHall = getTimesAvailableListForReserveHallFromJson(jsonString);

import 'dart:convert';

GetTimesAvailableListForReserveHallModel getTimesAvailableListForReserveHallFromJson(String str) => GetTimesAvailableListForReserveHallModel.fromJson(json.decode(str));

String getTimesAvailableListForReserveHallToJson(GetTimesAvailableListForReserveHallModel data) => json.encode(data.toJson());

class GetTimesAvailableListForReserveHallModel {
    int code;
    String message;
    List<GetTimesAvailableListForReserveHallDataModel> data;

    GetTimesAvailableListForReserveHallModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetTimesAvailableListForReserveHallModel.fromJson(Map<String, dynamic> json) => GetTimesAvailableListForReserveHallModel(
        code: json["code"],
        message: json["message"],
        data: List<GetTimesAvailableListForReserveHallDataModel>.from(json["data"].map((x) => GetTimesAvailableListForReserveHallDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetTimesAvailableListForReserveHallDataModel {
    int id;
    String startTime;
    String endTime;

    GetTimesAvailableListForReserveHallDataModel({
        required this.id,
        required this.startTime,
        required this.endTime,
    });

    factory GetTimesAvailableListForReserveHallDataModel.fromJson(Map<String, dynamic> json) => GetTimesAvailableListForReserveHallDataModel(
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
