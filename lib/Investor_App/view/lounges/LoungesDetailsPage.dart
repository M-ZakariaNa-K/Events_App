import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_app/Investor_App/controllers/lounges/editLoungesController.dart';
import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/view/lounges/editLoungesPage.dart';
import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/User_App/controllers/booking/date-picker.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/view/booking/book_now_page.dart';
import 'package:events_app/User_App/view/booking/book_now_public_events.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';

class LoungesDetailsPage extends StatelessWidget {
  LoungesDetailsPage({
    required this.id, required this.isCommingAsUser,
  });
  final int id;
  final bool isCommingAsUser;
  var size, height, width;
  Future<dynamic> showAddedDiscountDialog(BuildContext context) {
    final loungeDetailsController = Get.put(LoungesController());
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 227, 227, 227),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Choose service you want to add discount on:"),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: loungeDetailsController
                            .loungeDetailsItems[0].services.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              loungeDetailsController
                                      .isSelectedDiscountedService.value =
                                  !loungeDetailsController
                                      .isSelectedDiscountedService.value;

                              loungeDetailsController
                                      .selectedDiscountedServiceId.value =
                                  loungeDetailsController
                                      .loungeDetailsItems[0].services[index].id;
                            },
                            child: Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: loungeDetailsController
                                            .isSelectedDiscountedService.value
                                        ? ThemesStyles.secondary
                                        : const Color.fromARGB(
                                            255, 174, 174, 174),
                                    borderRadius: BorderRadius.circular(10),
                                    border: loungeDetailsController
                                            .isSelectedDiscountedService.value
                                        ? Border.all(
                                            width: 1,
                                            color: Colors.red,
                                          )
                                        : null),
                                child: Text(
                                  loungeDetailsController.loungeDetailsItems[0]
                                      .services[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: loungeDetailsController
                                            .isSelectedDiscountedService.value
                                        ? ThemesStyles.seconndTextColor
                                        : ThemesStyles.textColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 217, 217, 217),
                    endIndent: 60,
                    indent: 60,
                  ),
                  const SizedBox(height: 20),
                  const Text("Entere the Percentage:"),
                  CustomeTextFormField(
                    hintText: "Percentage",
                    inputType: TextInputType.number,
                    title: "",
                    controller: loungeDetailsController
                        .addedDiscountPercentageController,
                    validator: (value) {},
                    prefixIcon: null,
                  ),
                  const SizedBox(height: 20),
                  Text("Start date:"),
                  CustomeTextFormField(
                    hintText: "yyyy-mm-dd",
                    inputType: TextInputType.datetime,
                    title: "",
                    controller: loungeDetailsController
                        .addedDiscountStartDateController,
                    validator: (value) {},
                    prefixIcon: null,
                  ),
                  const SizedBox(height: 20),
                  Text("End date:"),
                  CustomeTextFormField(
                    hintText: "yyyy-mm-dd",
                    inputType: TextInputType.datetime,
                    title: "",
                    controller:
                        loungeDetailsController.addedDiscountEndDateController,
                    validator: (value) {},
                    prefixIcon: null,
                  ),
                  // CalendarDialog(isStart: true, isOrganizer: false),
                  // CalendarDialog(isStart: true, isOrganizer: false),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          try {
                            DioHelper.post(
                                url: "$baseUrl/discounts/add",
                                body: {
                                  "event_id": loungeDetailsController
                                      .selectedDiscountedServiceId.value,
                                  "percentage": loungeDetailsController
                                      .addedDiscountPercentageController.text,
                                  "start_date": loungeDetailsController
                                      .addedDiscountStartDateController.text,
                                  "end_date": loungeDetailsController
                                      .addedDiscountEndDateController.text
                                });
                          } catch (e) {
                            Get.snackbar("Error", "Somthing went wrong...");
                          }
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemesStyles.primary,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: ThemesStyles.seconndTextColor,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loungeDetailsController = Get.put(LoungesController());
    final loungeDetailsUserController = Get.put(LoungesUserController());
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (isUser!) {
                loungeDetailsUserController.loungeDetailsItems.clear();
                loungeDetailsController.loungeDetailsItems.clear();
                Get.back();
              } else {
                                loungeDetailsUserController.loungeDetailsItems.clear();

                loungeDetailsController.loungeDetailsItems.clear();
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Back'),
        ),
        body: Obx(() {
          if (!isUser! && !isCommingAsUser) {
            if (loungeDetailsController.loungeDetailsItems.isEmpty ) {
              return const MainLoadingWidget();
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInOut,
                      height: MediaQuery.of(context).size.height / 4,
                      onPageChanged: (index, reason) =>
                          print('Current image index: $index'),
                    ),
                    items: loungeDetailsController.loungeDetailsItems[0].photos
                        .map((imageUrl) => _buildCarouselItem(
                            '${photoBaseUrl}${imageUrl}', context))
                        .toList(),
                  ).marginOnly(top: MediaQuery.of(context).size.height * 0.01),
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
                                          color: ThemesStyles.primary,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "${loungeDetailsController.loungeDetailsItems[0].enName}",
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
                                          color: ThemesStyles.primary,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "${loungeDetailsController.loungeDetailsItems[0].arName}",
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
                                color: const Color.fromARGB(255, 255, 237, 240),
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
                                color: const Color.fromARGB(255, 255, 237, 240),
                                border: Border.all(
                                    color: ThemesStyles.primary, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Column(
                                children: List.generate(
                                  loungeDetailsController
                                      .loungeDetailsItems[0].activeTimes.length,
                                  (index) => Text(
                                    "${loungeDetailsController.loungeDetailsItems[0].activeTimes[index].startTime} -${loungeDetailsController.loungeDetailsItems[0].activeTimes[index].endTime}",
                                    style: TextStyle(
                                      color: ThemesStyles.textColor,
                                      fontSize: ThemesStyles.littelFontSize,
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
                                  color: Color.fromARGB(255, 255, 237, 240),
                                  border: Border.all(
                                      color: ThemesStyles.primary, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
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
                      )
                          .marginSymmetric(horizontal: width * 0.07)
                          .marginOnly(top: height * 0.02, bottom: 20),
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
                                        fontSize: ThemesStyles.littelFontSize,
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
                                        fontSize: ThemesStyles.littelFontSize,
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
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.littelFontSize,
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
                                fontSize: ThemesStyles.littelFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "Mixed: ${loungeDetailsController.loungeDetailsItems[0].mixed == 1 ? "✅" : "❌"}",
                              style: TextStyle(
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
                          loungeDetailsController.loungeDetailsItems[0].address,
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DefultButton(
                          buttonColor: ThemesStyles.secondary,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          title: "Add discount",
                          onPressed: () async {
                            showAddedDiscountDialog(context);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 20,
                              thickness: 2,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            child: Text(
                              "or edit with",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              height: 20,
                              thickness: 2,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
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
                                if (controller.loungeDetailsItems.isNotEmpty) {
                                  // controller.loungeDetailsItems.clear();
                                }
                                var loungeDetailsItems = await controller
                                    .getLoungeDetailsItems(id: id);

                                Get.to(() => EditLoungesPage(
                                      id: id,
                                      loungeDetailsItems: loungeDetailsItems[0],
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
              );
            }
          } else {
            return loungeDetailsUserController.loungeDetailsItems.isEmpty
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
                          height: MediaQuery.of(context).size.height / 4,
                          onPageChanged: (index, reason) =>
                              print('Current image index: $index'),
                        ),
                        items: loungeDetailsUserController
                            .loungeDetailsItems[0].photos
                            .map((imageUrl) => _buildCarouselItem(
                                '${photoBaseUrl}${imageUrl}', context))
                            .toList(),
                      ).marginOnly(
                          top: MediaQuery.of(context).size.height * 0.01),
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
                                          color: Color.fromARGB(
                                              255, 255, 237, 240),
                                          border: Border.all(
                                              color: ThemesStyles.primary,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "${loungeDetailsUserController.loungeDetailsItems[0].enName}",
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
                                              color: Color.fromARGB(
                                                  255, 255, 237, 240),
                                              border: Border.all(
                                                  color: ThemesStyles.primary,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "${loungeDetailsUserController.loungeDetailsItems[0].arName}",
                                              style: TextStyle(
                                                color: ThemesStyles.textColor,
                                                fontSize:
                                                    ThemesStyles.mainFontSize,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ))
                                      .marginSymmetric(horizontal: width * 0.03)
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
                                    color: const Color.fromARGB(
                                        255, 255, 237, 240),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      5,
                                      (index) => Icon(
                                            Icons.star,
                                            color: loungeDetailsUserController
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
                                        color: ThemesStyles.primary, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Column(
                                    children: List.generate(
                                      loungeDetailsUserController
                                          .loungeDetailsItems[0]
                                          .activeTimes
                                          .length,
                                      (index) => Text(
                                        "${loungeDetailsUserController.loungeDetailsItems[0].activeTimes[index].startTime} -${loungeDetailsUserController.loungeDetailsItems[0].activeTimes[index].endTime}",
                                        style: TextStyle(
                                          color: ThemesStyles.textColor,
                                          fontSize: ThemesStyles.littelFontSize,
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
                                      color: Color.fromARGB(255, 255, 237, 240),
                                      border: Border.all(
                                          color: ThemesStyles.primary,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "${loungeDetailsUserController.loungeDetailsItems[0].capacity}",
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.mainFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ))
                            ],
                          )
                              .marginSymmetric(horizontal: width * 0.07)
                              .marginOnly(top: height * 0.02, bottom: 20),
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
                            itemCount: loungeDetailsUserController
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Services :",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${loungeDetailsUserController.loungeDetailsItems[0].services[index].name}",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ).marginSymmetric(horizontal: width * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Proportion : ",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${loungeDetailsUserController.loungeDetailsItems[0].services[index].discountedPrice ?? 0}",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Price : ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${loungeDetailsUserController.loungeDetailsItems[0].services[index].price}",
                                          style: TextStyle(
                                            color: ThemesStyles.textColor,
                                            fontSize:
                                                ThemesStyles.littelFontSize,
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
                                  "Dinner: ${loungeDetailsUserController.loungeDetailsItems[0].dinner == 1 ? "✅" : "❌"}",
                                  style: TextStyle(
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "Mixed: ${loungeDetailsUserController.loungeDetailsItems[0].mixed == 1 ? "✅" : "❌"}",
                                  style: TextStyle(
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 10),
                            child: Text(
                              "Dinner service price: ${loungeDetailsUserController.loungeDetailsItems[0].dinnerPrice}",
                              style: TextStyle(
                                fontSize: ThemesStyles.littelFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 20),
                            child: Text(
                              "Mixed service price: ${loungeDetailsUserController.loungeDetailsItems[0].mixedPrice}",
                              style: TextStyle(
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
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 20),
                            child: Text(
                              loungeDetailsUserController
                                  .loungeDetailsItems[0].address,
                              style: TextStyle(
                                fontSize: ThemesStyles.littelFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          DefultButton(
                            buttonColor: ThemesStyles.secondary,
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            title: "BOOK NOW",
                            onPressed: () async {
                              Get.to(
                                () => const BookNowPage(isOrganizer: false),
                              );
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  height: 20,
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 20),
                                child: Text(
                                  "or",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  height: 20,
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefultButton(
                            buttonColor: ThemesStyles.secondary,
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            title: "Make a public event with us 😊",
                            onPressed: () async {
                              Get.to(
                                () => PublicEventsBookNowPage(),
                              );
                            },
                          )
                        ],
                      )
                          .marginSymmetric(
                              horizontal: width * 0.03, vertical: height * 0.02)
                          .marginOnly(top: height * 0.02),
                    ],
                  );
          }
        }));
  }

  Widget _buildCarouselItem(String imageUrl, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ThemesStyles.secondary, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl, fit: BoxFit.cover, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset("assets/images/hall.png");
        }),
      ),
    );
  }
}
