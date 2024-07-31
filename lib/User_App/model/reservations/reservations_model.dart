import 'dart:convert';

ReservationModel reservationModelFromJson(String str) => ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationModel {
    int code;
    String message;
    List<ReservationDataModel> data;

    ReservationModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
        code: json["code"],
        message: json["message"],
        data: List<ReservationDataModel>.from(json["data"].map((x) => ReservationDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ReservationDataModel {
    int id;
    String confirmedGuestId;
    int attendeesNumber;
    DateTime startDate;
    DateTime endDate;
    String startTime;
    String endTime;
    int duration;
    String eventName;
    int totalPrice;
    int payment;
    dynamic notes;

    ReservationDataModel({
        required this.id,
        required this.confirmedGuestId,
        required this.attendeesNumber,
        required this.startDate,
        required this.endDate,
        required this.startTime,
        required this.endTime,
        required this.duration,
        required this.eventName,
        required this.totalPrice,
        required this.payment,
        required this.notes,
    });

    factory ReservationDataModel.fromJson(Map<String, dynamic> json) => ReservationDataModel(
        id: json["id"],
        confirmedGuestId: json["confirmed_guest_id"],
        attendeesNumber: json["attendees_number"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        duration: json["duration"],
        eventName: json["event_name"],
        totalPrice: json["total_price"],
        payment: json["payment"],
        notes: json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "confirmed_guest_id": confirmedGuestId,
        "attendees_number": attendeesNumber,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "duration": duration,
        "event_name": eventName,
        "total_price": totalPrice,
        "payment": payment,
        "notes": notes,
    };
}
