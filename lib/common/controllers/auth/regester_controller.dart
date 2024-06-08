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
  RegesterModel? regesterModel;
  void register() {
    if (formKey.currentState!.validate()) {
      // If the form is valid, proceed with registration logic
      Get.to(OtpPage(
        email: emailController.text,
        isForgetPassword: false,
      ));
    } else {
      // If the form is not valid, show error messages
    }
  }

  void regesterState(
      // required String firstName,
      // required String lastName,
      // required String username,
      // required String email,
      // required String password,
      // required String confirmPassword,
      // required String address,
      // required String phoneNumber,
      ) {
    DioHelper.postDataWithAuth(
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
    ).then((response) async {
      final data = response.data;
      print("zakakakak $data");
      if (data != null) {
        regesterModel = RegesterModel.fromJson(data);
        if (regesterModel != null && regesterModel!.data != null) {
          token = regesterModel!.data!.token!;
          //User Email to save the email and use it in forget password
          userEmail = emailController.text;
          box.write('token', token);
          print("regester: $token");
          Get.offAll(const DrawerPage());
        } else {}
      } else {}
    }).catchError((error) {});
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
