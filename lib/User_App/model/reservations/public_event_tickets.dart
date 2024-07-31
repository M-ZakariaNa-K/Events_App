
import 'dart:convert';

PublicEventTicketsModel publicEventTicketsModelFromJson(String str) => PublicEventTicketsModel.fromJson(json.decode(str));

String publicEventTicketsModelToJson(PublicEventTicketsModel data) => json.encode(data.toJson());

class PublicEventTicketsModel {
    int code;
    String message;
    List<PublicEventTicketsDataModel> data;

    PublicEventTicketsModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory PublicEventTicketsModel.fromJson(Map<String, dynamic> json) => PublicEventTicketsModel(
        code: json["code"],
        message: json["message"],
        data: List<PublicEventTicketsDataModel>.from(json["data"].map((x) => PublicEventTicketsDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class PublicEventTicketsDataModel {
    int ticketId;
    int payment;
    int ticketsPrice;
    int ticketsNumber;
    String eventName;
    DateTime eventDate;
    String eventStartTime;
    String eventEndTime;

    PublicEventTicketsDataModel({
        required this.ticketId,
        required this.payment,
        required this.ticketsPrice,
        required this.ticketsNumber,
        required this.eventName,
        required this.eventDate,
        required this.eventStartTime,
        required this.eventEndTime,
    });

    factory PublicEventTicketsDataModel.fromJson(Map<String, dynamic> json) => PublicEventTicketsDataModel(
        ticketId: json["ticket_id"],
        payment: json["payment"],
        ticketsPrice: json["tickets_price"],
        ticketsNumber: json["tickets_number"],
        eventName: json["event_name"],
        eventDate: DateTime.parse(json["event_date"]),
        eventStartTime: json["event_start_time"],
        eventEndTime: json["event_end_time"],
    );

    Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "payment": payment,
        "tickets_price": ticketsPrice,
        "tickets_number": ticketsNumber,
        "event_name": eventName,
        "event_date": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "event_start_time": eventStartTime,
        "event_end_time": eventEndTime,
    };
}
