// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/User_App/view/p-event/HelpCenter.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/components/general/custome_show_dialog.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? ThemesStyles.backgroundDark
            : ThemesStyles.background,
        // appBar: AppBar(
        //   title:const  Text('Settings'),
        // ),
        body: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatefulWidget {
  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  bool isDarkMode = false;
  bool isnoti = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        SettingsSection(
          title: 'Account',
          children: [
            SettingsTile(
              isDarkMode: isDarkMode,
              title: 'See Profile',
              icon: Icons.person,
              onPressed: () {
                Get.to(() => const ProfilePage(
                      isComeFromSettings: true,
                    ));
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Notification',
          children: [
            SwitchListTile(
              title: Text(
                'Notification',
                style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: ThemesStyles.littelFontSize),
              ),
              activeColor: const Color(0xFFECB5E2),
              inactiveThumbColor: ThemesStyles.primary,
              value: isnoti ? true : false,
              onChanged: (bool value) {
                setState(() {
                  isnoti = !isnoti;
                });
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Other',
          children: [
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16),
              ),
              activeColor: const Color(0xFF9AD9FE),
              inactiveThumbColor: Colors.blue,
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                  notifier.value =
                      isDarkMode ? ThemeMode.dark : ThemeMode.light;
                });
              },
              secondary: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: isDarkMode ? Colors.yellow : Colors.grey,
                    key: ValueKey<bool>(isDarkMode),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Language',
                style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: ThemesStyles.littelFontSize),
              ),
            ),
            GetBuilder<LanguageRadioController>(
                init: LanguageRadioController(),
                builder: (LanguageRadioController controller) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Arabic".tr,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: ThemesStyles.littelFontSize,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.toggleLanguage();
                              },
                              icon: Icon(
                                Icons.swap_horiz_rounded,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: 18,
                              )),
                          Text(
                            "English".tr,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: ThemesStyles.littelFontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ListTile(
              title: Text(
                'Region',
                style: TextStyle(
                  fontSize: ThemesStyles.littelFontSize,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              trailing: Text(
                'Damascus',
                style: TextStyle(
                    fontSize: ThemesStyles.littelFontSize,
                    color: const Color.fromARGB(255, 198, 198, 198)),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const HelpCenterPage(isUserCameFromDrawer: false));
              },
              child: ListTile(
                title: Text(
                  'About Us',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: ThemesStyles.littelFontSize),
                ),
              ),
            ),
          ],
        ),
        DefultButton(
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          buttonColor: ThemesStyles.background,
          borderColor: ThemesStyles.background,
          textColor: Colors.red,
          title: 'Log Out',
          onPressed: () {
            showCustomeLogOutDialog(context);
          },
        ),
      ],
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ThemesStyles.mainFontSize,
              fontWeight: FontWeight.bold,
              color: ThemesStyles.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDarkMode;
  final void Function()? onPressed;

  const SettingsTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ThemesStyles.primary),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: ThemesStyles.littelFontSize,
        ),
      ),
      onTap: onPressed,
    );
  }
}
