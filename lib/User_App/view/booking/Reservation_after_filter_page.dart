import 'package:events_app/Investor_App/controllers/lounges/lounges_controller.dart';
import 'package:events_app/Investor_App/view/lounges/LoungesDetailsPage.dart';
import 'package:events_app/User_App/controllers/booking/reservation_filter_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/User_App/view/loanges&organizers/OrganizerDetailsPage.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationAfterFilterPage extends GetView<ReservationFilterController> {
  const ReservationAfterFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loungeController = Get.put(LoungesUserController());
    final reservationFilterController = Get.put(ReservationFilterController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            reservationFilterController.listReservationFilterItems.clear();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Back'),
      ),
      body: Obx(() {
        if (reservationFilterController.listReservationFilterLoading.value) {
          return const MainLoadingWidget();
        }

        if (reservationFilterController.listReservationFilterItems.isEmpty) {
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
                      'There are no Items match your requirements',
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
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            itemCount:
                reservationFilterController.listReservationFilterItems.length,
            itemBuilder: (context, i) {
              var item =
                  reservationFilterController.listReservationFilterItems[i];

              return GestureDetector(
                onTap: () async {
                  //if result is hall

                  if (reservationFilterController
                          .listReservationFilterItems[i].name !=
                      null) {
                    final loungeController = Get.put(LoungesUserController());

                    await loungeController.getloungeDetailsItems(
                      id: reservationFilterController
                          .listReservationFilterItems[i].id,
                    );
                    Get.to(() => LoungesDetailsPage(
                        id: reservationFilterController
                            .listReservationFilterItems[i].id,
                        isCommingAsUser: true));
                  } else {
                    final organizerController =
                        Get.put(ServicesUserController());
                    await organizerController.getOrganizersDetailsItems(
                      id: reservationFilterController
                          .listReservationFilterItems[i].id,
                    );
                    Get.to(() => OrganizerDetailsPage(
                          id: reservationFilterController
                              .listReservationFilterItems[i].id,
                        ));
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
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
                          image: const DecorationImage(
                            image: AssetImage("assets/images/ballons.jpeg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ThemesStyles.primary,
                            width: 1,
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
                                item.name ?? "zzz",
                                style: TextStyle(
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      color: item.rate > index
                                          ? Colors.amber[300]
                                          : const Color.fromARGB(
                                              255, 220, 220, 220),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: ThemesStyles.primary,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: SizedBox(
                                    width: 140,
                                    child: Text(
                                      item.address ?? "zzz",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 170, 170, 170),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
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
        );
      }),
    );
  }
}
