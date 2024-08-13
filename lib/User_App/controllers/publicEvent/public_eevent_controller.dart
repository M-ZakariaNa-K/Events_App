import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/model/booking/GetListOfCategoriesPublicEventBookNow.dart';
import 'package:events_app/User_App/model/public_event/public_event_model.dart';
import 'package:events_app/User_App/model/public_event/public_events_detalis_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicEventController extends GetxController {
  var publicEventsItems = <PublicEventDataModel>[].obs;
  var publicEventsItemsDependOnDate = <PublicEventDataModel>[].obs;
  var publicEventsDetilaItems = <PublicEventsDetailsDataModel>[].obs;
  var publicEventsLoading = true.obs;
  var isAllSelected = true.obs;
  var publicEventId = 0.obs;
  //dialog in details================================================
  var ticketCount = 1.obs;
  double ticketPrice = 0;
  double get totalPrice => ticketCount.value * ticketPrice;
  final RadioController paymentController =
      Get.put(RadioController(), tag: 'Payment');
  TextEditingController ticketsNumberTicketsController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  //dialog in details================================================
  var existedCategoriesList = <GetPublicEventsCategoryBookNowDataModel>[].obs;

  Future<void> getPublicEventsItems({required int category_id}) async {
    try {
      publicEventsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url: "$baseUrl/reservations/list-public?category_id=$category_id");
      if (category_id == 0) {
        final a = PublicEventModel.fromJson(data1);
        publicEventsItemsDependOnDate.assignAll(a.data);
        print('azzzzzzz: ${a}');
      } else {
        final a = PublicEventModel.fromJson(data1);
        print('a: ${a}');
        publicEventsItems.assignAll(a.data);
      }
    } catch (e) {
      print('Error fetching public events items: $e');
    } finally {
      publicEventsLoading.value = false;
    }
  }

  Future<List<GetPublicEventsCategoryBookNowDataModel>>
      getCategoriesList() async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/reservations/list-categories");

      final a = GetPublicEventsCategoryBookNowModel.fromJson(data1);

      existedCategoriesList.value = a.data;
      return existedCategoriesList;
    } catch (e) {
      print('Error fetching times available: $e');

      return existedCategoriesList;
    }
  }

  Future<void> getPublicEventsDetailsItems() async {
    try {
      publicEventsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url: "$baseUrl/reservations/get?id=${publicEventId.value}");

      final a = PublicEventsDetailsModel.fromJson(data1);
      publicEventsDetilaItems.add(a.data);
      print('azzzzzzz: ${a}');
    } catch (e) {
      print('Error fetching public events detail items: $e');
    } finally {
      publicEventsLoading.value = false;
    }
  }

  Future<void> postReserveTicket(
      {required int eventId, required String paymentType}) async {
    dynamic response = await DioHelper.post(
        url: "$baseUrl/reservations/reserve-tickets",
        body: {
          "tickets_number": ticketsNumberTicketsController.text,
          "event_id": eventId,
          "payment_type": paymentType,
        });
  }

  @override
  void onInit() {
    super.onInit();
    getCategoriesList();
  }
}
