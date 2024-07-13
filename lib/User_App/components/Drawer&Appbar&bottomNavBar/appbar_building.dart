import 'package:events_app/User_App/controllers/home/drawer_page_controller.dart';
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/User_App/view/search/search_page.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// AppBarBuilding function
AppBar? appBarBuilding(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return MediaQuery.of(context).size.width <= 900
      ? AppBar(
          backgroundColor: ThemesStyles.primary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.notifications,
                color: ThemesStyles.background,
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>  const SearchPage(),);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.search,
                  color: ThemesStyles.background,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ValueListenableBuilder<ThemeMode>(
                  valueListenable: notifier,
                  builder: (_, mode, ___) {
                    return GestureDetector(
                      onTap: () => notifier.value = mode == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      child: const Icon(
                        Icons.dark_mode,
                        color: ThemesStyles.background,
                      ),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.language,
                color: ThemesStyles.background,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 10))
            // GestureDetector(
            //   onTap: () {
            //     Get.find<DrawerPageController>().changeDrawerTabIndex(1);

            //   },
            //   child: Padding(
            //     padding: LanguageRadioController().selectedValue
            //         ? const EdgeInsets.only(left: 30.0, right: 8.0)
            //         : const EdgeInsets.only(left: 8.0, right: 30.0),
            //     child: const CircleAvatar(
            //       radius: 20,
            //       backgroundImage: AssetImage(
            //           "assets/images/Profile.png"), // Change image path
            //     ),
            //   ),
            // ),
          ],
        )
      : null;
}
