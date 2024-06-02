import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/appbar_building.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/custome_drawer.dart';
import 'package:events_app/User_App/view/p-event/public-event.dart';
import 'package:events_app/User_App/view/p-event/settings_page.dart';
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/User_App/view/search/search_page.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/User_App/view/booking/main_booking_page.dart';
import 'package:events_app/User_App/view/home/homePage.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  //========================================
  int _currentIndexBottom = 0;
  bool isButtomNavPressed = false;
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SecondPage(),
    //here u will go to ADD page and also in the + button u gonna go to Add page
    MainBookingPage(),
    PublicEventPage(),
    const SearchPage(),
  ];

  void _onItemTappedBottom(int index) {
    setState(() {
      isButtomNavPressed = true;
      //to make the lightest page in drawer is the HOME PAGE
      _selectedIndex = 0;
      _currentIndexBottom = index;
    });
  }

  //========================================
  int _selectedIndex = 0;

  final Color _selectedColor = ThemesStyles.primary;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final List<Widget> _pages = [
    const HomePage(),
    //Profile
    ProfilePage(),
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
      drawer: DrawerWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        selectedColor: _selectedColor,
      ),
      appBar: appBarBuilding(context, scaffoldKey),
      body: isButtomNavPressed
          ? Center(child: _widgetOptions[_currentIndexBottom])
          : Row(
              children: [
                // Page Content
                Expanded(
                  child: _pages[_selectedIndex],
                ),
              ],
            ),
      // bottomNavigationBar: const BottomNavBar(),
      bottomNavigationBar:
          // // BottomNavPage(
          // //   currentIndex: _currentIndexBottom,
          // // ),
          CurvedNavigationBar(
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
      ),
     
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      isButtomNavPressed = false;
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
