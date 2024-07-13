import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
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
        titleTextStyle: const TextStyle(
          color: Color(0xff464646),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          color: ThemesStyles.textColor,
          onPressed: () {
            servicesController.servicesItems.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Obx(() {
        if (servicesController.servicesLoading.value) {
          return const Center(child: MainLoadingWidget());
        }
        if (servicesController.servicesItems.isEmpty) {
          return Center(
            child: Opacity(
              opacity: 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/searchNotFoundImage.png'),
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
          return const ServiceUserCard().marginSymmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.01,
              horizontal: MediaQuery.sizeOf(context).width * 0.03);
        }
      }),
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

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SearchTapsWidget(
            isSearch: false,
          ),
        ),
        GridView.builder(
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
                              "${servicesShowController.servicesItems[index].services[0].name}",
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
        ),
      ],
    );
  }
}
