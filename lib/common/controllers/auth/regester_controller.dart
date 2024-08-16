import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:events_app/common/models/regester_model.dart';
import 'package:events_app/common/view/auth/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController createConfirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs; // Add loading state

  RegesterDataModel? regesterModel;

  void register() {
    if (formKey.currentState!.validate()) {
      regesterState();
    } else {
      // If the form is not valid, show error messages
    }
  }

  void regesterState() async {
    isLoading.value = true; // Show loading indicator

    try {
      final response = await DioHelper.postDataWithAuth(
        url: '$baseUrl/auth/register',
        data: {
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'confirm_password': confirmPasswordController.text,
          'address': addressController.text,
          'phone_number': phoneNumberController.text,
        },
      );

      // final data = response.data;
      if (response != null) {
        regesterModel = RegesterDataModel.fromJson(response["data"]);
        if (regesterModel != null && regesterModel != null) {
          token = regesterModel!.token!;
          userEmail = emailController.text;
          role = regesterModel!.role!;
          isUser = regesterModel!.role == "User";
          isHallOwner = regesterModel!.role == "HallOwner";
          box.write('token', token);
          roleBox.write('role', role);
          box.write('token', token);
          Get.offAll(const DrawerPage());
          // Get.snackbar('Success', 'Registration successful',
          //     snackPosition: SnackPosition.TOP);
        }
      }
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    confirmPasswordController.dispose();
    createConfirmPasswordController.dispose();
    createPasswordController.dispose();
    super.dispose();
  }
}
