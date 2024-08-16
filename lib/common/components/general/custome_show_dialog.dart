// import 'package:events_app/common/core/constants/theme.dart';
// import 'package:flutter/material.dart';

// class CustomDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final double width;
//   final double height;

//   CustomDialog({
//     required this.title,
//     required this.content,
//     required this.width,
//     required this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: _buildDialogContent(context),
//     );
//   }

//   Widget _buildDialogContent(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: ThemesStyles.background,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               image,
//               width: 50,
//               height: 50,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               content,
//               textAlign: TextAlign.center,
//               style:
//                   const TextStyle(fontSize: 16, color: ThemesStyles.textColor),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: ThemesStyles.primary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Close',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void showCustomDialog(
//   BuildContext context,
//   String title,
//   String content,
//   double width1,
//   double height1,
// ) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CustomDialog(
//         title: title,
//         content: content,
//         width: width1,
//         height: height1,
//       );
//     },
//   );
// }
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:events_app/common/view/auth/login_page.dart';
import 'package:events_app/common/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void showCustomeLogOutDialog(BuildContext context) {
  Get.defaultDialog(
    title: "Warning",
    middleText: "Are you sure about logging out?",
    backgroundColor: Colors.white,
    titleStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: ThemesStyles.mainFontSize,
    ),
    middleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: ThemesStyles.littelFontSize,
    ),
    textConfirm: "Logout",
    textCancel: "Cancel",
    cancelTextColor: Colors.black,
    confirmTextColor: Colors.white,
    buttonColor: ThemesStyles.primary,
    onConfirm: () async {
      Get.back(); // Close the dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: MainLoadingWidget());
        },
      );
      // ===============START function to logout==========================
      await DioHelper.get(url: "$baseUrl/auth/logout");
      GetStorage().remove('token');
      GetStorage().remove('role');
      // Hide loading indicator dialog
      Get.back();
      token = '';
      role = '';
      userEmail = '';
      isUser = null;
      isHallOwner = null;

      Get.offAll(const LoginPage());
      // ===============END function to logout==========================
      print("User wants to log out");
      print(token);
    },
    onCancel: () {
      print("User canceled the login");
    },
  );
}
