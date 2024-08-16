import 'package:events_app/Investor_App/view/reservations/reservation_Page_details.dart';
import 'package:events_app/User_App/model/reservations/public_event_tickets_model.dart';
import 'package:events_app/User_App/model/reservations/reservation_deatals_model.dart';
import 'package:events_app/User_App/model/reservations/reservations_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {
  //======================================User==========================
  var reservationsUserList = <ReservationDataModel>[].obs;
  var reservationsDetalisUserList = <ReservationDetailsDataModel>[].obs;
  var publicEventTicketsList = <PublicEventTicketsDataModel>[].obs;
  var commingPublicEventTicketsList = <PublicEventTicketsDataModel>[].obs;
  var reservationsLoading = true.obs;
  var isPrivateSelected = true.obs;
  var isUpcomingSelected = true.obs;

  Future<void> getReservationItems({
    required String service_kind,
    required String date,
    int? asset_id,
  }) async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/list-user?date=$date&service_kind=$service_kind&asset_id=$asset_id");
      final reservationListModel = ReservationModel.fromJson(data1);
      reservationsUserList.assignAll(reservationListModel.data);
    } catch (e) {
      Get.snackbar("Error", "Error fetching Reservation items");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }

  Future<void> getReservationDeatilsItems({
    required int id,
  }) async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/reservations/get?id=$id");
      final reservationListModel = ReservationDetailsModel.fromJson(data1);
      reservationsDetalisUserList.add(reservationListModel.data);

      if (data1["code"] == 200) {
        print("zaaaza");
      } else {
        Get.snackbar("OOPS...", "${data1["message"]}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Error fetching Tickets");
    } finally {
      reservationsLoading.value = false;
    }
  }

  Future<void> getPublicEventTickets() async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/reservations/list-tickets");
      final ticketsListModel = PublicEventTicketsModel.fromJson(data1);
      publicEventTicketsList.assignAll(ticketsListModel.data);
    } catch (e) {
      Get.snackbar("Error", "Error fetching Tickets ");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }
  //============================================here to show the people who reserve my public event============================================

  Future<void> getCommingPublicEventTickets() async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/list-tickets-for-event?id=${reservationsDetalisUserList[0].id}");
      final ticketsListModel = PublicEventTicketsModel.fromJson(data1);
      commingPublicEventTicketsList.assignAll(ticketsListModel.data);
    } catch (e) {
      Get.snackbar("Error", "Error fetching Tickets ");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }

  Future<void> editPaymentStatusForUserPublicEvent() async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/update-ticket-payment?id=${commingPublicEventTicketsList[0].ticketId}");
    } catch (e) {
      Get.snackbar("Error", "Error fetching Tickets ");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }

  Future<void> editPaymentStatusForCommingInvestorReservation() async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/update-payment?id=${reservationsDetalisUserList[0].id}");
    } catch (e) {
      Get.snackbar("Error", "Error fetching Tickets ");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }

  //======================================Investor==========================
  var reservationsInvestorList = <ReservationDataModel>[].obs;
  var isInvestorPrivateSelected = true.obs;
  var isInvestorUpcomingSelected = true.obs;
  Future<void> getInvestorReservationItems({
    required String service_kind,
    required String date,
    required asset_id,
  }) async {
    try {
      reservationsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/list-investor?date=$date&service_kind=$service_kind&asset_id=$asset_id");
      final reservationListModel = ReservationModel.fromJson(data1);
      reservationsInvestorList.assignAll(reservationListModel.data);
    } catch (e) {
      Get.snackbar("Error", "Error fetching Reservation items");
      print('Error fetching Reservation items: $e');
    } finally {
      reservationsLoading.value = false;
    }
  }
}
