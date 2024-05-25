import 'package:events_app/common/view/auth/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController residencePlaceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController createPasswordController = TextEditingController();
  final TextEditingController createConfirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  void register() {
    if (formKey.currentState!.validate()) {
      // If the form is valid, proceed with registration logic
      Get.to(OtpPage(isForgetPassword: false,));
    } else {
      // If the form is not valid, show error messages
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    usernameController.dispose();
    emailController.dispose();
    residencePlaceController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

