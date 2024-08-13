import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/controllers/services/edit_services_controller.dart';
import 'package:events_app/Investor_App/controllers/services/services_controller.dart';
import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/Investor_App/view/lounges/addLoungesPage..dart';
import 'package:events_app/Investor_App/view/organizer/addServicesPage.dart';
import 'package:events_app/User_App/components/home/person_kind_card.dart';
import 'package:events_app/User_App/controllers/home/drawer_page_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/User_App/view/loanges&organizers/OrganizersPage.dart';
import 'package:events_app/User_App/view/loanges&organizers/loanges_page.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class InvestorHomePage extends StatelessWidget {
  InvestorHomePage({super.key});
  var size, height, width, _mediaquereWidth;
  Future<void> _handleRefreshOrganizer() async {
    final servicesController = Get.put(ServicesHomePageController());
    await Future.delayed(const Duration(seconds: 2));
    servicesController.servicesItems.clear();
    await servicesController.getServicesItems();
  }

  Future<void> _handleRefresh() async {
    final loungeController = Get.put(LoungesController());
    await Future.delayed(const Duration(seconds: 2));
    loungeController.loungesItems.clear();
    return await loungeController.getloungesItems();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> halls = ['1', "2"];
    final servicesController = Get.put(ServicesHomePageController());
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    _mediaquereWidth = width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemesStyles.paddingprimary),
      child: Scaffold(
        floatingActionButton:
            !(servicesController.isFirstTimeForOrganizer.value && !isHallOwner)
                ? FloatingActionButton(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 65, 65, 65)
                            : ThemesStyles.thirdColor,
                    onPressed: () {
                      isHallOwner
                          ? Get.to(() => AddLoungesPage())
                          : Get.to(
                              () => AddServicesPage(
                                  isTheFirstVisit: servicesController
                                      .isFirstTimeForOrganizer.value),
                            );
                    },
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: ThemesStyles.primary,
                    ),
                  ).marginOnly(bottom: MediaQuery.sizeOf(context).height * 0.02)
                : SizedBox.shrink(), // or return null

        //=================================================
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Obx(() {
          final loungesController = Get.put(LoungesController());
          if (isHallOwner) {
            if (loungesController.loangesLoading.value) {
              return const Center(child: MainLoadingWidget());
            }
            if (loungesController.loungesItems.isEmpty) {
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior(),
                child: LiquidPullToRefresh(
                  color: ThemesStyles.secondary,
                  height: 300,
                  backgroundColor: ThemesStyles.thirdColor,
                  onRefresh: _handleRefresh,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //===============================1 first card===============================
                            GestureDetector(
                              onTap: () async {
                                final organizerController =
                                    Get.put(ServicesUserController());
                                await organizerController.getServicesItems(
                                  role: "Organizer",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const OrganizersUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/organizer.png',
                                content: "organizers".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                            //===============================2 second card===============================
                            GestureDetector(
                              onTap: () async {
                                final loungeController =
                                    Get.put(LoungesUserController());
                                await loungeController.getloungesItems(
                                  role: "HallOwner",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const LoungesUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/hall.png',
                                content: "Lounges".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                          ],
                        ),
                        //===============================3 third card===============================
                        GestureDetector(
                          onTap: () {
                            Get.find<DrawerPageController>().changeTabIndex(3);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: PersonKindCard(
                              isNewOnApp: false,
                              image: 'assets/images/publicEvents.png',
                              content: "PublicEvents".tr,
                              width: _mediaquereWidth,
                            ),
                          ),
                        ),
                        Center(
                          child: Opacity(
                            opacity: 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage(
                                      'assets/images/searchNotFoundImage.png'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0.0),
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior(),
                child: LiquidPullToRefresh(
                  color: ThemesStyles.secondary,
                  height: 300,
                  backgroundColor: ThemesStyles.thirdColor,
                  onRefresh: _handleRefresh,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //===============================1 first card===============================
                            GestureDetector(
                              onTap: () async {
                                final organizerController =
                                    Get.put(ServicesUserController());
                                await organizerController.getServicesItems(
                                  role: "Organizer",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const OrganizersUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/organizer.png',
                                content: "organizers".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                            //===============================2 second card===============================
                            GestureDetector(
                              onTap: () async {
                                final loungeController =
                                    Get.put(LoungesUserController());
                                await loungeController.getloungesItems(
                                  role: "HallOwner",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const LoungesUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/hall.png',
                                content: "Lounges".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //===============================3 third card===============================
                      GestureDetector(
                        onTap: () {
                          Get.find<DrawerPageController>().changeTabIndex(3);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: PersonKindCard(
                            isNewOnApp: false,
                            image: 'assets/images/publicEvents.png',
                            content: "PublicEvents".tr,
                            width: _mediaquereWidth,
                          ),
                        ),
                      ),
                      HallCards(width: width, height: height),
                    ],
                  ),
                ),
              );
            }
          } else {
            final servicesController = Get.put(ServicesHomePageController());
            if (servicesController.servicesLoading.value) {
              return const Center(child: MainLoadingWidget());
            }
            if (servicesController.isFirstTimeForOrganizer.value) {
              // servicesController.isFirstTimeForOrganizer.value = true;
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior(),
                child: LiquidPullToRefresh(
                  color: ThemesStyles.secondary,
                  height: 300,
                  backgroundColor: ThemesStyles.thirdColor,
                  onRefresh: _handleRefreshOrganizer,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //===============================1 first card===============================
                            GestureDetector(
                              onTap: () async {
                                final organizerController =
                                    Get.put(ServicesUserController());
                                await organizerController.getServicesItems(
                                  role: "Organizer",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const OrganizersUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/organizer.png',
                                content: "organizers".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                            //===============================2 second card===============================
                            GestureDetector(
                              onTap: () async {
                                final loungeController =
                                    Get.put(LoungesUserController());
                                await loungeController.getloungesItems(
                                  role: "HallOwner",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const LoungesUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/hall.png',
                                content: "Lounges".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //===============================3 third card===============================
                      GestureDetector(
                        onTap: () {
                          Get.find<DrawerPageController>().changeTabIndex(3);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: PersonKindCard(
                            isNewOnApp: false,
                            image: 'assets/images/publicEvents.png',
                            content: "PublicEvents".tr,
                            width: _mediaquereWidth,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 40,
                        endIndent: 40,
                      ),
                      Center(
                        child: Opacity(
                          opacity: 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/images/searchNotFoundImage.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  'There are no services to show',
                                  style: TextStyle(
                                    fontSize: ThemesStyles.mainFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Text(
                                  'Press + to add services',
                                  style: TextStyle(
                                    fontSize: ThemesStyles.mainFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => AddServicesPage(
                                      isTheFirstVisit: servicesController
                                          .isFirstTimeForOrganizer.value,
                                    ),
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: ThemesStyles.primary,
                                      ),
                                      color: ThemesStyles.secondary,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              servicesController.isFirstTimeForOrganizer.value = false;
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior(),
                child: LiquidPullToRefresh(
                  color: ThemesStyles.secondary,
                  height: 300,
                  backgroundColor: ThemesStyles.thirdColor,
                  onRefresh: _handleRefreshOrganizer,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //===============================1 first card===============================
                            GestureDetector(
                              onTap: () async {
                                final organizerController =
                                    Get.put(ServicesUserController());
                                await organizerController.getServicesItems(
                                  role: "Organizer",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const OrganizersUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/organizer.png',
                                content: "organizers".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                            //===============================2 second card===============================
                            GestureDetector(
                              onTap: () async {
                                final loungeController =
                                    Get.put(LoungesUserController());
                                await loungeController.getloungesItems(
                                  role: "HallOwner",
                                  service_id: null,
                                  identifier: "all",
                                );
                                Get.to(() => const LoungesUserPage());
                              },
                              child: PersonKindCard(
                                isNewOnApp: false,
                                image: 'assets/images/hall.png',
                                content: "Lounges".tr,
                                width: _mediaquereWidth * 0.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //===============================3 third card===============================
                      GestureDetector(
                        onTap: () {
                          Get.find<DrawerPageController>().changeTabIndex(3);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: PersonKindCard(
                            isNewOnApp: false,
                            image: 'assets/images/publicEvents.png',
                            content: "PublicEvents".tr,
                            width: _mediaquereWidth,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 40,
                        endIndent: 40,
                      ),
                      const ServiceCard().marginSymmetric(
                          vertical: height * 0.01, horizontal: width * 0.03),
                    ],
                  ),
                ),
              );
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

  @override
  Widget build(BuildContext context) {
    final loungeController = Get.put(LoungesController());
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff2B2B2B)
                    : const Color.fromARGB(255, 243, 243, 243),
                border: Border.all(color: ThemesStyles.secondary, width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(5, 5),
                    blurRadius: .1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "$photoBaseUrl${loungeController.loungesItems[index].photos[0]}",
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset("assets/images/hall.png");
                        },
                      ),
                    ),
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
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 0).marginOnly(bottom: 0),
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
      itemCount: servicesShowController.servicesItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10, // Spacing between each column
        mainAxisSpacing: 10, // Spacing between each row
        childAspectRatio: 2 / 2.3, // Aspect ratio of each card
      ),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            GestureDetector(
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
                      ],
                    ).marginSymmetric(vertical: 5, horizontal: 10),
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
                    ).marginSymmetric(horizontal: 10),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                const Icon(
                                  Icons.error_outline,
                                  color: ThemesStyles.primary,
                                  size: 50,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Are you sure about deletation?",
                                  style: TextStyle(
                                    fontSize: ThemesStyles.mainFontSize,
                                  ),
                                ),
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
                                    ElevatedButton(
                                      onPressed: () async {
                                        DioHelper.delete(
                                            url:
                                                "$baseUrl/assets/delete-service?id=${servicesShowController.servicesItems[index].id}");
                                        servicesShowController.servicesItems
                                            .clear();
                                        servicesShowController
                                            .getServicesItems();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: IconButton(
                  onPressed: () {
                    // addLoungeController.serviceList[index]["id"];

                    TextEditingController proporationController =
                        TextEditingController();
                    TextEditingController priceController =
                        TextEditingController();

                    proporationController.text =
                        servicesShowController.servicesItems.isNotEmpty
                            ? servicesShowController
                                    .servicesItems[index].discountedPrice ??
                                ""
                            : "";
                    priceController.text =
                        servicesShowController.servicesItems.isNotEmpty
                            ? servicesShowController.servicesItems[index].price
                            : "";

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                TextField(
                                  enabled: servicesShowController
                                          .servicesItems[index].kind ==
                                      "public",
                                  controller: proporationController,
                                  decoration: InputDecoration(
                                    labelText: 'Proporation',
                                    labelStyle: const TextStyle(
                                        color: ThemesStyles.primary),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: priceController,
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                    labelStyle: const TextStyle(
                                        color: ThemesStyles.primary),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
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
                                    ElevatedButton(
                                      onPressed: () async {
                                        final editController =
                                            Get.put(EditServicesController());
                                        await editController
                                            .postEditedServiceDetailsItems(
                                                body: {
                                              "id": servicesShowController
                                                  .servicesItems[index].id
                                                  .toString(),
                                              "price": priceController.text,
                                              if (servicesShowController
                                                      .servicesItems[index]
                                                      .kind ==
                                                  "public")
                                                "discounted_price":
                                                    proporationController.text
                                            });
                                        servicesShowController.servicesItems
                                            .clear();
                                        servicesShowController
                                            .getServicesItems();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
