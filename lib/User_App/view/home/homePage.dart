import 'package:events_app/User_App/components/home/book_now_card.dart';
import 'package:events_app/User_App/components/home/new_on_app_card.dart';
import 'package:events_app/User_App/components/home/offers_card.dart';
import 'package:events_app/User_App/components/home/person_kind_card.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    double _mediaquereWidth = MediaQuery.sizeOf(context).width;

    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior(),
      child: LiquidPullToRefresh(
        color: ThemesStyles.secondary,
        height: 300,
        backgroundColor: ThemesStyles.thirdColor,
        onRefresh: _handleRefresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //===============================1 first card===============================
                    PersonKindCard(
                      isNewOnApp: false,
                      image: 'assets/images/organizer.png',
                      content: "organizers".tr,
                      width: _mediaquereWidth * 0.45,
                    ),
                    //===============================2 second card===============================
                    PersonKindCard(
                      isNewOnApp: false,
                      image: 'assets/images/hall.png',
                      content: "Lounges".tr,
                      width: _mediaquereWidth * 0.45,
                    ),
                  ],
                ),
                //===============================3 third card===============================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: PersonKindCard(
                    isNewOnApp: false,
                    image: 'assets/images/publicEvents.png',
                    content: "PublicEvents".tr,
                    width: _mediaquereWidth,
                  ),
                ),
                //===============================3 Book Now Card===============================
                OrderNowCardWidget(),
                //===============================4 List of New Loungers and Organizers===============================
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //صالات
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ThemesStyles.paddingprimary),
                      child: Text(
                        "New to the app (Lounges):".tr,
                        style: TextStyle(
                          fontSize: ThemesStyles.mainFontSize,
                          fontWeight: ThemesStyles.fontWeightBold,
                        ),
                      ),
                    ),
                    const NewOnAppCard(
                      isOrganizer: false,
                      image: "assets/images/hall.png",
                    ),
                    //منظمين
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ThemesStyles.paddingprimary),
                      child: Text(
                        "New to the app (organizers):".tr,
                        style: TextStyle(
                          fontSize: ThemesStyles.mainFontSize,
                          fontWeight: ThemesStyles.fontWeightBold,
                        ),
                      ),
                    ),
                    const NewOnAppCard(
                      isOrganizer: true,
                      image: "assets/images/event-planner.png",
                    ),
                  ],
                ),
                //===============================5 OFFERS Card===============================
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ThemesStyles.paddingprimary * 2),
                  child: const OffersCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
