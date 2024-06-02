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
  LoginModel? userModel;

  void loginState({required String userName, required String password}) {
    DioHelper.postDataWithAuth(
      url: '$baseUrl/auth/login',
      data: {'login': userName, 'password': password},
    ).then((response) async {
      final data = response.data;
      print("zakakakak $data");
      if (data != null) {
        userModel = LoginModel.fromJson(data);
        if (userModel != null && userModel!.data != null) {
          token = userModel!.data!.token!;
          box.write('token', token);
          print(token);
          Get.offAll(const DrawerPage());
          showToast(
            msg: "Logged In Successfuly",
            backgroundColor: Colors.green,
          );
        } else {}
      } else {}
    }).catchError((error) {});
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
