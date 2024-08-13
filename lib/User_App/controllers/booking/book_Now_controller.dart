import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/model/booking/GetListOfCategoriesPublicEventBookNow.dart';
import 'package:events_app/User_App/model/booking/GetTimesAvailbleFORReserveHall.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookNowController extends GetxController {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController audincesNumber = TextEditingController();
  final RadioController paymentController =
      Get.put(RadioController(), tag: 'Payment');
  var selectedOrganizerServiceId = 0.obs;
  var selectedHallServiceId = 0.obs;
  var enteredOrganizerId = 0.obs;
  var timesReservedOrganizerList =
      <GetTimesAvailableListForReserveHallDataModel>[].obs;

  // Hall=======================
  var enteredHallId = 0.obs;
  var timesAvilableList = <GetTimesAvailableListForReserveHallDataModel>[].obs;
  var selectedChoosenTimeHall = 0.obs;
  final RadioController mixedController =
      Get.put(RadioController(), tag: 'MixedServices');
  final RadioController dinnerController =
      Get.put(RadioController(), tag: 'DinnerServices');
  // Hall=======================
//public event======================
  var selectedChoosenCategoryId = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController addedArabicnameController = TextEditingController();
  TextEditingController addedEnglishnameController = TextEditingController();
  TextEditingController descraptionController = TextEditingController();
  TextEditingController addresaController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  var addedCategorriesMap = <String, Map<String, String>>{}.obs;
  var selectedCategoryCardIndex = -1.obs;
  var existedCategoriesList = <GetPublicEventsCategoryBookNowDataModel>[].obs;
  var selectedServiceType = ''.obs;
  //========for the Public event booking image=================
  var publicEventBookedIdToUploadTheImage = 0.obs;

//public event======================
  Future<void> postOrganizerData() async {
    dynamic response = await DioHelper.post(
        url: "$baseUrl/reservations/add-reservation",
        body: {
          "general_info": {
            "attendees_number": audincesNumber.text,
            "start_date": showStartDateMap["date"],
            "end_date": showStartDateMap["date"],
            "start_time": startTimeController.text,
            "end_time": endTimeController.text,
            "event_id": "${selectedOrganizerServiceId.value}",
            "dinner": 0,
            "mixed": 0,
            "payment_type":
                paymentController.selectedValue.value == 0 ? "cash" : "electro"
          },
          "public_info": {},
        });
    if (response["code"] == 200) {
      timesAvilableList.clear();
      timesReservedOrganizerList.clear();
      Get.snackbar("Great🎉", "Your book in cook...");
    }
  }

  Future<List<GetTimesAvailableListForReserveHallDataModel>>
      getTimesAvailbleList({required int assetId, required String date}) async {
    try {
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/list-times-hall?asset_id=$assetId&date=$date");

      final a = GetTimesAvailableListForReserveHallModel.fromJson(data1);

      timesAvilableList.value = a.data;
      return timesAvilableList;
    } catch (e) {
      print('Error fetching times available: $e');
      return timesAvilableList;
    }
  }

  Future<List<GetTimesAvailableListForReserveHallDataModel>>
      getTimesReservedOrgainzerList(
          {required int assetId, required String date}) async {
    try {
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/reservations/list-times-organizer?asset_id=$assetId&date=$date");

      final a = GetTimesAvailableListForReserveHallModel.fromJson(data1);

      timesAvilableList.value = a.data;
      return timesAvilableList;
    } catch (e) {
      print('Error fetching times available: $e');
      return timesAvilableList;
    }
  }

  Future<void> postHallData() async {
    // print(' audincesNumber.text: ${audincesNumber.text}');
    // print(' showStartDateMap["date"]: ${showStartDateMap["date"]}');
    // print('selectedChoosenTimeHall.value: ${selectedChoosenTimeHall.value}');
    // print('selectedHallServiceId.value: ${selectedHallServiceId.value}');
    // print(
    //     ' dinnerController.selectedValue.value: ${dinnerController.selectedValue.value}');
    // print(
    //     'mixedController.selectedValue.value: ${mixedController.selectedValue.value}');
    // print(
    //     'paymentController.selectedValue.value: ${paymentController.selectedValue.value}');
    dynamic response = await DioHelper.post(
        url: "$baseUrl/reservations/add-reservation",
        body: {
          "general_info": {
            "attendees_number": audincesNumber.text,
            "start_date": showStartDateMap["date"],
            "end_date": showStartDateMap["date"],
            "time_id": selectedChoosenTimeHall.value,
            "event_id": selectedHallServiceId.value,
            "dinner": dinnerController.selectedValue.value,
            "mixed": mixedController.selectedValue.value,
            "payment_type":
                paymentController.selectedValue.value == 0 ? "cash" : "electro"
          },
          "public_info": {},
        });
    try {
      if (response["code"] == 200) {
        Get.snackbar("Great🎉", "Your book in cook...");
      }
    } catch (e) {
      Get.snackbar("Erorr", "there is an error while booking");
    }
  }

  //=================Public EVENTS=============================
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

  Future<void> postPublicEventData() async {
    dynamic response = await DioHelper.post(
        url: "$baseUrl/reservations/add-reservation",
        body: {
          "general_info": {
            "attendees_number": audincesNumber.text,
            "start_date": showStartDateMap["date"],
            "end_date": showStartDateMap["date"],
            "time_id": selectedChoosenTimeHall.value,
            "event_id": selectedHallServiceId.value,
            "dinner": dinnerController.selectedValue.value,
            "mixed": mixedController.selectedValue.value,
            "payment_type":
                paymentController.selectedValue.value == 0 ? "cash" : "electro"
          },
          "public_info": selectedServiceType.value == "public"
              ? {
                  "category": {
                    "added": addedCategorriesMap,
                    //0 for if i add an added category
                    //-1 for validation which mean i didnt choose any category
                    "existed": selectedChoosenCategoryId.value == -1 ||
                            selectedChoosenCategoryId.value == 0
                        ? {}
                        : {"id": selectedChoosenCategoryId.value}
                  },
                  "info": {
                    "description": descraptionController.text,
                    "name": nameController.text,
                    "address": addresaController.text,
                    "ticket_price": ticketPriceController.text
                  }
                }
              : {}
        });
    try {
      print(response);
      if (response["code"] == 200) {
        publicEventBookedIdToUploadTheImage.value = response["data"];
        // Get.snackbar("Great🎉", "Your book in cook...");
        //to return it to initial value
        selectedChoosenCategoryId.value = -1;
        existedCategoriesList.clear();
        ticketPriceController.clear();
        addedCategorriesMap.value = {};
        nameController.clear();
        descraptionController.clear();
        addresaController.clear();
        audincesNumber.clear();
        addedArabicnameController.clear();
        addedEnglishnameController.clear();
        final addLoungeController = AddLoungesController();
        addLoungeController.selectedImagePaths.value = [];
        addLoungeController.selectedImageSize.value = '';
        addLoungeController.selectedImagePath.value = '';
        
      }
    } catch (e) {
      Get.snackbar("Erorr", "one of the fild is wrong");
    }
  }

  //=================Public EVENTS=============================
}
