import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/Api.dart';
import 'package:events_app/common/helper/show_toast.dart';
import 'package:events_app/common/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginDataModel? userModel;

  Future<void> loginState(
      {required String userName, required String password}) async {
    try {
      final response = await DioHelper.postDataWithAuth(
        url: '$baseUrl/auth/login',
        //zak
        data: {
          'login': userName,
          'password': password,
          "client_token": "ahmaddeeb"
        },
      );
      print("Response data: $response");
      if (response != null) {
        userModel = LoginDataModel.fromJson(response["data"]);
        if (userModel != null && userModel! != null) {
          print("zzzzzz $userModel");
          token = userModel!.token!;
          role = userModel!.role!;
          isUser = userModel!.role == "User";
          isHallOwner = userModel!.role == "HallOwner";
          box.write('token', token);
          roleBox.write('role', role);
          print("Token: $token, Role: $role");

          showToast(
              msg: "Logged In Successfully", backgroundColor: Colors.green);
          print("Navigating to DrawerPage");
          Get.offAll(() => const DrawerPage());
        } else {
          print("Login failed: User model or data is null");
        }
      }
    } catch (error) {
      print("Login error: $error");
      showToast(msg: "Login Failed", backgroundColor: Colors.red);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
