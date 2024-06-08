// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/Util/slide_to_page_route.dart';
import 'package:events_app/common/view/auth/create_new_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/common/components/auth/otp/number_fild_otp.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/controllers/auth/forget_password_controller.dart';
import 'package:events_app/common/controllers/auth/otp_timer_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';

class OtpPage extends StatelessWidget {
  final TimerController timerController = Get.put(TimerController());
  final String email;
  OtpPage({
    Key? key,
    required this.email,
    required this.isForgetPassword,
  }) : super(key: key);
  final bool isForgetPassword;
  final TextEditingController changeNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
          init: ForgetPasswordController(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(ThemesStyles.paddingprimary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Verification code",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ThemesStyles.seconndTextColor
                            : ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),
                  //2
                  const Text(
                    "We have sent the code verification to",
                    style: TextStyle(
                      color: Color(0xff45444B),
                    ),
                  ),
                  //3
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Text(
                          controller.maskEmailOtp(controller.email),
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? ThemesStyles.seconndTextColor
                                    : ThemesStyles.textColor,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final shouldNavigate =
                                await showConfirmationDialogOTP(
                                    forgetPasswordController: controller,
                                    context: context,
                                    imagePath:
                                        'assets/images/shield (1).png', // Replace with your image path
                                    title: 'Change Email',
                                    changeEmailController:
                                        changeNumberController);

                            if (shouldNavigate ?? false) {
                              //Here will make the post request which has the changing number
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Change Email Addres?",
                              style: TextStyle(
                                color: ThemesStyles.primary,
                                fontWeight: ThemesStyles.fontWeightBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //NOTE: here i will Save the PINs Data
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              //to go to another textfild directly
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber1 = value;
                          },
                          onSaved: (pin1) {}),
                      CustomeNumberFildOTP(onChanged: (value) {
                        if (value!.length == 1) {
                          //to go to another textfild directly
                          FocusScope.of(context).nextFocus();
                        }
                        print("$value");
                        controller.otpNumber2 = value;
                      }, onSaved: (pin2) {
                        // controller.otpNumber2 = pin2;
                      }),
                      CustomeNumberFildOTP(onChanged: (value) {
                        if (value!.length == 1) {
                          //to go to another textfild directly
                          FocusScope.of(context).nextFocus();
                        }
                        print("$value");
                        controller.otpNumber3 = value;
                      }, onSaved: (pin3) {
                        // controller.otpNumber3 = pin3;
                      }),
                      CustomeNumberFildOTP(
                          onChanged: (value) {
                            if (value!.length == 1) {
                              //to go to another textfild directly
                              FocusScope.of(context).nextFocus();
                            }
                            print("$value");
                            controller.otpNumber4 = value;
                          },
                          onSaved: (pin4) {}),
                    ],
                  ),
                  //5
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Resend code after ",
                            style: TextStyle(
                              color: Color(0xff45444B),
                            ),
                          ),
                          Obx(
                            () => Center(
                              child: Text(
                                timerController
                                    .start.value, // Display timer value
                                style: const TextStyle(
                                  color: ThemesStyles.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //6
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DefultButton(
                          textColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? ThemesStyles.seconndTextColor
                                  : ThemesStyles.textColor,
                          buttonColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? ThemesStyles.backgroundDark
                                  : ThemesStyles.seconndTextColor,
                          borderColor: ThemesStyles.primary,
                          title: "Resend",
                          onPressed: () {
                            //Here we will Resend the OTP code again
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                        horizontal: ThemesStyles.paddingprimary / 2,
                      )),
                      Expanded(
                        child: DefultButton(
                          textColor: ThemesStyles.seconndTextColor,
                          buttonColor: ThemesStyles.primary,
                          borderColor: ThemesStyles.primary,
                          title: "Confirm",
                          onPressed: () async {
                            print(email);
                            print(
                                '${controller.otpNumber1}${controller.otpNumber2}${controller.otpNumber3}${controller.otpNumber4}');

                            final response = await DioHelper.post(
                                url: "$baseUrl/auth/res-pass-verification",
                                body: {
                                  'email': '${email}',
                                  'otp':
                                      '${controller.otpNumber1}${controller.otpNumber2}${controller.otpNumber3}${controller.otpNumber4}'
                                });
                            print(response["data"]);

                            // Check the status code and perform the corresponding action
                            if (response != null) {
                              if (response["data"]) {
                                isForgetPassword
                                    ? Navigator.push(
                                        context,
                                        SlidToPage(
                                          page: const CreateNewPasswordPage(),
                                          onComplete: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateNewPasswordPage()));
                                          },
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        SlidToPage(
                                          page: const DrawerPage(),
                                          onComplete: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DrawerPage()));
                                          },
                                        ),
                                      );
                              } else {
                                Get.snackbar(
                                  'Warning',
                                  'The OTP number is not correct, please try again',
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

Future<bool?> showConfirmationDialogOTP({
  required BuildContext context,
  required String imagePath,
  required String title,
  required TextEditingController changeEmailController,
  required ForgetPasswordController forgetPasswordController,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white, //
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
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CustomeTextFormField(
              hintText:
                  'forgetPasswordController.maskEmailOtp(forgetPasswordController.email)',
              inputType: TextInputType.emailAddress,
              title: "",
              controller: changeEmailController,
              validator: (value) {},
              prefixIcon: const Icon(Icons.email),
            ),
          )
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: ThemesStyles.secondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            // forgetPasswordController.email = changeEmailController.text;
            // print(forgetPasswordController.email);
            // final response = await forgetPasswordController.post(
            //   theEmail: forgetPasswordController.email,
            //   body: {"email": forgetPasswordController.email},
            //   url: '$baseUrl/auth/forget-password',
            // );
            // Check the status code and perform the corresponding action
            if (forgetPasswordController.statusCode.value == 200) {
              // Get.to(OtpPage(
              //   isForgetPassword: true,
              // ));
              // forgetPasswordController.statusCode.value = 0;
            } else {
              Get.snackbar(
                'Warning',
                'This Email is not correct, please try again',
              );
            }

            Navigator.pop(context, true);
            //possssst
          },
          child: const Text(
            'Continue',
          ),
        ),
      ],
    ),
  );
  return result;
}
