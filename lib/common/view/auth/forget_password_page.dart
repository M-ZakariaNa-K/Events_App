import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/view/auth/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool isEmailSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            //1
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
            //====2=====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Select which contact details should we use to reset your password",
                style: TextStyle(fontSize: 16),
              ),
            ),
            //====3=====
            GestureDetector(
              onTap: () {
                setState(() {
                  isEmailSelected = true;
                });
              },
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    color: isEmailSelected
                        ? ThemesStyles.primary
                        : Colors.grey.shade200,
                    width: isEmailSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100), // Half of container width/height for perfect circle
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
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "via Email:",
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade500),
                          ),
                        ),
                        subtitle: const Text(
                          "zakariana2003@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //====3=====
            GestureDetector(
              onTap: () {
                setState(() {
                  isEmailSelected = false;
                });
              },
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                      color: isEmailSelected
                          ? Colors.grey.shade200
                          : ThemesStyles.primary,
                      width: isEmailSelected ? 1 : 2),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100), // Half of container width/height for perfect circle
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ThemesStyles.thirdColor,
                        ),
                        width: 60,
                        height: 60,
                        child: const Icon(
                          Icons.message,
                          color: ThemesStyles.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "via SMS:",
                            style: TextStyle(
                                fontSize: 11, color: Colors.grey.shade500),
                          ),
                        ),
                        subtitle: const Text(
                          "+963 969***277",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //====5=====
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: DefultButton(
                buttonColor: ThemesStyles.primary,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                title: "Continue",
                onPressed: () {
                  Get.to(OtpPage(
                    isForgetPassword: true,
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
