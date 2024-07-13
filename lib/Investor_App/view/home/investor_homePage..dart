import 'package:events_app/Investor_App/controllers/lounges/lounge_details_controller.dart';
import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/controllers/services/services_controller.dart';
import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/Investor_App/view/lounges/addLoungesPage..dart';
import 'package:events_app/Investor_App/view/organizer/addServicesPage.dart';
import 'package:events_app/Investor_App/view/organizer/serviceDetailsPage.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 65, 65, 65)
              : ThemesStyles.thirdColor,
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
        body: Obx(() {
          final loungesController = Get.put(LoungesController());
          if (isHallOwner) {
            if (loungesController.loangesLoading.value) {
              return const Center(child: MainLoadingWidget());
            }
            if (loungesController.loungesItems.isEmpty) {
              return Center(
                child: Opacity(
                  opacity: 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image:
                            AssetImage('assets/images/searchNotFoundImage.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Text(
                          'There are no lounges to show',
                          style: TextStyle(
                            fontSize: ThemesStyles.mainFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return HallCards(width: width, height: height);
            }
          } else {
            final servicesController = Get.put(ServicesHomePageController());
            if (servicesController.servicesLoading.value) {
              return Center(child: MainLoadingWidget());
            }
            if (servicesController.servicesItems.isEmpty) {
              return Center(
                child: Opacity(
                  opacity: 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image:
                            AssetImage('assets/images/searchNotFoundImage.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Text(
                          'There are no services to show',
                          style: TextStyle(
                            fontSize: ThemesStyles.mainFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const ServiceCard().marginSymmetric(
                  vertical: height * 0.01, horizontal: width * 0.03);
            }
          }
        }),
      ),
    );
  }
}

class HallCards extends GetView<LoungesController> {
  HallCards({
    super.key,
    required this.width,
    required this.height,
  });

  var width;
  var height;
  Future<void> _handleRefresh() async {
    return await LoungesController().getloungesItems();
  }

  @override
  Widget build(BuildContext context) {
    final loungeController = Get.put(LoungesController());
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior(),
      child: LiquidPullToRefresh(
        color: ThemesStyles.secondary,
        height: 300,
        backgroundColor: ThemesStyles.thirdColor,
        onRefresh: _handleRefresh,
        child: Obx(
          () => ListView.builder(
            itemCount: loungeController.loungesItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  print("imm iddd ${loungeController.loungesItems[index].id}");
                  await loungeController.getloungeDetailsItems(
                    id: loungeController.loungesItems[index].id,
                  );
                  Get.to(() => LoungesDetailsPage(
                        id: loungeController.loungesItems[index].id,
                      ));
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
                        child: Image.asset(
                            'assets/images/searchNotFoundImage.png'),

                        // Image.network(
                        //     "http://192.168.1.2:8000/storage/${loungeController.loungesItems[index].photos[0]}"),
                      ).marginSymmetric(horizontal: width * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                loungeController.loungesItems[index].name,
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
                                Icons.pin_drop,
                                color: ThemesStyles.primary,
                              ),
                              Text(
                                loungeController.loungesItems[index].address
                                    .toString(),
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                              .marginSymmetric(horizontal: 0)
                              .marginOnly(bottom: 0),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                color: ThemesStyles.primary,
                              ),
                              Text(
                                loungeController.loungesItems[index].capacity
                                    .toString(),
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.littelFontSize - 2,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                5,
                                (i) => Icon(
                                      Icons.star,
                                      color: loungeController
                                                  .loungesItems[index].rate >
                                              i
                                          ? Colors.amber[300]
                                          : const Color.fromARGB(
                                              255, 220, 220, 220),
                                    )),
                          ),
                        ],
                      ).marginOnly(top: height * 0.02),
                    ],
                  ),
                ),
              ).marginOnly(top: 10);
            },
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends GetView<ServicesHomePageController> {
  const ServiceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesShowController = Get.put(ServicesHomePageController());

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: servicesShowController.servicesItems.length,
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
            // Get.to(() => ServiceDetailsPage());
          },
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: ThemesStyles.secondary, width: 2),
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.shade300,
              //     offset: const Offset(5, 5),
              //     blurRadius: 10,
              //   )
              // ],
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
                      servicesShowController.servicesItems[index].name,
                      style: TextStyle(
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
                          servicesShowController.servicesItems[index].price,
                          style: TextStyle(
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
                          "${servicesShowController.servicesItems[index].discountedPrice ?? 0}",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
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
