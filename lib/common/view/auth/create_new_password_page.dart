import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/controllers/auth/regester_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<RegisterController>(builder: (controller) {
          return Column(
            children: <Widget>[
              //1
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
              //====2=====
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    child: Text(
                      "Create Your New Password",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  //====3=====
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.lock),
                    inputType: TextInputType.text,
                    hintText: '••••••••••••••••',
                    title: 'Confirm Password',
                    controller: controller.createConfirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              //====3=====
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: DefultButton(
                  buttonColor: ThemesStyles.primary,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  title: "Continue",
                  onPressed: () async {
                    final shouldNavigate = await showConfirmationDialog(
                      context: context,
                      imagePath:
                          'assets/images/shield (1).png', // Replace with your image path
                      title: 'Congratulations!',
                      subtitle:
                          'Your account is ready to use. You will be redirected to the Home Page in a few seconds.',
                    );
                    if (shouldNavigate ?? false) {
                      Get.to(DrawerPage());
                    }
                  },
                ),
              )
              //====3=====
            ],
          );
        }),
      ),
    );
  }
}

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String imagePath,
  required String title,
  required String subtitle,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 100.0, height: 100.0),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: const TextStyle(
              color: ThemesStyles.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ThemesStyles.textColor,
                    fontSize: ThemesStyles.littelFontSize),
              ),
            ),
          ),
          const MainLoadingWidget(),
        ],
      ),
    ),
  );
  return result!;
}
