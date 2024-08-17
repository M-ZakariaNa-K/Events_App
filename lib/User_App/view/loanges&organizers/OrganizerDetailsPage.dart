import 'package:carousel_slider/carousel_slider.dart';
import 'package:events_app/Investor_App/controllers/lounges/editLoungesController.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/User_App/view/booking/book_now_page.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizerDetailsPage extends StatelessWidget {
  const OrganizerDetailsPage({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    final servicesDetailsController = Get.put(ServicesUserController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            servicesDetailsController.servicesDetailsItems.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Back'),
      ),
      body: servicesDetailsController.servicesDetailsItems.isEmpty
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
                  items: servicesDetailsController
                      .servicesDetailsItems[0].photos
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
                          "Organizer Name",
                          style: TextStyle(
                            color: ThemesStyles.primary,
                            fontSize: ThemesStyles.mainFontSize + 5,
                            fontWeight: ThemesStyles.fontWeightBold,
                          ),
                        ),
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
                                "${servicesDetailsController.servicesDetailsItems[0].id}",
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )).marginSymmetric(horizontal: width * 0.03),
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
                                      color: servicesDetailsController
                                                  .servicesDetailsItems[0]
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: width / 2.3,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 237, 240),
                              border: Border.all(
                                  color: ThemesStyles.primary, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Column(children: [
                              Text(
                                  "${servicesDetailsController.servicesDetailsItems[0].startTime}"),
                              Text(
                                  "${servicesDetailsController.servicesDetailsItems[0].endTime}"),
                            ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                      itemCount: servicesDetailsController
                          .servicesDetailsItems[0]
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
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                      "${servicesDetailsController.servicesDetailsItems[0].services[index].name}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.littelFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
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
                                    "${servicesDetailsController.servicesDetailsItems[0].services[index].discountedPrice ?? 0}",
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
                                    "${servicesDetailsController.servicesDetailsItems[0].services[index].price}",
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

                    //here the contoller come from reservation controller
                    GetBuilder<EditLoungesController>(
                        init: EditLoungesController(),
                        builder: (controller) {
                          return DefultButton(
                            buttonColor: ThemesStyles.secondary,
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                            title: "BOOK NOW",
                            onPressed: () async {
                              Get.to(() => const BookNowPage(
                                    isOrganizer: true,
                                  ));
                            },
                          );
                        })
                  ],
                )
                    .marginSymmetric(
                        horizontal: width * 0.03, vertical: height * 0.02)
                    .marginOnly(top: height * 0.02),
              ],
            ),
    );
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
