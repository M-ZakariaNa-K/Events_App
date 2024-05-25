// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:events_app/common/core/constants/theme.dart';

class NewOnAppCard extends StatelessWidget {
  const NewOnAppCard({
    Key? key,
    required this.isOrganizer,
    required this.image,
  }) : super(key: key);
  final bool isOrganizer;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ThemesStyles.borderradiusprimary),
                    ),
                    color: isOrganizer
                        ? Theme.of(context).brightness == Brightness.dark
                            ? Color.fromARGB(255, 106, 155, 183)
                            : ThemesStyles.blueColor
                        : Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 78, 149, 115)
                            : ThemesStyles.greenColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    ThemesStyles.borderradiusprimary),
                              ),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            width: 80,
                            height: 80,
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //THE content
                        Text(
                          "Zakaria Al-nabuilsi",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: ThemesStyles.fontWeightBold,
                            fontSize: ThemesStyles.mainFontSize,
                          ),
                        ),
                        const SizedBox(
                          width: 180,
                          child: Text(
                            "Damascus-Mohajerenzzzzzzzzzzzzzzzzz",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -5,
                left: 5,
                child: Padding(
                  padding: EdgeInsets.all(ThemesStyles.paddingprimary),
                  child: Transform.rotate(
                    angle: -0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          100), // Half of container width/height for perfect circle
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          "assets/images/new.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
