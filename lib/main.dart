import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/common/Util/Locale.dart';
import 'package:events_app/common/Util/LocaleController.dart';
import 'package:events_app/common/view/first_open/welcom_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/core/constants/theme.dart';

void main() {
  // DioHelper.init();
  Get.put(LocalController()); // Initialize and put LocalController instance
  runApp(MyApp());
}

final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: ThemesStyles.primary,
      ),
    );
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: notifier,
        builder: (_, mode, ___) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //Theme
            //========================
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.white, // Light color for dark mode

              backgroundColor:
                  ThemesStyles.backgroundDark, // Dark background color
              scaffoldBackgroundColor:
                  ThemesStyles.backgroundDark, // Background color for scaffold
              cardColor: Colors.grey[900], // Background color for cards
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white), // Text color
                bodyMedium: TextStyle(color: Colors.white), // Text color
                // Add more text styles as needed
              ),
              // Adjust elevation colors if needed
              // Add more configurations as necessary
            ),

            // ThemeData.dark(),
            //========================
            themeMode: mode,

            locale: const Locale('ar'),
            translations: LangLocale(),
            title: 'Events App',
            // put the home page as your main working screen
            home: SafeArea(child: DrawerPage()),

            theme: ThemeData(
              useMaterial3: true,
              // textTheme: GoogleFonts.robotoTextTheme(),
              // fontFamily: GoogleFonts.roboto().fontFamily,
              //the color of th buttom nav bar selected item
              colorScheme: ColorScheme.fromSeed(
                seedColor: ThemesStyles.primary,
                secondary: ThemesStyles.secondary,
                outline: ThemesStyles.secondary,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                prefixIconColor: ThemesStyles.primary,
                outlineBorder: BorderSide(
                  width: .8,
                  color: ThemesStyles.primary,
                ),
                hintStyle: TextStyle(
                  color: ThemesStyles.secondary,
                ),
              ),
            ),
          );
        });
  }
}

    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   locale: const Locale('ar'),
    //   translations: LangLocale(),
    //   title: 'Events App',
    //   // put the home page as your main working screen
    //   home: const SafeArea(child: SplashPage()),
    //   //home: const SafeArea(child: DrawerPage()),
    //   theme: ThemeData(
    //     useMaterial3: true,
    //     // textTheme: GoogleFonts.robotoTextTheme(),
    //     // fontFamily: GoogleFonts.roboto().fontFamily,
    //     colorScheme: ColorScheme.fromSeed(
    //       seedColor: Themes.primary,
    //       secondary: Themes.secondary,
    //       outline: Themes.secondary,
    //     ),
    //     inputDecorationTheme: const InputDecorationTheme(
    //       border: outlineInputBorder,
    //       enabledBorder: outlineInputBorder,
    //       focusedBorder: outlineInputBorder,
    //       prefixIconColor: Themes.primary,
    //       outlineBorder: BorderSide(
    //         width: .8,
    //         color: Themes.primary,
    //       ),
    //       hintStyle: TextStyle(
    //         color: Themes.secondary,
    //       ),
    //     ),
    //   ),
    // );