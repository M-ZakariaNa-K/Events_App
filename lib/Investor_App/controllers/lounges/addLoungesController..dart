import 'dart:io';

import 'package:dio/dio.dart';
import 'package:events_app/Investor_App/models/services_list_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class AddLoungesController extends GetxController {
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  var selectedImagePaths = <String>[].obs;
  var dropdownItems = <String>[].obs;
  var dropdownValue = ''.obs; // Set initial value to an empty string

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";
      selectedImagePaths.add(pickedFile.path);
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
          await DioHelper.get(url: "$baseUrl/service/list");
      final servicesListModel = ServicesListModel.fromJson(data1);

      dropdownItems.clear();
      for (int i = 0; i < servicesListModel.data.length; i++) {
        dropdownItems.add(servicesListModel.data[i].name);
      }

      if (dropdownItems.isNotEmpty) {
        dropdownValue.value =
            dropdownItems.first; // Set initial value to the first item
      }

      print(dropdownItems);
      // Notify GetX that dropdownItems has changed
      dropdownItems.refresh();
    } catch (e) {
      print('Error fetching dropdown items: $e');
    }
  }

  //============================upload image to the api============================
  Future<void> submitData() async {
    try {
      //rony
      // final String imagePath = selectedImagePaths[0];
      // final formData = dio.FormData.fromMap({
      //   'file': await dio.MultipartFile.fromFile(imagePath,filename: 'test' )
      // });

      List<dio.MultipartFile> imageFiles = [];
      for (String imagePath in selectedImagePaths) {
        // print(imagePath);
        File imageFile = File(imagePath);
        String fileName = imageFile.path.split('/').last;
        
        imageFiles.add(
            await dio.MultipartFile.fromFile(imagePath, filename: fileName));
      }

      // try {
      //   final response = await DioHelper.post(url: '$baseUrl/assets/add-photos', body: formData);
      // } catch (e) {

      // }
      dio.FormData formData = dio.FormData.fromMap({
        "service": dropdownValue.value,
        "photos[]": imageFiles,
      });
        print('formData: ${formData}');

      var response = await DioHelper.post(
        url: "$baseUrl/assets/add-photos",
        body: formData,
      );
      // print(response.body);
      print('sc' + response.statusCode);
      // if (response.statusCode == 200) {
      //   Get.snackbar("Success", "Data submitted successfully");
      // } else {
      //   Get.snackbar("Error", "Failed to submit data");
      // }
    } catch (e) {
      print('Error submitting data: $e');
      Get.snackbar("Error", "Error submitting data");
    }
  }
}
