// import 'dart:io';
// import 'dart:typed_data';

// import 'package:events_app/User_App/components/profile/hidden_budget_data_widget.dart';
// import 'package:events_app/User_App/components/profile/hidden_edit_profile_data_widget.dart';
// import 'package:events_app/User_App/components/profile/hidder_reset_password_data_widget.dart';
// import 'package:events_app/User_App/components/profile/profile_button_widget.dart';
// import 'package:events_app/common/core/constants/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool _showHiddenChangePasswordData = false;
//   bool _showHiddenEditProfileData = false;
//   bool _showHiddenBudgetData = false;
//   TextEditingController newPasswordController = TextEditingController();
//   TextEditingController confirmNewPasswordController = TextEditingController();
//   TextEditingController oldPasswordController = TextEditingController();
//   Uint8List? _image;
//   String? _imagePath;
//   void selectImage() async {
//     Uint8List? img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = img;
//       if (_image != null) {
//         saveImageToStorage(_image!);
//         // (Optional) Update user profile with the saved path
//       } else {
//         print('No image selected');
//       }
//     });
//   }

//   Future<void> saveImageToStorage(Uint8List imageData) async {
//     // Replace with your actual image storage logic
//     // (e.g., saving to local storage, cloud storage)
//     // This example demonstrates saving to a temporary file

//     final tempDir = await getTemporaryDirectory(); // Get temporary directory
//     final filePath = '${tempDir.path}/profile_image.png';
//     final file = File(filePath);

//     await file.writeAsBytes(imageData); // Write image data to the file
//     print('Image saved to: $filePath'); // (Optional: Print for debugging)

//     // (Optional) Update user profile with the saved image path
//     // (This depends on your user data management system)
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).brightness == Brightness.dark
//           ? ThemesStyles.backgroundDark
//           : ThemesStyles.thirdColor,
//       //this container for the image background

//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             image: Theme.of(context).brightness == Brightness.dark
//                 ? null
//                 : const DecorationImage(
//                     image: AssetImage(
//                         'assets/images/background.jpg'), // Replace with your image path
//                     fit: BoxFit
//                         .fill, // Adjust the fit as needed (cover, fill, etc.)
//                   ),
//           ),
//           child: Container(
//             margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 7),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(50),
//                 topRight: Radius.circular(50),
//               ),
//               color: Theme.of(context).brightness == Brightness.dark
//                   ? const Color.fromARGB(255, 66, 66, 66)
//                   : ThemesStyles.background,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 60.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Stack(
//                     children: [
//                       _image != null
//                           ? CircleAvatar(
//                               radius: 64,
//                               backgroundImage: MemoryImage(_image!),
//                             )
//                           : const CircleAvatar(
//                               radius: 64,
//                               backgroundImage: AssetImage(
//                                 "assets/images/Profile.png",
//                               ),
//                             ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           width: 35,
//                           height: 35,
//                           decoration: BoxDecoration(
//                               color: ThemesStyles.seconndTextColor,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: ThemesStyles.secondary,
//                                   spreadRadius: 1,
//                                   blurRadius: 7,
//                                   offset: Offset(0, 0),
//                                 ),
//                               ]),
//                           child: IconButton(
//                             // onPressed: () async {
//                             //   Map<Permission, PermissionStatus> statuses =
//                             //       await [
//                             //     Permission.storage,
//                             //     Permission.camera,
//                             //   ].request();

//                             //   if (statuses[Permission.storage]!.isGranted &&
//                             //       statuses[Permission.camera]!.isGranted) {
//                             //     showImagePicker(context);
//                             //   } else {
//                             //     print('no permission provided');
//                             //   }
//                             // },
//                             onPressed: selectImage,

