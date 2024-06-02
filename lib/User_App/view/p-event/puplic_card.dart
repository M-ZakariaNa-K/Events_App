import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/User_App/components/home/person_kind_card.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuplicEventCard extends StatelessWidget {
  const PuplicEventCard({
    Key? key,
    required this.image,
    required this.width,
    required this.content,
    required this.isNewOnApp,
  }) : super(key: key);

  final String image;
  final double width;
  final String content;
  final bool isNewOnApp;

  @override
  Widget build(BuildContext context) {
    double _mediaquereWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 200,
              width: width,
              decoration: BoxDecoration(
                borderRadius: isNewOnApp
                    ? BorderRadius.only(
                        topLeft: Radius.circular(
                          ThemesStyles.borderradiusprimary,
                        ),
                        topRight: Radius.circular(
                          ThemesStyles.borderradiusprimary,
                        ),
                      )
                    : BorderRadius.all(
                        Radius.circular(
                          ThemesStyles.borderradiusprimary,
                        ),
                      ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Date",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
