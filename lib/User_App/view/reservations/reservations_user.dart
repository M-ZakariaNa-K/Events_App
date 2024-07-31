import 'package:events_app/Investor_App/components/lounges/reservationsAsUserWidget.dart';
import 'package:events_app/Investor_App/view/reservations/reservation_Page_details.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/core/constants/theme.dart';

class ReservationsUserPage extends StatelessWidget {
  ReservationsUserPage({super.key, required this.isCommingFromInvestorSide});
  final bool isCommingFromInvestorSide;
  @override
  Widget build(BuildContext context) {
    final reservationsController = Get.put(ReservationController());

    return Scaffold(
      appBar: isCommingFromInvestorSide
          ? AppBar(
              title: const Text("Back"),
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
                  reservationsController.reservationsUserList.clear();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            )
          : null,
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
                        reservationsController.isPrivateSelected.value = true;
                        if (reservationsController.isUpcomingSelected.value) {
                          reservationsController.reservationsUserList.clear();

                          reservationsController.getReservationItems(
                              service_kind: "private",
                              date: ">=",
                              asset_id: null);
                        } else {
                          reservationsController.reservationsUserList.clear();

                          reservationsController.getReservationItems(
                              service_kind: "private",
                              date: "<",
                              asset_id: null);
                        }
                      },
                      child: AnimatedContainer(
                        width: reservationsController.isPrivateSelected.value
                            ? 150
                            : null,
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: reservationsController.isPrivateSelected.value
                              ? ThemesStyles.primary
                              : const Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Private",
                          style: TextStyle(
                            color:
                                reservationsController.isPrivateSelected.value
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
                          reservationsController.isPrivateSelected.value =
                              false;
                          if (reservationsController.isUpcomingSelected.value) {
                            reservationsController.reservationsUserList.clear();

                            reservationsController.getReservationItems(
                                service_kind: "public",
                                date: ">=",
                                asset_id: null);
                          } else {
                            reservationsController.reservationsUserList.clear();
                            reservationsController.getReservationItems(
                                service_kind: "public",
                                date: "<",
                                asset_id: null);
                          }
                        },
                        child: AnimatedContainer(
                          width: reservationsController.isPrivateSelected.value
                              ? null
                              : 150,
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color:
                                  reservationsController.isPrivateSelected.value
                                      ? const Color.fromARGB(255, 223, 223, 223)
                                      : ThemesStyles.primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Public",
                            style: TextStyle(
                              color:
                                  reservationsController.isPrivateSelected.value
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
                        reservationsController.isUpcomingSelected.value = true;
                        if (reservationsController.isPrivateSelected.value) {
                          reservationsController.reservationsUserList.clear();

                          reservationsController.getReservationItems(
                              service_kind: "private",
                              date: ">=",
                              asset_id: null);
                        } else {
                          reservationsController.reservationsUserList.clear();

                          reservationsController.getReservationItems(
                              service_kind: "public",
                              date: ">=",
                              asset_id: null);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: reservationsController.isUpcomingSelected.value
                              ? ThemesStyles.primary
                              : const Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Upcooming",
                          style: TextStyle(
                            color:
                                reservationsController.isUpcomingSelected.value
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
                          reservationsController.isUpcomingSelected.value =
                              false;
                          if (reservationsController.isPrivateSelected.value) {
                            reservationsController.reservationsUserList.clear();

                            reservationsController.getReservationItems(
                                service_kind: "private",
                                date: "<",
                                asset_id: null);
                          } else {
                            reservationsController.reservationsUserList.clear();

                            reservationsController.getReservationItems(
                                service_kind: "public",
                                date: "<",
                                asset_id: null);
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
                                      .isUpcomingSelected.value
                                  ? const Color.fromARGB(255, 223, 223, 223)
                                  : ThemesStyles.primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Outdated",
                            style: TextStyle(
                              color: reservationsController
                                      .isUpcomingSelected.value
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
            //see the tickets
            InvestorReservationsAsUserWidget(),
            //see the tickets
            Obx(() {
              if (reservationsController.reservationsUserList.isEmpty) {
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
                              'There are no reservations using this filters',
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

              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: reservationsController.reservationsUserList.length,
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
                      onTap: () async {
                        reservationsController.reservationsDetalisUserList
                            .clear();
                        await reservationsController.getReservationDeatilsItems(
                          id: reservationsController
                              .reservationsUserList[index].id,
                        );
                        Get.to(
                          () => ReservationDetailsPage(),
                          transition: ThemesStyles.mainTransation,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color.fromARGB(255, 68, 68, 68)
                                    : const Color(0xffF5F5F5),
                            border: Border.all(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : ThemesStyles.secondary,
                                width: 2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Color.fromARGB(255, 0, 0, 0)
                                    : Colors.grey.shade300,
                                offset: const Offset(4, 2),
                                blurRadius: 1,
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
                                      .reservationsUserList[index]
                                      .confirmedGuestId,
                                  style: TextStyle(
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
                                          .reservationsUserList[index]
                                          .eventName,
                                      style: TextStyle(
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
                                      "${reservationsController.reservationsUserList[index].startDate}",
                                      style: TextStyle(
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
                                              .reservationsUserList[index]
                                              .startTime,
                                          style: TextStyle(
                                            fontSize:
                                                ThemesStyles.littelFontSize,
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
                                      "Price: ${reservationsController.reservationsUserList[index].totalPrice}",
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
                ),
              );
            })
          ],
        );
      }),
    );
  }
}
