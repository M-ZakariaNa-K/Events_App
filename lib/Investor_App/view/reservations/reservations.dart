import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/core/constants/theme.dart';

class ReservationsPage extends StatelessWidget {
  ReservationsPage({super.key});
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width / 2.5,
                height: 50,
                decoration: BoxDecoration(
                    color: ThemesStyles.primary,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                width: width / 2.5,
                height: 50,
                decoration: BoxDecoration(
                    color: ThemesStyles.primary,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ).marginSymmetric(vertical: height * 0.03),
          GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10, // Spacing between each column
              mainAxisSpacing: 10, // Spacing between each row
              childAspectRatio: 2 / 2.6, // Aspect ratio of each card
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: ThemesStyles.secondary, width: 2),
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
                        const Image(
                            image: AssetImage('assets/images/person.png')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.person,
                              color: ThemesStyles.primary,
                            ),
                            Text(
                              'Mohamad Arnaout',
                              style: TextStyle(
                                color: ThemesStyles.textColor,
                                fontSize: ThemesStyles.littelFontSize + 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).marginSymmetric(vertical: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.home,
                              color: ThemesStyles.primary,
                            ),
                            Text(
                              "Albahia - البهية",
                              style: TextStyle(
                                color: ThemesStyles.textColor,
                                fontSize: ThemesStyles.littelFontSize + 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).marginSymmetric(vertical: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: ThemesStyles.primary,
                            ),
                            Text(
                              "12/12/2024",
                              style: TextStyle(
                                color: ThemesStyles.textColor,
                                fontSize: ThemesStyles.littelFontSize + 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).marginSymmetric(vertical: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: ThemesStyles.primary,
                            ),
                            Text(
                              "12:00 - 1:00 AM",
                              style: TextStyle(
                                color: ThemesStyles.textColor,
                                fontSize: ThemesStyles.littelFontSize + 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ).marginSymmetric(vertical: 5),
                        // Add more widgets as needed
                      ],
                    ).marginSymmetric(horizontal: width * 0.03)),
              );
            },
          )
        ],
      ),
    );
  }
}
