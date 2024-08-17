import 'package:events_app/User_App/controllers/home/drawer_page_controller.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/custome_drawer_item.dart';
import 'package:events_app/common/components/general/custome_show_dialog.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:events_app/common/view/auth/login_page.dart';
import 'package:events_app/common/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrawerWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Color selectedColor;

  const DrawerWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(DrawerPageController());

    return Container(
      width: 220,
      color: Theme.of(context).brightness == Brightness.dark
          ? ThemesStyles.backgroundDark
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    100), // Half of container width/height for perfect circle
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "assets/images/Logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              profileController.profileItems.isNotEmpty
                  ? profileController.profileItems[0].username
                  : "Zakaria Al-nabulsi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ThemesStyles.mainFontSize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                profileController.profileItems.isNotEmpty
                    ? profileController.profileItems[0].email
                    : "zakariana2003@gmail.com",
                style: TextStyle(
                  fontSize: ThemesStyles.littelFontSize,
                  color: const Color.fromARGB(255, 119, 119, 119),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.grey,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerItem(
                  isLogout: false,
                  title: 'Home'.tr,
                  icon: Icons.home_work_outlined,
                  index: 0,
                  selectedIndex: selectedIndex,
                  onItemTapped: onItemTapped,
                  selectedColor: selectedColor,
                ),
                DrawerItem(
                  isLogout: false,
                  title: 'Profile'.tr,
                  icon: Icons.person_2_outlined,
                  index: 1,
                  selectedIndex: selectedIndex,
                  onItemTapped: onItemTapped,
                  selectedColor: selectedColor,
                ),
                // DrawerItem(
                //   isLogout: false,
                //   title: "Budget",
                //   icon: Icons.money,
                //   index: 2,
                //   selectedIndex: selectedIndex,
                //   onItemTapped: onItemTapped,
                //   selectedColor: selectedColor,
                // ),
                // DrawerItem(
                //   isLogout: false,
                //   title: "History",
                //   icon: Icons.history,
                //   index: 3,
                //   selectedIndex: selectedIndex,
                //   onItemTapped: onItemTapped,
                //   selectedColor: selectedColor,
                // ),
                DrawerItem(
                  isLogout: false,
                  title: "Settings".tr,
                  icon: Icons.settings,
                  index: 2,
                  selectedIndex: selectedIndex,
                  onItemTapped: onItemTapped,
                  selectedColor: selectedColor,
                ),
                DrawerItem(
                  isLogout: false,
                  title: "Help Center".tr,
                  icon: Icons.info_outline_rounded,
                  index: 3,
                  selectedIndex: selectedIndex,
                  onItemTapped: onItemTapped,
                  selectedColor: selectedColor,
                ),
              ],
            ),
            //===============================lang==========================
            // GetBuilder<LanguageRadioController>(
            //     init: LanguageRadioController(),
            //     builder: (LanguageRadioController controller) {
            //       return Center(
            //         child: Padding(
            //           padding: const EdgeInsets.only(bottom: 20.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisSize: MainAxisSize.min,
            //             children: <Widget>[
            //               Text(
            //                 "Arabic".tr,
            //                 style: const TextStyle(
            //                   color: ThemesStyles.primary,
            //                 ),
            //               ),
            //               IconButton(
            //                   onPressed: () {
            //                     controller.toggleLanguage();
            //                   },
            //                   icon: const Icon(
            //                     Icons.swap_horiz_rounded,
            //                     color: ThemesStyles.primary,
            //                     size: 18,
            //                   )),
            //               Text(
            //                 "English".tr,
            //                 style: const TextStyle(
            //                   color: ThemesStyles.primary,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),

            const Spacer(
              flex: 50,
            ),
            DrawerItem(
              isLogout: true,
              title: "Logout".tr,
              icon: Icons.logout,
              index: 6,
              selectedIndex: selectedIndex,
              onItemTapped: (value) {
                // Show loading indicator dialog
                showCustomeLogOutDialog(context);
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) {
                //     return const Center(child: MainLoadingWidget());
                //   },
                // );
                //===============START function to logout==========================
                // DioHelper.get(url: "$baseUrl/auth/logout?");
                // GetStorage().remove('token');
                // print(token);
                // // Hide loading indicator dialog
                // Get.back();
                // token = '';
                // Get.offAll(const SplashPage());
                //===============END function to logout==========================
              },
              selectedColor: selectedColor,
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
