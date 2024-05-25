import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class OnBoardingQuestionsComponent extends StatelessWidget {
  const OnBoardingQuestionsComponent({
    super.key,
    required this.image,
    required this.title,
    required this.supTitle,
  });
  final String image;
  final String title;
  final String supTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //1

        // Center(
        //   child: Text(
        //     title,
        //     textAlign: TextAlign.center,
        //     style: const TextStyle(
        //       fontSize: 34,
        //       color: ThemesStyles.textColor,
        //     ),
        //   ),
        // ),
        //2
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          width: 350,
          child: Text(
            supTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ThemesStyles.mainFontSize,
              // color: ThemesStyles.textColor.withOpacity(.8),
            ),
          ),
        ),
        //3
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          width: 300,
          height: 350,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
