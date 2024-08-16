
import 'dart:convert';

PublicEventsDetailsModel publicEventsDetailsModelFromJson(String str) => PublicEventsDetailsModel.fromJson(json.decode(str));

String publicEventsDetailsModelToJson(PublicEventsDetailsModel data) => json.encode(data.toJson());

class PublicEventsDetailsModel {
    int code;
    String message;
    PublicEventsDetailsDataModel data;

    PublicEventsDetailsModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory PublicEventsDetailsModel.fromJson(Map<String, dynamic> json) => PublicEventsDetailsModel(
        code: json["code"],
        message: json["message"],
        data: PublicEventsDetailsDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class PublicEventsDetailsDataModel {
    int id;
    String confirmedGuestId;
    int attendeesNumber;
    DateTime startDate;
    DateTime endDate;
    String startTime;
    String endTime;
    int duration;
    String eventName;
    String totalPrice;
    int payment;
    dynamic notes;
    String category;
    String description;
    String? photo;
    String name;
    String address;
    String ticketPrice;

    PublicEventsDetailsDataModel({
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
        required this.category,
        required this.description,
        required this.photo,
        required this.name,
        required this.address,
        required this.ticketPrice,
    });

    factory PublicEventsDetailsDataModel.fromJson(Map<String, dynamic> json) => PublicEventsDetailsDataModel(
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
        category: json["category"],
        description: json["description"],
        photo: json["photo"],
        name: json["name"],
        address: json["address"],
        ticketPrice: json["ticket_price"],
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
        "category": category,
        "description": description,
        "photo": photo,
        "name": name,
        "address": address,
        "ticket_price": ticketPrice,
    };
}
