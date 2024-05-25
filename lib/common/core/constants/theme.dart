import 'package:flutter/material.dart';

class ThemesStyles {
  //Light Mode
  static const primary = Color(0xFFD03171);
  static const secondary = Color(0xFFFEB0BD);
  static const thirdColor = Color(0xFFFFE4E8);
  static const blueColor = Color(0xFF9AD9FE);
  static const greenColor = Color(0xFF8FE1B9);
  static const background = Colors.white;
  //Dark Mode
  static const primaryDark = Color(0xFFD03171);
  static const secondaryDark = Color(0xFFECB5E2);
  static const thirdColorDark = Color(0xFFFFE4E8);
  static const backgroundDark = Color(0xFF1C1C1C);
  //text colors
  static const textColor = Color.fromARGB(255, 43, 43, 43);
  static const seconndTextColor = Colors.white;
  //static const bottomBarColor = Color(0xFFECB5E2);
  //padding all
  static double distancePrimary = 10;
  static double paddingprimary = distancePrimary;
  static double marginprimary = distancePrimary;
  static double borderradiusprimary = distancePrimary;
//fonts
  static FontWeight fontWeightBold = FontWeight.bold;
  static double mainFontSize = 18;
  static double littelFontSize = 14;
}
/*
to make colors for dark and light modes
Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : ThemesStyles.secondary, */
