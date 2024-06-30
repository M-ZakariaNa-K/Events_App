import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/Investor_App/view/lounges/addLoungesPage..dart';
import 'package:events_app/Investor_App/view/organizer/addServicesPage.dart';
import 'package:events_app/Investor_App/view/organizer/serviceDetailsPage.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class InvestorHomePage extends StatelessWidget {
  InvestorHomePage({super.key});
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    // List<String> halls = ['1', "2"];
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemesStyles.paddingprimary),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isHallOwner
                ? Get.to(() => AddLoungesPage())
                : Get.to(
                    () => AddServicesPage(),
                  );
          },
          child: const Icon(
            Icons.add,
            size: 25,
            color: ThemesStyles.primary,
          ),
        ).marginOnly(bottom: height * 0.02),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: isHallOwner
            ?
            //Here show the widget when data is EMPTY
            //  Center(
            //                 child: Opacity(
            //                   opacity: 0.4,
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Image(
            //                         image: const AssetImage(
            //                             'assets/images/logo2_400x400-removebg-preview.png'),
            //                         width: width * 0.5,
            //                         height: height * 0.4,
            //                       ),
            //                       Text(
            //                         'Theres no lounges to show',
            //                         style: TextStyle(
            //                             fontSize: ThemesStyles.mainFontSize,
            //                             fontWeight: FontWeight.bold),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               )
            HallCards(width: width, height: height)
            : const ServiceCard(events: ['s', 's']).marginSymmetric(
                vertical: height * 0.01, horizontal: width * 0.03),
      ),
    );
  }
}

List<Map<String, dynamic>> lounges = [
  {
    "name": "Albahia - البهية",
    "days": "Sun -> Monday",
    "time": "8:00 AM -> 1:00 PM",
    "location": "Al MAZA - Damascus",
    "image": "assets/images/second_boanding.png"
  },
  {
    "name": "Albahia - البهية",
    "days": "Sun -> Monday",
    "time": "8:00 AM -> 1:00 PM",
    "location": "Al MAZA - Damascus",
    "image": "assets/images/second_boanding.png"
  },
  {
    "name": "Albahia - البهية",
    "days": "Sun -> Monday",
    "time": "8:00 AM -> 1:00 PM",
    "location": "Al MAZA - Damascus",
    "image": "assets/images/second_boanding.png"
  },
  // Add more lounges here
];

class HallCards extends StatelessWidget {
  HallCards({
    super.key,
    required this.width,
    required this.height,
  });

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lounges.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> lounge = lounges[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => LoungesDetailsPage());
          },
          child: Container(
            width: width,
            height: height / 6,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ThemesStyles.secondary, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: width / 5,
                  child: Image.asset(lounge['image']),
                ).marginSymmetric(horizontal: width * 0.03),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lounge['name'],
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ).marginOnly(bottom: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: ThemesStyles.primary,
                        ).paddingOnly(right: 5),
                        Text(
                          lounge['days'],
                          style: TextStyle(
                            color: ThemesStyles.textColor,
                            fontSize: ThemesStyles.littelFontSize - 2,
                            fontWeight: FontWeight.normal,
                          ),
                        ).marginOnly(right: 10),
                        const Icon(
                          Icons.schedule,
                          color: ThemesStyles.primary,
                        ).paddingOnly(right: 5),
                        Text(
                          lounge['time'],
                          style: TextStyle(
                            color: ThemesStyles.textColor,
                            fontSize: ThemesStyles.littelFontSize - 2,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ).marginOnly(bottom: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: ThemesStyles.primary,
                        ),
                        Text(
                          lounge['location'],
                          style: TextStyle(
                            color: ThemesStyles.textColor,
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ).marginOnly(top: height * 0.02),
              ],
            ),
          ),
        ).marginOnly(top: 10);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final List<String> events;

  const ServiceCard({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: events.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10, // Spacing between each column
        mainAxisSpacing: 10, // Spacing between each row
        childAspectRatio: 2 / 2.1, // Aspect ratio of each card
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => ServiceDetailsPage());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ThemesStyles.secondary, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(image: AssetImage('assets/images/person.png')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.room_service_outlined,
                      color: ThemesStyles.primary,
                    ),
                    Text(
                      'BirthDay',
                      style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontSize: ThemesStyles.littelFontSize,
                        fontWeight: FontWeight.normal,
                      ),
                    ).marginSymmetric(horizontal: 5)
                  ],
                ).marginSymmetric(vertical: 5, horizontal: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.price_check_outlined,
                          color: ThemesStyles.primary,
                        ),
                        Text(
                          "200\$",
                          style: TextStyle(
                            color: ThemesStyles.textColor,
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ).marginSymmetric(horizontal: 5),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.discount,
                          color: ThemesStyles.primary,
                        ),
                        Text(
                          "20\$",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: ThemesStyles.textColor,
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ).marginSymmetric(horizontal: 5)
                      ],
                    )
                  ],
                ).marginSymmetric(vertical: 5, horizontal: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
