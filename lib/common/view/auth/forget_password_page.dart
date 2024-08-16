import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/controllers/auth/forget_password_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/view/auth/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  ForgetPasswordPage({super.key});
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Forgot Password"),
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
          body: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              "assets/images/forgot-password.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Select which contact details should we use to reset your password",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 350,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            border: Border.all(
                              color: ThemesStyles.primary,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: ThemesStyles.thirdColor,
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: const Icon(
                                    Icons.email,
                                    color: ThemesStyles.primary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      "via Email:",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500),
                                    ),
                                  ),
                                  subtitle: CustomeTextFormField(
                                    hintText: "********@gmail.com",
                                    inputType: TextInputType.emailAddress,
                                    title: "",
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ForgetPasswordController()
                                            .isEmailValid = false;
                                        return 'Please enter your email';
                                      }
                                      ForgetPasswordController().isEmailValid =
                                          true;
                                      return null;
                                    },
                                    prefixIcon: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            createPasswordEmail = emailController.text;
                            final response = await controller.post(
                              theEmail: emailController.text,
                              body: {"email": emailController.text},
                              url: '$baseUrl/auth/forget-password',
                            );

                            if (controller.statusCode.value == 200) {
                              Get.to(() => OtpPage(
                                    email: emailController.text,
                                    isForgetPassword: true,
                                  ));
                              controller.statusCode.value = 0;
                            } else {
                              Get.snackbar(
                                'Warning',
                                'This Email is not correct, please try again',
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: MainLoadingWidget(),
              ),
            );
          } else {
            return const SizedBox.shrink(); // Empty container when not loading
          }
        }),
      ],
    );
  }
}
