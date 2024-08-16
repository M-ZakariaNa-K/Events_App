import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/controllers/services/services_controller.dart';
import 'package:events_app/Investor_App/view/home/investor_homePage..dart';
import 'package:events_app/Investor_App/view/lounges/loanges_page_resercations.dart';
import 'package:events_app/Investor_App/view/reservations/reservations_Investor_Page.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/appbar_building.dart';
import 'package:events_app/User_App/components/Drawer&Appbar&bottomNavBar/custome_drawer.dart';
import 'package:events_app/User_App/controllers/Favorates/Favorate_controller.dart';
import 'package:events_app/User_App/controllers/home/drawer_page_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/profile/profile_controller.dart';
import 'package:events_app/User_App/controllers/publicEvent/public_eevent_controller.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/User_App/view/Favorate/favorate_page.dart';
import 'package:events_app/User_App/view/p-event/HelpCenter.dart';
import 'package:events_app/User_App/view/p-event/public-event.dart';
import 'package:events_app/User_App/view/p-event/settings_page.dart';
import 'package:events_app/User_App/view/profile/profile_page.dart';
import 'package:events_app/User_App/view/reservations/reservations_user.dart';
import 'package:events_app/User_App/view/search/search_page.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/User_App/view/booking/main_booking_page.dart';
import 'package:events_app/User_App/view/home/homePage.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
//reminder function to rating
  void showRatingReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Reminder",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Don't forget to rate the halls and organizers in outdated reservations.",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background
                    onPrimary: Colors.pinkAccent, // foreground
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Got it!',
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void initState() {
    super.initState();
    // Show the dialog when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showRatingReminderDialog(context);
    });
  }

  final DrawerPageController controller = Get.put(DrawerPageController());

  bool isButtomNavPressed = false;

  static final List<Widget> _userBottomBarOptions = <Widget>[
    const HomePage(),
    ReservationsUserPage(
      isCommingFromInvestorSide: false,
      isTheReservationDetailComeFromInvestorHalls: false,
    ),

    //here u will go to ADD page and also in the + button u gonna go to Add page
    MainBookingPage(),
    PublicEventPage(
      isUserLoggedIn: true,
    ),
    const FavoratePage(),
  ];
  static final List<Widget> _investorBottomBarOptions = <Widget>[
    InvestorHomePage(),
    LoungesReservationsInvestorPage(),
    //here u will go to ADD page and also in the + button u gonna go to Add page
    MainBookingPage(),
    PublicEventPage(
      isUserLoggedIn: true,
    ),
    const FavoratePage(),
  ];

  void _onItemTappedBottom(int index) {
    //to clear the categories list when user leave the public events page
    final publicEventsController = Get.put(PublicEventController());

    publicEventsController.existedCategoriesList.clear();
    publicEventsController.publicEventsItems.clear();
    publicEventsController.publicEventsItemsDependOnDate.clear();

    setState(() {
      if (index == 0 && !isUser! && !isHallOwner!) {
        final servicesController = Get.put(ServicesHomePageController());
        servicesController.servicesItems.clear();
        servicesController.getServicesItems();
      }
      if (index == 0 && !isUser! && isHallOwner!) {
        final loungeController = Get.put(LoungesController());
        loungeController.loungesItems.clear();
        loungeController.getloungesItems();
      }
      if (index == 1 && isUser!) {
        final reservationController = Get.put(ReservationController());
        reservationController.reservationsUserList.clear();
        reservationController.isPrivateSelected.value = true;
        reservationController.isUpcomingSelected.value = true;
        reservationController.getReservationItems(
          service_kind: "private",
          date: ">=",
          asset_id: null,
        );
      }
      if (index != 1) {
        final reservationController = Get.put(ReservationController());
        reservationController.reservationsUserList.clear();
        reservationController.reservationsInvestorList.clear();
      }
      if (index == 1 && !isUser!) {
        final loungesController = Get.put(LoungesController());
        loungesController.loungesItems.clear();
        loungesController.getloungesItems();
      }
      if (index == 3) {
        // Here u will show the public events

        publicEventsController.getCategoriesList();
        publicEventsController.getPublicEventsItems(category_id: 0);
        publicEventsController.getPublicEventsItems(category_id: 1);
      }
      if (index == 4) {
        final favoriteController = Get.put(FavorateController());
        favoriteController.favoriteItems.clear();
        favoriteController.getFavorateItems();
      }

      isButtomNavPressed = true;
      controller.changeTabIndex(
          index); // This will update both the bottom nav and the drawer
    });
  }

  int _selectedIndex = 0;

  final Color _selectedColor = ThemesStyles.primary;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final List<Widget> _userDrawerPages = [
    const HomePage(),
    //Profile
    const ProfilePage(
      isComeFromSettings: false,
    ),
    //Budget
    const HomePage(),
    //History
    const SearchPage(),
    //Settings
    SettingsPage(),
    //about us
    const HelpCenterPage(isUserCameFromDrawer: true),
    //const ReportsPage(),
  ];
  final List<Widget> _investorDrawerPages = [
    InvestorHomePage(),
    //Profile
    const ProfilePage(
      isComeFromSettings: false,
    ),
    //Budget
    InvestorHomePage(),
    //History
    const SearchPage(),
    //Settings
    SettingsPage(),
    //about us
    const HelpCenterPage(isUserCameFromDrawer: true),
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
                child: isUser!
                    ? _userBottomBarOptions[controller.currentIndexBottom.value]
                    : _investorBottomBarOptions[
                        controller.currentIndexBottom.value],
              )
            : Row(
                children: [
                  // Page Content
                  Expanded(
                    child: isUser!
                        ? _userDrawerPages[controller.currentIndexDrawer.value]
                        : _investorDrawerPages[
                            controller.currentIndexDrawer.value],
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
              Icons.favorite,
              color: Colors.white,
            ),
          ],
        );
      }),
    );
  }

  void _onItemTapped(int index) async {
    //to clear the categories list when user leave the public events page
    final publicEventsController = Get.put(PublicEventController());

    publicEventsController.existedCategoriesList.clear();
    //profile
    if (index == 1) {
      try {
        final profileController = Get.put(ProfileController());
        profileController.profileItems.clear();
        await profileController.getProfileItems();
        profileController.phoneNumberController.text =
            profileController.profileItems[0].phoneNumber;
      } catch (e) {
        Get.snackbar("Error", "Something get wrong with calling data");
      }
    }

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
