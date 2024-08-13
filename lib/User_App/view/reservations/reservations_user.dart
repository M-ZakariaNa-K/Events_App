import 'package:events_app/Investor_App/components/lounges/reservationsAsUserWidget.dart';
import 'package:events_app/Investor_App/view/reservations/reservation_Page_details.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            // Tabs for selecting Private/Public
            _buildServiceKindTabs(reservationsController),

            // Tabs for selecting Upcoming/Outdated
            _buildTimeFrameTabs(reservationsController),

            // Investor-specific widget
            const Padding(
              padding:  EdgeInsets.only(top: 20),
              child:  InvestorReservationsAsUserWidget(
                isTicketsCard: true,
              ),
            ),

            // Reservations list
            Obx(() {
              if (reservationsController.reservationsUserList.isEmpty) {
                return Center(
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
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 1.6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final reservation =
                        reservationsController.reservationsUserList[index];
                    return GestureDetector(
                      onTap: () async {
                        reservationsController.reservationsDetalisUserList
                            .clear();
                        await reservationsController.getReservationDeatilsItems(
                          id: reservation.id,
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
                          color: Theme.of(context).brightness == Brightness.dark
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
                                reservation.confirmedGuestId,
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
                                    reservation.eventName,
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
                                    "${reservation.startDate}",
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
                                        reservation.startTime,
                                        style: TextStyle(
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
                                    "Price: ${reservation.totalPrice}",
                                    style: TextStyle(
                                      color: ThemesStyles.primary,
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (!reservationsController
                                .isUpcomingSelected.value)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Convert reservation.id to a string
                                      _showRatingDialog(
                                          context, reservation.id.toString());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemesStyles.secondary,
                                    ),
                                    child: const Text("Rate"),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
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

  Widget _buildServiceKindTabs(ReservationController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              controller.isPrivateSelected.value = true;
              if (controller.isUpcomingSelected.value) {
                controller.reservationsUserList.clear();
                controller.getReservationItems(
                    service_kind: "private", date: ">=", asset_id: null);
              } else {
                controller.reservationsUserList.clear();
                controller.getReservationItems(
                    service_kind: "private", date: "<", asset_id: null);
              }
            },
            child: AnimatedContainer(
              width: controller.isPrivateSelected.value ? 150 : null,
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: controller.isPrivateSelected.value
                    ? ThemesStyles.primary
                    : const Color.fromARGB(255, 223, 223, 223),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Private",
                style: TextStyle(
                  color: controller.isPrivateSelected.value
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
                controller.isPrivateSelected.value = false;
                if (controller.isUpcomingSelected.value) {
                  controller.reservationsUserList.clear();
                  controller.getReservationItems(
                      service_kind: "public", date: ">=", asset_id: null);
                } else {
                  controller.reservationsUserList.clear();
                  controller.getReservationItems(
                      service_kind: "public", date: "<", asset_id: null);
                }
              },
              child: AnimatedContainer(
                width: controller.isPrivateSelected.value ? null : 150,
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: controller.isPrivateSelected.value
                        ? const Color.fromARGB(255, 223, 223, 223)
                        : ThemesStyles.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Public",
                  style: TextStyle(
                    color: controller.isPrivateSelected.value
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
  }

  Widget _buildTimeFrameTabs(ReservationController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              controller.isUpcomingSelected.value = true;
              if (controller.isPrivateSelected.value) {
                controller.reservationsUserList.clear();
                controller.getReservationItems(
                    service_kind: "private", date: ">=", asset_id: null);
              } else {
                controller.reservationsUserList.clear();
                controller.getReservationItems(
                    service_kind: "public", date: ">=", asset_id: null);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: controller.isUpcomingSelected.value
                    ? ThemesStyles.primary
                    : const Color.fromARGB(255, 223, 223, 223),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Upcoming",
                style: TextStyle(
                  color: controller.isUpcomingSelected.value
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
                controller.isUpcomingSelected.value = false;
                if (controller.isPrivateSelected.value) {
                  controller.reservationsUserList.clear();
                  controller.getReservationItems(
                      service_kind: "private", date: "<", asset_id: null);
                } else {
                  controller.reservationsUserList.clear();
                  controller.getReservationItems(
                      service_kind: "public", date: "<", asset_id: null);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: controller.isUpcomingSelected.value
                        ? const Color.fromARGB(255, 223, 223, 223)
                        : ThemesStyles.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Outdated",
                  style: TextStyle(
                    color: controller.isUpcomingSelected.value
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
    );
  }

  void _showRatingDialog(BuildContext context, String reservationId) {
    final TextEditingController _ratingController = TextEditingController();
    final GlobalKey<FormState> _rateForm = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rate Reservation"),
          content: Form(
            key: _rateForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Please rate this reservation:"),
                TextFormField(
                  controller: _ratingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter rating (1-5)",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else {
                      final rating = int.tryParse(value);
                      if (rating == null || rating < 1 || rating > 5) {
                        return "Please enter a valid rating (1-5)";
                      }
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (_rateForm.currentState!.validate()) {
                  final rating = _ratingController.text;

                  try {
                    // Make sure the baseURL is correctly set with a proper host
                    await DioHelper.submitRating(reservationId, rating);

                    print("Rating submitted: $rating");
                    Get.back();
                  } catch (e) {
                    // Handle exceptions appropriately
                    print("Error submitting rating: $e");
                  }
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
