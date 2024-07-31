import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/core/constants/theme.dart';

class ReservationsPage extends StatelessWidget {
  ReservationsPage({
    super.key,
    required this.assetId,
  });
  final int assetId;
  @override
  Widget build(BuildContext context) {
    final reservationsController = Get.put(ReservationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
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
            reservationsController.reservationsInvestorList.clear();
            reservationsController.isInvestorPrivateSelected.value = true;
            reservationsController.isInvestorUpcomingSelected.value = true;
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Obx(() {
        if (reservationsController.reservationsLoading.value) {
          return const Center(child: MainLoadingWidget());
        }
        return ListView(
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        reservationsController.isInvestorPrivateSelected.value =
                            true;
                        if (reservationsController
                            .isInvestorUpcomingSelected.value) {
                          reservationsController.reservationsInvestorList
                              .clear();

                          reservationsController.getInvestorReservationItems(
                              service_kind: "private",
                              date: ">=",
                              asset_id: assetId);
                        } else {
                          reservationsController.reservationsInvestorList
                              .clear();

                          reservationsController.getInvestorReservationItems(
                              service_kind: "private",
                              date: "<",
                              asset_id: assetId);
                        }
                      },
                      child: AnimatedContainer(
                        width: reservationsController
                                .isInvestorPrivateSelected.value
                            ? 150
                            : null,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: reservationsController
                                  .isInvestorPrivateSelected.value
                              ? ThemesStyles.primary
                              : const Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Private",
                          style: TextStyle(
                            color: reservationsController
                                    .isInvestorPrivateSelected.value
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.textColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          reservationsController
                              .isInvestorPrivateSelected.value = false;
                          if (reservationsController
                              .isInvestorUpcomingSelected.value) {
                            reservationsController.reservationsInvestorList
                                .clear();

                            reservationsController.getInvestorReservationItems(
                                service_kind: "public",
                                date: ">=",
                                asset_id: assetId);
                          } else {
                            reservationsController.reservationsInvestorList
                                .clear();
                            reservationsController.getInvestorReservationItems(
                                service_kind: "public",
                                date: "<",
                                asset_id: assetId);
                          }
                        },
                        child: AnimatedContainer(
                          width: reservationsController
                                  .isInvestorPrivateSelected.value
                              ? null
                              : 150,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: reservationsController
                                      .isInvestorPrivateSelected.value
                                  ? const Color.fromARGB(255, 223, 223, 223)
                                  : ThemesStyles.primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Public",
                            style: TextStyle(
                              color: reservationsController
                                      .isInvestorPrivateSelected.value
                                  ? ThemesStyles.textColor
                                  : ThemesStyles.seconndTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            //the another tow taps
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        reservationsController
                            .isInvestorUpcomingSelected.value = true;
                        if (reservationsController
                            .isInvestorPrivateSelected.value) {
                          reservationsController.reservationsInvestorList
                              .clear();

                          reservationsController.getInvestorReservationItems(
                              service_kind: "private",
                              date: ">=",
                              asset_id: assetId);
                        } else {
                          reservationsController.reservationsInvestorList
                              .clear();

                          reservationsController.getInvestorReservationItems(
                              service_kind: "public",
                              date: ">=",
                              asset_id: assetId);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: reservationsController
                                  .isInvestorUpcomingSelected.value
                              ? ThemesStyles.primary
                              : const Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Upcooming",
                          style: TextStyle(
                            color: reservationsController
                                    .isInvestorUpcomingSelected.value
                                ? ThemesStyles.seconndTextColor
                                : ThemesStyles.textColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          reservationsController
                              .isInvestorUpcomingSelected.value = false;
                          if (reservationsController
                              .isInvestorPrivateSelected.value) {
                            reservationsController.reservationsInvestorList
                                .clear();

                            reservationsController.getInvestorReservationItems(
                                service_kind: "private",
                                date: "<",
                                asset_id: assetId);
                          } else {
                            reservationsController.reservationsInvestorList
                                .clear();

                            reservationsController.getInvestorReservationItems(
                                service_kind: "public",
                                date: "<",
                                asset_id: assetId);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: reservationsController
                                      .isInvestorUpcomingSelected.value
                                  ? const Color.fromARGB(255, 223, 223, 223)
                                  : ThemesStyles.primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Outdated",
                            style: TextStyle(
                              color: reservationsController
                                      .isInvestorUpcomingSelected.value
                                  ? ThemesStyles.textColor
                                  : ThemesStyles.seconndTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Obx(() {
              if (reservationsController.reservationsInvestorList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * .2),
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
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount:
                    reservationsController.reservationsInvestorList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Number of columns
                  crossAxisSpacing: 10, // Spacing between each column
                  mainAxisSpacing: 10, // Spacing between each row
                  childAspectRatio: 2 / 1.3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: ThemesStyles.secondary, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(5, 5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                  child: Icon(
                                Icons.receipt_long_outlined,
                                color: ThemesStyles.secondary,
                                size: 50,
                              )),
                            ),
                            Center(
                              child: Text(
                                reservationsController
                                    .reservationsInvestorList[index]
                                    .confirmedGuestId,
                                style: TextStyle(
                                  color: ThemesStyles.textColor,
                                  fontSize: ThemesStyles.mainFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ).marginSymmetric(vertical: 5),
                            const Divider(
                              endIndent: 60,
                              indent: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: ThemesStyles.primary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    reservationsController
                                        .reservationsInvestorList[index]
                                        .eventName,
                                    style: TextStyle(
                                      color: ThemesStyles.textColor,
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ).marginSymmetric(vertical: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: ThemesStyles.primary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "${reservationsController.reservationsInvestorList[index].startDate}",
                                    style: TextStyle(
                                      color: ThemesStyles.textColor,
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ).marginSymmetric(vertical: 5),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      color: ThemesStyles.primary,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        reservationsController
                                            .reservationsInvestorList[index]
                                            .startTime,
                                        style: TextStyle(
                                          color: ThemesStyles.textColor,
                                          fontSize: ThemesStyles.littelFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ).marginSymmetric(vertical: 5),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Price: ${reservationsController.reservationsInvestorList[index].totalPrice}",
                                    style: TextStyle(
                                      color: ThemesStyles.primary,
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              );
            })
          ],
        );
      }),
    );
  }
}
