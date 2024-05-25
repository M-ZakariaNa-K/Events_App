
import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      // If the form is valid, proceed with login logic
      Get.offAll(const DrawerPage());
    } else {
      // If the form is not valid, show error messages
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
