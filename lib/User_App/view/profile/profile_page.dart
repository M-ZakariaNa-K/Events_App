import 'dart:typed_data';

import 'package:events_app/User_App/components/profile/hidden_budget_data_widget.dart';
import 'package:events_app/User_App/components/profile/hidden_edit_profile_data_widget.dart';
import 'package:events_app/User_App/components/profile/hidder_reset_password_data_widget.dart';
import 'package:events_app/User_App/components/profile/profile_button_widget.dart';
import 'package:events_app/User_App/controllers/profile/profile_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.isComeFromSettings});
  final bool isComeFromSettings;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showHiddenChangePasswordData = true;
  bool _showHiddenEditProfileData = true;
  bool _showHiddenBudgetData = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: widget.isComeFromSettings
          ? AppBar(
              title:  Text("Profile".tr),
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
            )
          : null,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ThemesStyles.backgroundDark
          : ThemesStyles.background,
      //this container for the image background

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: Theme.of(context).brightness == Brightness.dark
                ? null
                : const DecorationImage(
                    image: AssetImage(
                        'assets/images/background.jpg'), // Replace with your image path
                    fit: BoxFit
                        .fill, // Adjust the fit as needed (cover, fill, etc.)
                  ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 7),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 201, 201, 201),
                  spreadRadius: .30,
                  blurRadius: 10,
                  offset: Offset(4, 0),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 66, 66, 66)
                  : ThemesStyles.background,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Stack(
                      children: [
                        profileController.profileItems[0].photo != null ||
                                profileController.profileItems[0].photo != ""
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    "$photoBaseUrl${profileController.profileItems[0].photo}"),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: AssetImage(
                                  "assets/images/Profile.png",
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ThemesStyles.seconndTextColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ThemesStyles.secondary,
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () async {
                                await profileController
                                    .getImage(ImageSource.gallery);
                                // After selecting the image, you can call submitImage to upload it
                                await profileController.submitImage();
                              },
                              //===================================

                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                                color: ThemesStyles.primary,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   left: 0,
                        //   child: Container(
                        //     width: 35,
                        //     height: 35,
                        //     decoration: BoxDecoration(
                        //         color: ThemesStyles.seconndTextColor,
                        //         borderRadius: BorderRadius.circular(10),
                        //         boxShadow: const [
                        //           BoxShadow(
                        //             color: ThemesStyles.secondary,
                        //             spreadRadius: 1,
                        //             blurRadius: 7,
                        //             offset: Offset(0, 0),
                        //           ),
                        //         ]),
                        //     child: IconButton(
                        //       onPressed: () async {
                        //         showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return Dialog(
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(20.0),
                        //               ),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(20.0),
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: [
                        //                     const SizedBox(height: 20),
                        //                     const Icon(
                        //                       Icons.error_outline,
                        //                       color: ThemesStyles.primary,
                        //                       size: 50,
                        //                     ),
                        //                     const SizedBox(height: 20),
                        //                     Text(
                        //                       "Are you sure about deletation?",
                        //                       style: TextStyle(
                        //                         fontSize:
                        //                             ThemesStyles.mainFontSize,
                        //                       ),
                        //                     ),
                        //                     const SizedBox(height: 20),
                        //                     Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.end,
                        //                       children: [
                        //                         TextButton(
                        //                           onPressed: () {
                        //                             Navigator.of(context).pop();
                        //                           },
                        //                           child: const Text('Cancel'),
                        //                         ),
                        //                         const SizedBox(width: 10),
                        //                         ElevatedButton(
                        //                           onPressed: () async {
                        //                             profileController.removeImage(
                        //                                 profileController
                        //                                     .selectedImagePaths[0]);
                        //                             Navigator.of(context).pop();
                        //                           },
                        //                           child: const Text('Submit'),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       },
                        //       //===================================

                        //       icon: const Icon(
                        //         Icons.delete,
                        //         size: 20,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const Text(
                    "Zakaria Na",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "zakariana2003@gmail.com",
                    style: TextStyle(
                      fontSize: ThemesStyles.littelFontSize,
                      color: const Color.fromARGB(255, 146, 146, 146),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _showHiddenChangePasswordData =
                      //       !_showHiddenChangePasswordData;
                      // });
                      // Get.to(const ResetPasswordPage());
                    },
                    child: const ProfileButtonWidget(
                      title: "Change Password",
                      isPressed: false,
                      icon: Icons.lock_outline_rounded,
                    ),
                  ),
                  HiddenResetPasswordDataWidget(
                    oldPasswordController: oldPasswordController,
                    showHiddenChangePasswordData: _showHiddenChangePasswordData,
                    newPasswordController: newPasswordController,
                    confirmNewPasswordController: confirmNewPasswordController,
                  ),
                  //================================2- Edit Profile Card===============================
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _showHiddenEditProfileData =
                      //       !_showHiddenEditProfileData;
                      // });
                    },
                    child: const ProfileButtonWidget(
                      title: "Edit Profile",
                      isPressed: false,
                      icon: Icons.edit_outlined,
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    curve: Curves.ease, // Adjust animation curve
                    child: Visibility(
                      visible: _showHiddenEditProfileData,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: HiddenEditProfileDataWidget()),
                    ),
                  ),
                  //================================3===============================
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   _showHiddenBudgetData = !_showHiddenBudgetData;
                      // });
                    },
                    child: const ProfileButtonWidget(
                      title: "See Budget",
                      isPressed: false,
                      icon: Icons.monetization_on_outlined,
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    curve: Curves.ease, // Adjust animation curve
                    child: Visibility(
                      visible: _showHiddenBudgetData,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: HiddenBudgetDataWidget()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

////////=============================================///////////
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No image selected");
  }

////////=============================================///////////
}
