import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoungesDetailsPage extends StatelessWidget {
  LoungesDetailsPage({super.key});
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Back'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOut,
                  height: height / 4),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: ThemesStyles.secondary, width: 2)),
                        child: const Image(
                            image: AssetImage('assets/images/person.png')));
                  },
                );
              }).toList(),
            ).marginOnly(top: height * 0.01),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Hall Name",
                      style: TextStyle(
                        color: ThemesStyles.primary,
                        fontSize: ThemesStyles.mainFontSize + 5,
                        fontWeight: ThemesStyles.fontWeightBold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: width / 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 237, 240),
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Albahia",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )),
                        Container(
                            width: width / 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 237, 240),
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "البهية",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )).marginSymmetric(horizontal: width * 0.03)
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rate",
                      style: TextStyle(
                        color: ThemesStyles.primary,
                        fontSize: ThemesStyles.mainFontSize + 5,
                        fontWeight: ThemesStyles.fontWeightBold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Use a Row to display multiple stars
                    Container(
                      width: width / 3,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 237, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            5,
                            (index) => const Icon(Icons.star,
                                color: ThemesStyles.primary)),
                      ),
                    ),
                  ],
                ).marginOnly(top: height * 0.02),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
                        Container(
                            width: width / 2,
                            height: 30,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 237, 240),
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "1:00 PM - 10:00 AM",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Capacity",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
                        Container(
                            width: width / 3,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 237, 240),
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "350",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ))
                      ],
                    ).marginSymmetric(horizontal: width * 0.05)
                  ],
                ).marginOnly(top: height * 0.02),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 6, // Adjust this based on your actual data
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 2.0, // Space between columns
                    mainAxisSpacing: 10.0, // Space between rows
                    childAspectRatio: 3 /
                        2, // Adjust this value to change the aspect ratio of the grid items
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      width: width / 2,
                      height: height / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 237, 240),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                          )
                        ],
                        border:
                            Border.all(color: ThemesStyles.primary, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Services :",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "AnyThing",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ).marginSymmetric(horizontal: width * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Proportion : ",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "300",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Price : ",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "500",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ).marginSymmetric(horizontal: width * 0.05),
                        ],
                      ),
                    ).marginSymmetric(
                        horizontal: width * 0.02, vertical: height * 0.01);
                  },
                ).marginSymmetric(vertical: height * 0.03),
                DefultButton(
                  buttonColor: ThemesStyles.secondary,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  title: "Edit",
                  onPressed: () {},
                ),
              ],
            )
                .marginSymmetric(
                    horizontal: width * 0.03, vertical: height * 0.02)
                .marginOnly(top: height * 0.02),
          ],
        ));
  }
}
