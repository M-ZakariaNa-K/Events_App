import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:events_app/common/helper/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:events_app/common/controllers/auth/regester_controller.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create New Password"),
        titleTextStyle: const TextStyle(
          color: Color(0xff464646),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          color: ThemesStyles.textColor,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: GetBuilder<RegisterController>(builder: (controller) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 350,
                        child: Image.asset(
                          "assets/images/CreateNewPassword.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        child: Text(
                          "Create Your New Password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      CustomeLoginTextFormField(
                        prefixIcon: const Icon(Icons.lock),
                        inputType: TextInputType.text,
                        hintText: '••••••••••••••••',
                        title: 'Password',
                        controller: controller.createPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.02,
                      // ),
                      CustomeLoginTextFormField(
                        prefixIcon: const Icon(Icons.lock),
                        inputType: TextInputType.text,
                        hintText: '••••••••••••••••',
                        title: 'Password',
                        controller: controller.createConfirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value !=
                              controller.createPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: DefultButton(
                      buttonColor: ThemesStyles.primary,
                      borderColor: Colors.transparent,
                      textColor: Colors.white,
                      title: "Continue",
                      onPressed: () async {
                        if (controller.createPasswordController.text.isEmpty ||
                            controller
                                .createConfirmPasswordController.text.isEmpty) {
                          Get.snackbar('Error', 'Please fill in all fields',
                              snackPosition: SnackPosition.TOP);
                          return;
                        }
                        if (controller.createPasswordController.text !=
                            controller.createConfirmPasswordController.text) {
                          Get.snackbar('Error', 'Passwords do not match',
                              snackPosition: SnackPosition.TOP);
                          return;
                        }
                        controller.isLoading.value = true;
                        try {
                          final response = await DioHelper.post(
                              url: "$baseUrl/auth/reset-password",
                              body: {
                                'password':
                                    controller.createPasswordController.text,
                                'confirm_password': controller
                                    .createConfirmPasswordController.text,
                                'email': createPasswordEmail,
                              });
                          controller.isLoading.value = false;
                          showToast(
                            msg: "Password created successfully",
                            backgroundColor: Colors.green,
                          );

                          Get.offAll(const DrawerPage());
                          controller.createPasswordController.text = "";
                          controller.createConfirmPasswordController.text = "";
                        } catch (error) {
                          controller.isLoading.value = false;
                          Get.snackbar('Error', 'Failed to create password',
                              snackPosition: SnackPosition.TOP);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }),
    );
  }
}
