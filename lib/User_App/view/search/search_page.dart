import 'package:events_app/User_App/components/search/search_bar_widget.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  // List<String>.generate(3, (index) => '2:00 - ${index + 1}:00');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemesStyles.paddingprimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //=================Search Bar================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_back_ios_new_rounded),
              SearchBarWidget(),
            ],
          ),
          //=================Taps================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SearchTapsWidget(),
          ),
          //=================Number of found================
          //sEARCH result
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "0 found",
              style: TextStyle(
                fontSize: ThemesStyles.mainFontSize,
              ),
            ),
          ),
          //=================Body================
          Container(
            child: Image.asset(
              "assets/images/searchNotFoundImage.png",
              color: ThemesStyles.primary,
            ),
          ),
        ],
      ),
    );
  }
}
