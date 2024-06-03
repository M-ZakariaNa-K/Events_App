import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/appbar_building.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/custome_drawer.dart';
import 'package:events_app/User_App/controllers/home/drawer_page_controller.dart';
import 'package:events_app/User_App/view/p-event/public-event.dart';
import 'package:events_app/User_App/view/p-event/settings_page.dart';
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/User_App/view/search/search_page.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/User_App/view/booking/main_booking_page.dart';
import 'package:events_app/User_App/view/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final DrawerPageController controller = Get.put(DrawerPageController());

  bool isButtomNavPressed = false;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    SecondPage(),
    //here u will go to ADD page and also in the + button u gonna go to Add page
    MainBookingPage(),
    PublicEventPage(),
    const SearchPage(),
  ];

  void _onItemTappedBottom(int index) {
    setState(() {
      isButtomNavPressed = true;
      controller.changeTabIndex(
          index); // This will update both the bottom nav and the drawer
    });
  }

  int _selectedIndex = 0;

  final Color _selectedColor = ThemesStyles.primary;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final List<Widget> _pages = [
    const HomePage(),
    //Profile
    const ProfilePage(),
    //Budget
    const HomePage(),
    //History
    const SearchPage(),
    //Settings
    SettingsPage(),
    //about us
    const SearchPage(),
    //const ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Themes.background,
      key: scaffoldKey,
      drawer: Obx(() {
        return DrawerWidget(
          selectedIndex: controller.currentIndexDrawer.value,
          onItemTapped: _onItemTapped,
          selectedColor: _selectedColor,
        );
      }),
      appBar: appBarBuilding(context, scaffoldKey),
      body: Obx(() {
        return isButtomNavPressed
            ? Center(
                child: _widgetOptions[controller.currentIndexBottom.value],
              )
            : Row(
                children: [
                  // Page Content
                  Expanded(
                    child: _pages[controller.currentIndexDrawer.value],
                  ),
                ],
              );
      }),

      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.currentIndexBottom
              .value, // This ensures the circle updates correctly
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? ThemesStyles.backgroundDark
              : Colors.white,
          color: ThemesStyles.primary,
          animationDuration: const Duration(milliseconds: 300),
          onTap: _onItemTappedBottom,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.receipt_long_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Icon(
              Icons.event,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
          ],
        );
      }),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      isButtomNavPressed = false;
      controller.changeDrawerTabIndex(index);
      _selectedIndex = index;
    });
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Second Page");
  }
}
