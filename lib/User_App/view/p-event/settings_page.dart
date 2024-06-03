  import 'package:events_app/User_App/view/home/drawer-page.dart';
import 'package:events_app/User_App/view/home/homePage.dart';
import 'package:events_app/User_App/view/p-event/HelpCenter.dart';
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:events_app/common/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class SettingsPage extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:const  Text('Settings'),
        ),
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
  bool isdark =false ;
  bool isnoti =false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: ListView(
      padding:const  EdgeInsets.all(20.0),
      children: [
        SettingsSection(
          title: 'Account',
          children: [
            SettingsTile(title: 'See Profile', icon: Icons.person),
        
          ],
        ),           

        SettingsSection(
          title: 'Notification',
          children: [
            SwitchListTile(
              title:const  Text('Notification',style:TextStyle(fontSize: 20),),
              activeColor: Color(0xFFECB5E2),
              inactiveThumbColor: ThemesStyles.primary,
              value:isnoti?  true : false,
              onChanged: (bool value) {
                  setState(() {
                                 isnoti=!isnoti;
            
                  });
              },
            ),
           
          ],
        ),
        SettingsSection(
          title: 'Other',
          children: [
            SwitchListTile(
              title: Text('Dark Mode',style:TextStyle(fontSize: 20),),
              activeColor: Color(0xFF9AD9FE),
               inactiveThumbColor: ThemesStyles.primary,

              value: isdark? false  :true ,
              onChanged: (bool value) {
               setState(() {
                                 isdark=!isdark;

                  });

              },
            ),
            const ListTile(
              title: Text('Language',style:TextStyle(fontSize: 20),
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
                          style: const TextStyle(
                         fontSize: 20,

                            color: Color(0xFFECB5E2),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.toggleLanguage();
                            },
                            icon: const Icon(
                              Icons.swap_horiz_rounded,
                              color: Colors.black,
                              size: 18,
                            )),
                        Text(
                          "English".tr,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFFECB5E2)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
           const  ListTile(
              title: Text('Region',style:TextStyle(fontSize: 20),),
              trailing: Text('Pakistan',style:TextStyle(fontSize: 18),),
            ),
          const  ListTile(
              title: Text('About Us',style:TextStyle(fontSize: 20),),
            ),
            
          ],
        ),
        
          ],
    ),  
    bottomNavigationBar: BottomAppBar(
       color: Colors.transparent,
        child: ElevatedButton(
                      onPressed: () {
                       Get.to(LoginPage());
                      },
                      // ignore: sort_child_properties_last
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(flex: 3,),

                          Icon(Icons.logout,color:  Color(0xFFFBEFF6),),
                          Spacer(flex: 1,),
                           Text('Log Out',style: TextStyle(color: Color(0xFFFBEFF6),),),
                           Spacer(flex:3,),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ThemesStyles.primary,
                        padding:const  EdgeInsets.symmetric(horizontal: 55, vertical: 25),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
        
        ),
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
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:const  TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ThemesStyles.primary,
              
            ),
          ),
          
          SizedBox(height: 8),
           
          ...children,
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;

  SettingsTile({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color:ThemesStyles.primary),
      title: Text(title,style:TextStyle(fontSize: 20),),
      onTap: () {Get.to(HelpCenterPage());
      // DioHelper.get(url: url);
      },
    );
 
    
  }
}