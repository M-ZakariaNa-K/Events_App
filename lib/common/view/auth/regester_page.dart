import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/components/auth/login-defult_button.dart';
import 'package:events_app/common/controllers/auth/regester_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          color: ThemesStyles.textColor,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      backgroundColor: ThemesStyles.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GetBuilder<RegisterController>(builder: (controller) {
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
                        "Create New Account",
                        style: TextStyle(
                          fontSize: 30,
                          color: ThemesStyles.textColor,
                        ),
                      ),
                    ),
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.assignment_ind_rounded),
                    hintText: 'First name',
                    inputType: TextInputType.text,
                    title: 'First name',
                    controller: controller.firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your First name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Last name',
                    inputType: TextInputType.text,
                    title: 'Last name',
                    controller: controller.lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Username',
                    inputType: TextInputType.text,
                    title: 'Username',
                    controller: controller.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Enter your Email',
                    inputType: TextInputType.text,
                    title: 'Email',
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.place),
                    hintText: 'residence place',
                    inputType: TextInputType.text,
                    title: 'Residence Place',
                    controller: controller.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your residence place';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.place),
                    hintText: 'Phone Number',
                    inputType: TextInputType.number,
                    title: 'Phone Number',
                    controller: controller.phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      return null;
                    },
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xffFAFAFb),
                  //     borderRadius: BorderRadius.circular(20),
                  //     // boxShadow: const [
                  //     //   BoxShadow(
                  //     //     color: Colors.red,
                  //     //     spreadRadius: 5,
                  //     //     blurRadius: 7,
                  //     //     offset: Offset(0, 3),
                  //     //   ),
                  //     // ]
                  //   ),
                  //   child: IntlPhoneField(
                  //     onChanged: (phone) {
                  //       print(phone.completeNumber);
                  //     },
                  //     pickerDialogStyle: PickerDialogStyle(
                  //       searchFieldInputDecoration: InputDecoration(
                  //         prefixIcon: const Icon(Icons.search),
                  //         hintText: "Search",
                  //         hintStyle: const TextStyle(
                  //             color: Color.fromARGB(255, 87, 87, 87)),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //           borderSide: const BorderSide(
                  //             width: 1,
                  //             color: ThemesStyles.primary,
                  //           ),
                  //         ),
                  //       ),
                  //       backgroundColor: ThemesStyles.background,
                  //       width: MediaQuery.sizeOf(context).width,
                  //     ),
                  //     decoration: InputDecoration(
                  //       enabledBorder: const OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           width: 1,
                  //           color: Colors.transparent,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(
                  //             color: ThemesStyles.primary, width: 2.0),
                  //         borderRadius: BorderRadius.circular(
                  //             ThemesStyles.borderradiusprimary + 5),
                  //       ),
                  //       hintText: 'Phone Number',
                  //       hintStyle: TextStyle(
                  //         color: Color.fromARGB(255, 220, 220, 220),
                  //         fontSize: 16,
                  //       ),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  //     ),
                  //     initialCountryCode: 'SY',
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.lock),
                    inputType: TextInputType.text,
                    hintText: '••••••••••••••••',
                    title: 'Password',
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeLoginTextFormField(
                    prefixIcon: const Icon(Icons.lock),
                    inputType: TextInputType.text,
                    hintText: '••••••••••••••••',
                    title: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  LoginDefultButton(
                    buttonColor: ThemesStyles.primary,
                    borderColor: Colors.transparent,
                    textColor: ThemesStyles.seconndTextColor,
                    title: "Sign up",
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        // If the form is valid, proceed with login logic
                        controller.regesterState();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Color(0xff696969)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginPage());
                            },
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1.0)),
                              ),
                              child: Text(
                                "Sign in.",
                                style: TextStyle(
                                  color: ThemesStyles.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
