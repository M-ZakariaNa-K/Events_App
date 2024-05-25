// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/common/core/constants/theme.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Color selectedColor;
  final bool isLogout;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.selectedColor,
    required this.isLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 300), // Duration of the animation
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Theme.of(context).brightness == Brightness.dark
                  ? Color(0xff2B2B2B)
                  : ThemesStyles.thirdColor
              : Theme.of(context).brightness == Brightness.dark
                  ? ThemesStyles.backgroundDark
                  : ThemesStyles.background,
          borderRadius:
              //  BorderRadius.only(
              //   topLeft: Get.locale?.languageCode == 'ar'
              //       ? const Radius.circular(30)
              //       : Radius.zero,
              //   bottomLeft: Get.locale?.languageCode == 'ar'
              //       ? const Radius.circular(30)
              //       : Radius.zero,
              //   topRight: Get.locale?.languageCode == 'en'
              //       ? const Radius.circular(30)
              //       : Radius.zero,
              //   bottomRight: Get.locale?.languageCode == 'en'
              //       ? const Radius.circular(30)
              //       : Radius.zero,
              // ),
              BorderRadius.circular(10),
        ),
        child: ListTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                color: selectedIndex == index
                    ? ThemesStyles.primary
                    : isLogout
                        ? Colors.red
                        : const Color.fromARGB(255, 119, 119, 119),
                fontWeight: isLogout ? FontWeight.bold : null,
              ),
            ),
          ),
          tileColor:
              selectedIndex == index ? selectedColor : Colors.transparent,
          leading: Icon(
            icon,
            color: selectedIndex == index
                ? ThemesStyles.primary
                : isLogout
                    ? Colors.red
                    : Color.fromARGB(255, 119, 119, 119),
          ),
          selected: selectedIndex == index,
        ),
      ),
    );
  }
}
