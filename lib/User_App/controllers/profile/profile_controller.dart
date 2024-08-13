import 'dart:io';

import 'package:events_app/Investor_App/models/add_assets_photos_model.dart';
import 'package:events_app/User_App/model/profile_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var profileItems = <ProfileDataModel>[].obs;
  var profileItemsLoading = true.obs;
  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  var selectedImagePaths = <String>[].obs;

  Future<void> getProfileItems() async {
    try {
      profileItemsLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/profile/get");

      final a = ProfileModel.fromJson(data1);
      print(a);
      profileItems.add(a.data);
    } catch (e) {
      print('Error fetching Profile items: $e');
    } finally {
      profileItemsLoading.value = false;
    }
  }

  // void deleteItem(int id) async {
  //   try {
  //     await DioHelper.delete(url: "$baseUrl/assets/delete-favorite?id=$id");
  //     favoriteItems.removeWhere((item) => item.id == id);
  //   } catch (e) {
  //     print("Error deleting favorite item: $e");
  //   }
  // }
  Future<void> postEditedProfileItems() async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.post(url: "$baseUrl/profile/update", body: {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "username": usernameController.text,
        "email": emailController.text,
        "address": addressController.text,
        "phone_number": phoneNumberController.text,
      });
      if (data1["code"] == 200) {
        // Get.snackbar('Success', 'Edited successful',
        //     snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Error fetching loungeDetailsItems items: $e');
    }
  }
  //=========================for image======================

  Future<void> getImage(ImageSource imageSource) async {
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

  Future<void> removeImage(String imagePath) async {
    selectedImagePaths.remove(imagePath);
    profileItems[0].photo = null;
    await DioHelper.delete(url: "$baseUrl/profile/delete-photo");
    profileItems.clear();
    await getProfileItems();
  }

  Future<void> submitImage() async {
    try {
      List<dio.MultipartFile> imageFiles = [];
      for (String imagePath in selectedImagePaths) {
        File imageFile = File(imagePath);
        String fileName = imageFile.path.split('/').last;

        imageFiles.add(
            await dio.MultipartFile.fromFile(imagePath, filename: fileName));
      }

      dio.FormData formData = dio.FormData.fromMap({
        "photo": imageFiles[0],
      });

      Map<String, dynamic> response1 = await DioHelper.post(
        url: "$baseUrl/profile/set-photo",
        body: formData,
      );
      final assetsPhotoModel = AddAssetsPhotosModel.fromJson(response1);
    } catch (e) {
      print('Error submitting data: $e');
      // Get.snackbar("Error", "Error submitting data");
    }
  }

  //=========================for image======================
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    // favoriteItems.value = [];
    // favoriteItems.clear();
  }
}
