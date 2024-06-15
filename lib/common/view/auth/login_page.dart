import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/User_App/view/p-event/public-event.dart';
import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/components/auth/login-defult_button.dart';
import 'package:events_app/common/controllers/auth/login_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/helper/show_toast.dart';
import 'package:events_app/common/view/auth/forget_password_page.dart';
import 'package:events_app/common/view/auth/regester_page.dart';
import 'package:events_app/common/view/first_open/onBoading/third_boading.dart';
import 'package:events_app/common/view/first_open/welcom_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
       AppBar(
        title: GestureDetector(
          onTap: () {
            Get.to(() => PublicEventPage(
                  isUserLoggedIn: false,
                ));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "SKIP",
              ),
            ],
          ),
        ),
        titleTextStyle: const TextStyle(color: Color(0xff464646), fontSize: 16),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          color: ThemesStyles.textColor,
          onPressed: () {
            Get.off(const ThirdBoading());
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      backgroundColor: ThemesStyles.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              100), // Half of container width/height for perfect circle
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              "assets/images/Logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //1
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Login to Your Account",
                          style: TextStyle(
                            fontSize: 30,
                            color: ThemesStyles.textColor,
                          ),
                        ),
                      ),
                    ),
                    //2
                    CustomeLoginTextFormField(
                      hintText: 'Username or Emile',
                      inputType: TextInputType.text,
                      title: 'Username|Emile',
                      prefixIcon: const Icon(Icons.email),
                      //Emile validator
                      controller: controller.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username or email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    //3
                    CustomeLoginTextFormField(
                      prefixIcon: const Icon(Icons.lock),
                      inputType: TextInputType.text,
                      hintText: '••••••••••••••••',
                      title: 'Password',
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    //4
                    LoginDefultButton(
                      buttonColor: ThemesStyles.primary,
                      borderColor: Colors.transparent,
                      textColor: ThemesStyles.seconndTextColor,
                      title: "Sign in",
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          // If the form is valid, proceed with login logic
                          controller.loginState(
                            userName: controller.usernameController.text,
                            password: controller.passwordController.text,
                          );
                        } else {
                          // If the form is invalid, show a toast message
                          // showToast(
                          //   msg: "Please correct the form and try again",
                          //   backgroundColor: Colors.red,
                          // );
                          Get.snackbar('Warnning',
                              'Please correct the form and try again');
                        }
                      },
                    ),
                    //====================================Forget password =====================================
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgetPasswordPage());
                        //here will show dialog
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ThemesStyles.paddingprimary + 10),
                        child: const Center(
                          child: Text(
                            "Forget the password?",
                            style: TextStyle(
                              color: ThemesStyles.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //====================================Forget password =====================================
                    //=====================================Google==========================================

                    //5
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 20),
                          child: Text(
                            "or continue with",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Sign in by Google
                    Center(
                      child: SizedBox(
                        width: 90,
                        child: LoginDefultButton(
                          buttonColor: ThemesStyles.background,
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? ThemesStyles.seconndTextColor
                                  : ThemesStyles.textColor,
                          borderColor: Colors.grey,
                          title: "",
                          icon: Image.asset(
                            'assets/images/Google.png',
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {
                            //Sign in by GOOGLE
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Color(0xff696969)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const RegisterPage());
                            },
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1.0)),
                              ),
                              child: Text(
                                "Sign up.",
                                style: TextStyle(
                                  color: ThemesStyles.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
