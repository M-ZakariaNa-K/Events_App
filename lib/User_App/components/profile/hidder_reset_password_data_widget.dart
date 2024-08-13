import 'package:events_app/User_App/components/profile/profile_textfild_widget.dart';
import 'package:events_app/User_App/controllers/profile/profile_controller.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HiddenResetPasswordDataWidget extends StatelessWidget {
  const HiddenResetPasswordDataWidget({
    super.key,
    required bool showHiddenChangePasswordData,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.oldPasswordController,
  }) : _showHiddenChangePasswordData = showHiddenChangePasswordData;

  final bool _showHiddenChangePasswordData;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final TextEditingController oldPasswordController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      curve: Curves.ease, // Adjust animation curve
      child: Visibility(
        visible: _showHiddenChangePasswordData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ProfileTextFildWidget(
                  title: "Old Password",
                  hintText: "Write old password",
                  controller: oldPasswordController,
                  validator: (value) {},
                  inputType: TextInputType.text,
                ),
              ),
              ProfileTextFildWidget(
                title: "New Password",
                hintText: "Create new password",
                controller: newPasswordController,
                validator: (value) {},
                inputType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ProfileTextFildWidget(
                  title: "Confirm Password",
                  hintText: "Confirm new password",
                  controller: confirmNewPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                ),
              ),
              DefultButton(
                buttonColor: Theme.of(context).brightness == Brightness.dark
                    ? ThemesStyles.backgroundDark
                    : ThemesStyles.background,
                borderColor: const Color.fromARGB(255, 206, 206, 206),
                textColor: ThemesStyles.primary,
                title: "Reset Password",
                onPressed: () {
                  final profileController = Get.put(ProfileController());
                  DioHelper.post(
                    url: "$baseUrl/auth/reset-password",
                    body: {
                      'password': newPasswordController.text,
                      'confirm_password': confirmNewPasswordController.text,
                      //this is from the Login
                      'email': profileController.emailController.text,
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
