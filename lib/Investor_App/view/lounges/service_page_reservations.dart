import 'package:events_app/Investor_App/components/lounges/reservationsAsUserWidget.dart';
import 'package:events_app/Investor_App/controllers/services/services_controller.dart';
import 'package:events_app/Investor_App/view/reservations/reservations_Investor_Page.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';

import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesReservationsInvestorPage extends StatelessWidget {
  const ServicesReservationsInvestorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.put(ServicesHomePageController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (servicesController.servicesLoading.value && !isHallOwner!) {
                return Container(
                    height: MediaQuery.sizeOf(context).height * .85,
                    alignment: Alignment.center,
                    child: const Center(child: MainLoadingWidget()));
              }

              if (servicesController.servicesItems.isEmpty) {
                return Column(
                  children: [
                    const InvestorReservationsAsUserWidget(
                      isTicketsCard: false,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InvestorReservationsAsUserWidget(
                      isTicketsCard: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 10),
                      child: Text(
                        "Select Your service To See It's Reservations",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 203, 203, 203),
                          fontSize: ThemesStyles.mainFontSize,
                        ),
                      ),
                    ).marginOnly(top: 20),
                    OrganizerUserCards(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class OrganizerUserCards extends GetView<LoungesUserController> {
  OrganizerUserCards({
    super.key,
    required this.width,
    required this.height,
  });

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(ServicesHomePageController());
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: serviceController.servicesItems.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () async {
                final reservationController = Get.put(ReservationController());
                reservationController.reservationsInvestorList.clear();
                await reservationController.getInvestorReservationItems(
                  asset_id: serviceController.servicesItems[i].id,
                  service_kind: "private",
                  date: ">=",
                );

                Get.to(() => ReservationsPage(
                      isTheReservationDetailComeFromInvestorHalls: true,
                      assetId: serviceController.servicesItems[i].id,
                    ));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xff2B2B2B)
                      : const Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ThemesStyles.primary,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset("assets/images/Logo.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "${serviceController.servicesItems[i].name} service",
                              style: TextStyle(
                                fontSize: ThemesStyles.mainFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 200,
                              child: Text(
                                'Kind:  ${serviceController.servicesItems[i].kind}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: ThemesStyles.primary),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.price_change,
                                size: 18,
                                color: ThemesStyles.primary,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: 140,
                                  child: Text(
                                    serviceController.servicesItems[i].price,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 170, 170, 170),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              // GestureDetector(
                              //   onTap: () {
                              //     // loungeController.toggleFavorite(
                              //     //   loungeController.loungesItems[i].id,
                              //     // );
                              //   },
                              //   child: Icon(
                              //     loungeController.loungesItems[i].isFavorite
                              //         ? Icons.favorite
                              //         : Icons.favorite_border,
                              //     size: 18,
                              //     color: ThemesStyles.primary,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
