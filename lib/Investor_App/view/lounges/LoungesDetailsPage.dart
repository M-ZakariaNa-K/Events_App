// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_app/Investor_App/controllers/lounges/editLoungesController.dart';
import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/view/lounges/editLoungesPage.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/Investor_App/controllers/lounges/lounge_details_controller.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';

class LoungesDetailsPage extends GetView<LoungeDetailsController> {
  LoungesDetailsPage({
    required this.id,
  });
  final int id;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    final loungeDetailsController = Get.put(LoungesController());
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              loungeDetailsController.loungeDetailsItems.value = [];
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Back'),
        ),
        body: Obx(
          () => loungeDetailsController.loungeDetailsItems.isEmpty
              ? const MainLoadingWidget()
              : ListView(
                  shrinkWrap: true,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOut,
                        height: height / 4,
                        onPageChanged: (index, reason) =>
                            print('Current image index: $index'),
                      ),
                      items: [1, 2, 3, 4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ThemesStyles.secondary,
                                        width: 2)),
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/audience.png")));
                          },
                        );
                      }).toList(),
                    ).marginOnly(top: height * 0.01),
                    // CarouselSlider(
                    //   options: CarouselOptions(
                    //     autoPlay: true,
                    //     autoPlayInterval: const Duration(seconds: 3),
                    //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    //     autoPlayCurve: Curves.easeInOut,
                    //     height: MediaQuery.of(context).size.height / 4,
                    //     onPageChanged: (index, reason) =>
                    //         print('Current image index: $index'),
                    //   ),
                    //   items: loungeDetailsController.loungeDetailsItems[0].photos
                    //       .map((imageUrl) => _buildCarouselItem(imageUrl, context))
                    //       .toList(),
                    // ).marginOnly(top: MediaQuery.of(context).size.height * 0.01),
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
                                        color:
                                            Color.fromARGB(255, 255, 237, 240),
                                        border: Border.all(
                                            color: ThemesStyles.primary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "${loungeDetailsController.loungeDetailsItems[0].name}",
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
                                        color:
                                            Color.fromARGB(255, 255, 237, 240),
                                        border: Border.all(
                                            color: ThemesStyles.primary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "${loungeDetailsController.loungeDetailsItems[0].name}",
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
                                  color:
                                      const Color.fromARGB(255, 255, 237, 240),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    5,
                                    (index) => Icon(
                                          Icons.star,
                                          color: loungeDetailsController
                                                      .loungeDetailsItems[0]
                                                      .rate >
                                                  index
                                              ? Colors.amber[300]
                                              : const Color.fromARGB(
                                                  255, 220, 220, 220),
                                        )),
                              ),
                            ),
                          ],
                        ).marginOnly(top: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Work Hours",
                                  style: TextStyle(
                                    color: ThemesStyles.primary,
                                    fontSize: ThemesStyles.mainFontSize + 5,
                                    fontWeight: ThemesStyles.fontWeightBold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  width: width / 2.3,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 237, 240),
                                      border: Border.all(
                                          color: ThemesStyles.primary,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Column(
                                      children: List.generate(
                                        loungeDetailsController
                                            .loungeDetailsItems[0]
                                            .activeTimes
                                            .length,
                                        (index) => Text(
                                          "${loungeDetailsController.loungeDetailsItems[0].activeTimes[index].startTime} -${loungeDetailsController.loungeDetailsItems[0].activeTimes[index].endTime}",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
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
                                        color:
                                            Color.fromARGB(255, 255, 237, 240),
                                        border: Border.all(
                                            color: ThemesStyles.primary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "${loungeDetailsController.loungeDetailsItems[0].capacity}",
                                        style: TextStyle(
                                          color: ThemesStyles.textColor,
                                          fontSize: ThemesStyles.mainFontSize,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ))
                              ],
                            ).marginSymmetric(horizontal: width * 0.07)
                          ],
                        ).marginOnly(top: height * 0.02, bottom: 20),
                        Text(
                          "Services",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: loungeDetailsController
                              .loungeDetailsItems[0]
                              .services
                              .length, // Adjust this based on your actual data
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1.5),
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
                                        "${loungeDetailsController.loungeDetailsItems[0].services[index].name}",
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
                                        "${loungeDetailsController.loungeDetailsItems[0].services[index].discountedPrice ?? 0}",
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
                                        "${loungeDetailsController.loungeDetailsItems[0].services[index].price}",
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
                                horizontal: width * 0.02,
                                vertical: height * 0.01);
                          },
                        ).marginSymmetric(vertical: height * 0.03),
                        Text(
                          "Extra services",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ).marginOnly(bottom: 10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Dinner: ${loungeDetailsController.loungeDetailsItems[0].dinner == 1 ? "✅" : "❌"}",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "Mixed: ${loungeDetailsController.loungeDetailsItems[0].mixed == 1 ? "✅" : "❌"}",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Text(
                            "Dinner service price: ${loungeDetailsController.loungeDetailsItems[0].dinnerPrice}",
                            style: TextStyle(
                              color: ThemesStyles.textColor,
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                          child: Text(
                            "Mixed service price: ${loungeDetailsController.loungeDetailsItems[0].mixedPrice}",
                            style: TextStyle(
                              color: ThemesStyles.textColor,
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                          child: Text(
                            loungeDetailsController
                                .loungeDetailsItems[0].address,
                            style: TextStyle(
                              color: ThemesStyles.textColor,
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        GetBuilder<EditLoungesController>(
                            init: EditLoungesController(),
                            builder: (controller) {
                              return DefultButton(
                                buttonColor: ThemesStyles.secondary,
                                borderColor: Colors.transparent,
                                textColor: Colors.white,
                                title: "Edit",
                                onPressed: () async {
                                  var loungeDetailsItems = await controller
                                      .getLoungeDetailsItems(id: id);
                                  Get.to(() => EditLoungesPage(
                                        id: id,
                                        loungeDetailsItems:
                                            loungeDetailsItems[0],
                                      ));
                                },
                              );
                            }),
                      ],
                    )
                        .marginSymmetric(
                            horizontal: width * 0.03, vertical: height * 0.02)
                        .marginOnly(top: height * 0.02),
                  ],
                ),
        ));
  }

  // Widget _buildCarouselItem(String imageUrl, BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: ThemesStyles.secondary, width: 2),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: Image.network(imageUrl, fit: BoxFit.cover),
  //     ),
  //   );
  // }

  // LoungesDetailsPage copyWith({
  //   int? id,
  // }) {
  //   return LoungesDetailsPage(
  //     id: id ?? this.id,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //   };
  // }

  // factory LoungesDetailsPage.fromMap(Map<String, dynamic> map) {
  //   return LoungesDetailsPage(
  //     id: map['id'] as int,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory LoungesDetailsPage.fromJson(String source) => LoungesDetailsPage.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'LoungesDetailsPage(id: $id)';

  // @override
  // bool operator ==(covariant LoungesDetailsPage other) {
  //   if (identical(this, other)) return true;

  //   return
  //     other.id == id;
  // }

  // @override
  // int get hashCode => id.hashCode;
}
