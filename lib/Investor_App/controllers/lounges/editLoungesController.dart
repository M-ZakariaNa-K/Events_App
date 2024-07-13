import 'dart:io';
import 'package:events_app/Investor_App/models/lounge_details_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLoungesController extends GetxController {
  var loungeDetailsItems = <LoungeDetailsDataModel>[].obs;
  var workHourControllers = <Map<String, dynamic>>[].obs;
  var selectedImagePaths = <String>[].obs; // Add this line
  var allApiData = <String, dynamic>{}.obs;

  void addWorkHourController() {
    workHourControllers.clear();
    for (var activeTime in loungeDetailsItems[0].activeTimes) {
      workHourControllers.add({
        'start': TextEditingController(text: activeTime.startTime),
        'end': TextEditingController(text: activeTime.endTime),
        'isEditing': true.obs,
      });
    }
  }

  Future<dynamic> getLoungeDetailsItems({required int id}) async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/get?id=$id");
      final a = LoungeDetailsModel.fromJson(data1);
      loungeDetailsItems.add(a.data);
      print('loungeDetailsItems: ${loungeDetailsItems}');

      // Add API images to the selectedImagePaths list
      for (var photo in a.data.photos) {
        selectedImagePaths.add(photo); // Assuming photos are URLs
      }

      addWorkHourController();
      return loungeDetailsItems;
    } catch (e) {
      print('Error fetching loungeDetailsItems items: $e');
    }
  }

  void removeImage(String imagePath) {
    selectedImagePaths.remove(imagePath);
  }

  @override
  void onInit() {
    super.onInit();
    // You can call getLoungeDetailsItems here if you need to fetch details immediately
    // getLoungeDetailsItems(id: <your-id>);
  }
}
