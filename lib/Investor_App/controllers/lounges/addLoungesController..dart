import 'dart:io';

import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/models/add_assets_photos_model.dart';
import 'package:events_app/Investor_App/models/services_list_model.dart';
import 'package:events_app/Investor_App/view/home/investor_homePage..dart';
import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class AddLoungesController extends GetxController {
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  var selectedImagePaths = <String>[].obs;
  var dropdownItems = <String>[].obs;
  var dropdownItemsAllData = <Map<String, dynamic>>[].obs;
  var dropdownValue = ''.obs;
  var kind = ''.obs;
  var allDataToAPI = <String, dynamic>{}.obs;
  var firstRequisResponsData = 0.obs;
  var addedList = <Map<String, dynamic>>[].obs;

  //========for the gridView=================
  var serviceList = <Map<String, dynamic>>[].obs;
  //========End for the gridView=============

  //========start for the WorkHours=============
  var workHourControllers = <Map<String, dynamic>>[
    // {
    //   'start': TextEditingController(),
    //   'end': TextEditingController(),
    //   'isEditing': true.obs
    // }
  ].obs;

  void addWorkHourController() {
    workHourControllers.add({
      'start': TextEditingController(),
      'end': TextEditingController(),
      'isEditing': true.obs
    });
  }

  //========End for the WorkHours===============

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";
      selectedImagePaths.add(pickedFile.path);
      print('selectedImagePaths: ${selectedImagePaths}');
      sharedSelectedPublicEventImagePaths = selectedImagePaths;
    } else {
      Get.snackbar("Error", 'message', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeImage(String imagePath) {
    selectedImagePaths.remove(imagePath);
  }

  @override
  void onInit() {
    super.onInit();
    fetchDropdownItems();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchDropdownItems() async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/service/list?identifier=all");
      final servicesListModel = ServicesListModel.fromJson(data1);

      dropdownItems.clear();
      dropdownItemsAllData.clear();

      for (int i = 0; i < servicesListModel.data.length; i++) {
        // dropdownItemsAllData.add(servicesListModel.data[i]);
        dropdownItemsAllData.add(servicesListModel.data[i]
            .toJson()); // Add each item's map representation
        dropdownItems.add(servicesListModel.data[i].name);
      }

      if (dropdownItems.isNotEmpty) {
        dropdownValue.value = dropdownItems.first; // Set initial value
      }

      print(dropdownItems);
      print(dropdownItemsAllData);
      // Notify GetX that dropdownItems has changed
      dropdownItems.refresh();
      dropdownItemsAllData.refresh();
    } catch (e) {
      print('Error fetching dropdown items: $e');
    }
  }

  void updateKindBasedOnSelection(String selectedService) {
    var selectedItem = dropdownItemsAllData.firstWhere(
      (item) => item['name'] == selectedService,
      orElse: () => {},
    );

    if (selectedItem != null) {
      kind.value = selectedItem['kind'] ?? '';
    }
  }

  //============================upload THE WHOLE REQUEST to the api============================
  Future<void> postLoungeData() async {
    try {
      print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
      print(allDataToAPI);
      Map<String, dynamic> data1 = await DioHelper.post(
          url: "$baseUrl/assets/add-info", body: allDataToAPI);
      if (data1["code"] == 200) {
        LoungesController().getloungesItems();
        Get.off(() => const DrawerPage());
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  //============================upload image to the api========================================
  Future<void> submitData() async {
    try {
      List<dio.MultipartFile> imageFiles = [];
      for (String imagePath in selectedImagePaths) {
        File imageFile = File(imagePath);
        String fileName = imageFile.path.split('/').last;

        imageFiles.add(
            await dio.MultipartFile.fromFile(imagePath, filename: fileName));
      }

      dio.FormData formData = dio.FormData.fromMap({
        "photos[]": imageFiles,
      });

      Map<String, dynamic> response1 = await DioHelper.post(
        url: "$baseUrl/assets/add-photos",
        body: formData,
      );
      final assetsPhotoModel = AddAssetsPhotosModel.fromJson(response1);
      firstRequisResponsData.value = assetsPhotoModel.data.id;
      allDataToAPI["id"] =
          assetsPhotoModel.data.id.toString(); // Ensure id is added as a string
    } catch (e) {
      print('Error submitting data: $e');
      // Get.snackbar("Error", "Error submitting data");
    }
  }

  //============================================================================
  Future<void> submitImagesForPublicEventBooking({required int id}) async {
    try {
//NOTE(from ZAKARIA): I use a SARED VARAIBLE becuse when i make the first request the book controller termenated
//and rebuild it's self => so the selectedImagesaPaths become empty when i book
// so i saved is value in shared var
      List<dio.MultipartFile> imageFiles = [];
      for (String imagePath in sharedSelectedPublicEventImagePaths) {
        File imageFile = File(imagePath);
        String fileName = imageFile.path.split('/').last;
        print('imageFile: ${imageFile}');

        imageFiles.add(
            await dio.MultipartFile.fromFile(imagePath, filename: fileName));
      }
      print('imageFiles: ${imageFiles}');
      dio.FormData formData = dio.FormData.fromMap({
        "photo": imageFiles,
        "id": id,
      });

      Map<String, dynamic> response1 = await DioHelper.post(
        url: "$baseUrl/reservations/add-photo",
        body: formData,
      );
    } catch (e) {
      print('Error submitting data: $e');
      // Get.snackbar("Error", "Error submitting data");
    }
  }

  // Function to find the IDs and create the "existed" list
  List<Map<String, dynamic>> createExistedList(
      List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
    List<Map<String, dynamic>> existedList = [];

    for (var item1 in list1) {
      var matchingItem = list2.firstWhere(
        (item2) => item2['name'] == item1['name'],
        orElse: () => {},
      );

      if (matchingItem != null) {
        // if (dropdownValue.value == matchingItem["name"]) {
        //   kind.value = matchingItem["kind"];
        // }
        existedList.add({
          'proportion': item1["proportion"] ?? 0,
          'id': "${matchingItem['id']}",
          'price': "${item1['price']}",
        });
      }
    }

    return existedList;
  }

  String kindService(
      List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
    String a = "";
    for (var item1 in list1) {
      var matchingItem = list2.firstWhere(
        (item2) => item2['name'] == item1['name'],
        // orElse: () => null,
      );
      if (matchingItem != null) {
        if (dropdownValue.value == matchingItem["name"]) {
          a = matchingItem["kind"];
        }
        print("Kind: ${matchingItem['kind']}");
      }
    }
    return a;
  }
}