//                             icon: const Icon(
//                               Icons.camera_alt_outlined,
//                               size: 20,
//                               color: ThemesStyles.primary,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const Text(
//                     "Zakaria Na",
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "zakariana2003@gmail.com",
//                     style: TextStyle(
//                       fontSize: ThemesStyles.littelFontSize,
//                       color: const Color.fromARGB(255, 146, 146, 146),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _showHiddenChangePasswordData =
//                             !_showHiddenChangePasswordData;
//                       });
//                       // Get.to(const ResetPasswordPage());
//                     },
//                     child: const ProfileButtonWidget(
//                       title: "Change Password",
//                       isPressed: false,
//                       icon: Icons.lock_outline_rounded,
//                     ),
//                   ),
//                   HiddenResetPasswordDataWidget(
//                     oldPasswordController: oldPasswordController,
//                     showHiddenChangePasswordData: _showHiddenChangePasswordData,
//                     newPasswordController: newPasswordController,
//                     confirmNewPasswordController: confirmNewPasswordController,
//                   ),
//                   //================================2- Edit Profile Card===============================
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _showHiddenEditProfileData =
//                             !_showHiddenEditProfileData;
//                       });
//                     },
//                     child: const ProfileButtonWidget(
//                       title: "Edit Profile",
//                       isPressed: false,
//                       icon: Icons.edit_outlined,
//                     ),
//                   ),
//                   AnimatedSize(
//                     duration: const Duration(milliseconds: 300),
//                     reverseDuration: const Duration(milliseconds: 300),
//                     curve: Curves.ease, // Adjust animation curve
//                     child: Visibility(
//                       visible: _showHiddenEditProfileData,
//                       child: const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 30.0),
//                           child: HiddenEditProfileDataWidget()),
//                     ),
//                   ),
//                   //================================3===============================
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _showHiddenBudgetData = !_showHiddenBudgetData;
//                       });
//                     },
//                     child: const ProfileButtonWidget(
//                       title: "See Budget",
//                       isPressed: false,
//                       icon: Icons.monetization_on_outlined,
//                     ),
//                   ),
//                   AnimatedSize(
//                     duration: const Duration(milliseconds: 300),
//                     reverseDuration: const Duration(milliseconds: 300),
//                     curve: Curves.ease, // Adjust animation curve
//                     child: Visibility(
//                       visible: _showHiddenBudgetData,
//                       child: const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 30.0),
//                           child: HiddenBudgetDataWidget()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// ////////=============================================///////////
//   pickImage(ImageSource source) async {
//     final ImagePicker _imagePicker = ImagePicker();
//     XFile? _file = await _imagePicker.pickImage(source: source);
//     if (_file != null) {
//       return await _file.readAsBytes();
//     }
//     print("No image selected");
//   }

// ////////=============================================///////////
// }
import 'dart:typed_data';

import 'package:events_app/User_App/components/profile/hidden_budget_data_widget.dart';
import 'package:events_app/User_App/components/profile/hidden_edit_profile_data_widget.dart';
import 'package:events_app/User_App/components/profile/hidder_reset_password_data_widget.dart';
import 'package:events_app/User_App/components/profile/profile_button_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showHiddenChangePasswordData = false;
  bool _showHiddenEditProfileData = false;
  bool _showHiddenBudgetData = false;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  Uint8List? _image;
  // String? _imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future<void> _loadImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? imagePath = prefs.getString('profile_image');
  //   if (imagePath != null) {
  //     setState(() {
  //       _imagePath = imagePath;
  //       _image = File(imagePath).readAsBytesSync();
  //     });
  //   }
  // }

  // Future<void> _saveImage(Uint8List imageBytes) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final imagePath = '${directory.path}/profile_image.png';
  //   final imageFile = File(imagePath);
  //   await imageFile.writeAsBytes(imageBytes);

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('profile_image', imagePath);

  //   setState(() {
  //     _imagePath = imagePath;
  //     _image = imageBytes;
  //   });
  // }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
      // _saveImage(_image!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ThemesStyles.backgroundDark
          : ThemesStyles.background,
      //this container for the image background

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(

              // image: Theme.of(context).brightness == Brightness.dark
              //     ? null
              //     : const DecorationImage(
              //         image: AssetImage(
              //             'assets/images/background.jpg'), // Replace with your image path
              //         fit: BoxFit
              //             .fill, // Adjust the fit as needed (cover, fill, etc.)
              //       ),
              ),
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 7),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ThemesStyles.backgroundDark,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 0),
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
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
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
                            // onPressed: () async {
                            //   Map<Permission, PermissionStatus> statuses =
                            //       await [
                            //     Permission.storage,
                            //     Permission.camera,
                            //   ].request();

                            //   if (statuses[Permission.storage]!.isGranted &&
                            //       statuses[Permission.camera]!.isGranted) {
                            //     showImagePicker(context);
                            //   } else {
                            //     print('no permission provided');
                            //   }
                            // },
                            onPressed: selectImage,

                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                              color: ThemesStyles.primary,
                            ),
                          ),
                        ),
                      )
                    ],
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
                      setState(() {
                        _showHiddenChangePasswordData =
                            !_showHiddenChangePasswordData;
                      });
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
                      setState(() {
                        _showHiddenEditProfileData =
                            !_showHiddenEditProfileData;
                      });
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
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: HiddenEditProfileDataWidget()),
                    ),
                  ),
                  //================================3===============================
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showHiddenBudgetData = !_showHiddenBudgetData;
                      });
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
