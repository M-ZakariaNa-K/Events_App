import 'package:events_app/Investor_App/components/lounges/reservationsAsUserWidget.dart';
import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/Investor_App/view/reservations/reservations_Investor_Page.dart';
import 'package:events_app/User_App/components/home/book_now_card.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/User_App/view/reservations/reservations_user.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoungesReservationsInvestorPage extends StatelessWidget {
  const LoungesReservationsInvestorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loungesController = Get.put(LoungesController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (loungesController.loangesLoading.value) {
                return Container(
                    height: MediaQuery.sizeOf(context).height * .85,
                    alignment: Alignment.center,
                    child: const Center(child: MainLoadingWidget()));
              }
              if (loungesController.loungesItems.isEmpty) {
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
                        "Select Your Hall To See It's Reservations",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 203, 203, 203),
                          fontSize: ThemesStyles.mainFontSize,
                        ),
                      ),
                    ).marginOnly(top: 20),
                    HallUserCards(
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

class HallUserCards extends GetView<LoungesUserController> {
  HallUserCards({
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
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: loungeController.loungesItems.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () async {
                final reservationController = Get.put(ReservationController());
                reservationController.reservationsInvestorList.clear();
                await reservationController.getInvestorReservationItems(
                  asset_id: loungeController.loungesItems[i].id,
                  service_kind: "private",
                  date: ">=",
                );

                Get.to(() => ReservationsPage(
                      assetId: loungeController.loungesItems[i].id,
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
                        child: Image.network(
                          "$photoBaseUrl${loungeController.loungesItems[i].photos[0]}",
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset("assets/images/hall.png");
                          },
                        ),
                      ),
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
                              "${loungeController.loungesItems[i].name} lounge",
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
                              child: loungeController
                                      .loungesItems[i].activeTimes.isNotEmpty
                                  ? Text(
                                      'Capacity: ${loungeController.loungesItems[i].capacity}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: ThemesStyles.primary),
                                    )
                                  : Text(
                                      'Capicity:${loungeController.loungesItems[i].capacity}',
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
                                Icons.location_on,
                                size: 18,
                                color: ThemesStyles.primary,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: 140,
                                  child: Text(
                                    loungeController.loungesItems[i].address,
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
