import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/User_App/view/loanges&organizers/OrganizerDetailsPage.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OrganizersUserPage extends StatelessWidget {
  const OrganizersUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.put(ServicesUserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizers"),
        titleTextStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? ThemesStyles.background
              : const Color(0xff464646),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          color: Theme.of(context).brightness == Brightness.dark
              ? ThemesStyles.background
              : const Color(0xff464646),
          onPressed: () {
            servicesController.servicesItems.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SearchTapsWidget(
                isComeFromOrganizerPage: true,
                isSearch: false,
              ),
            ),
            Obx(() {
              if (servicesController.servicesLoading.value) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.32),
                  child: const Center(child: MainLoadingWidget()),
                );
              }
              if (servicesController.servicesItems.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.2),
                  child: Center(
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
                  ),
                );
              } else {
                return const ServiceUserCard().marginSymmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.01,
                    horizontal: MediaQuery.sizeOf(context).width * 0.03);
              }
            }),
          ],
        ),
      ),
    );
  }
}

class ServiceUserCard extends GetView<ServicesUserController> {
  const ServiceUserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesShowController = Get.put(ServicesUserController());

    return ListView.builder(
      itemCount: servicesShowController.servicesItems.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: GestureDetector(
            onTap: () async {
              final organizerController = Get.put(ServicesUserController());
              await organizerController.getOrganizersDetailsItems(
                id: organizerController.servicesItems[index].id,
              );

              //==================To have the id to show the list of reserved times in Organizers details-------------------
              final bookNowController = Get.put(BookNowController());
              bookNowController.enteredOrganizerId.value =
                  organizerController.servicesItems[index].id;
              //==================To have the id to show the list of reserved times in Organizers details-------------------

              Get.to(() => OrganizerDetailsPage(
                    id: organizerController.servicesItems[index].id,
                  ));
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "$photoBaseUrl${servicesShowController.servicesItems[index].photos[0]}",
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset("assets/images/organizer.png");
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.room_service_outlined,
                            color: ThemesStyles.primary,
                          ),
                          Text(
                            servicesShowController.servicesItems[index].id
                                .toString(),
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
                          Text(
                            "Work hour:",
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                            ),
                          ).marginSymmetric(horizontal: 5),
                          Text(
                            "${servicesShowController.servicesItems[index].startTime.toString()} -",
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 192, 192, 192),
                            ),
                          ).marginSymmetric(horizontal: 5),
                          Text(
                            "${servicesShowController.servicesItems[index].endTime}",
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromARGB(255, 192, 192, 192),
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
                                servicesShowController.servicesItems[index].rate
                                    .toString(),
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
                                "${servicesShowController.servicesItems[index].startTime}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: ThemesStyles.littelFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ).marginSymmetric(horizontal: 5),
                              const SizedBox(
                                width: 90,
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    servicesShowController.toggleFavorite(
                                      servicesShowController
                                          .servicesItems[index].id,
                                    );
                                  },
                                  child: Icon(
                                    servicesShowController
                                            .servicesItems[index].isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18,
                                    color: ThemesStyles.primary,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ).marginSymmetric(vertical: 5, horizontal: 10),
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
}
