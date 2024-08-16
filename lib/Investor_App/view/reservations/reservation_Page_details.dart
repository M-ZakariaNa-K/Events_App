import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/User_App/view/reservations/coming_public_event_tickets_page.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationDetailsPage extends StatelessWidget {
  ReservationDetailsPage(
      {super.key, required this.isTheReservationDetailComeFromInvestorHalls});
  final bool isTheReservationDetailComeFromInvestorHalls;
  @override
  Widget build(BuildContext context) {
    final reservationsController = Get.put(ReservationController());
    bool isPublicEventDetails =
        reservationsController.reservationsDetalisUserList[0].category != null;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation Details"),
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
            // reservationsController.reservationsDetalisUserList.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPublicEventDetails)
                Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 68, 68, 68)
                          : const Color(0xffF5F5F5),
                    ),
                    child: Image(
                      image: NetworkImage(
                        "$photoBaseUrl${reservationsController.reservationsDetalisUserList[0].photo}",
                      ),
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/Logo.png',
                          fit: BoxFit.contain,
                        );
                      },
                    )),
              //============================================
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 68, 68, 68)
                      : const Color(0xffF5F5F5),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: ThemesStyles.mainFontSize,
                        ),
                      ),
                      Text(
                        "✅  Your reservation is successfully confirmed.",
                        style: TextStyle(
                          fontSize: ThemesStyles.littelFontSize,
                          color: const Color.fromARGB(255, 168, 168, 168),
                        ),
                      ).marginOnly(bottom: 15),
                      Text(
                        "Booking ID:    ${reservationsController.reservationsDetalisUserList[0].id}",
                        style: TextStyle(
                          fontSize: ThemesStyles.littelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Guest ID:     ${reservationsController.reservationsDetalisUserList[0].confirmedGuestId}",
                        style: TextStyle(
                          fontSize: ThemesStyles.littelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isPublicEventDetails)
                        Text(
                          "Name:     ${reservationsController.reservationsDetalisUserList[0].name}",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              //============================================
              Text(
                "Booking Details",
                style: TextStyle(
                  fontSize: ThemesStyles.littelFontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BookingDetailsListTileWidget(
                icon: Icons.book,
                title: "Event name",
                subtitle:
                    " ${reservationsController.reservationsDetalisUserList[0].eventName}",
              ),
              if (isPublicEventDetails)
                BookingDetailsListTileWidget(
                  icon: Icons.book,
                  title: "Address",
                  subtitle:
                      " ${reservationsController.reservationsDetalisUserList[0].address}",
                ),
              BookingDetailsListTileWidget(
                icon: Icons.person,
                title: "Attendees Number",
                subtitle:
                    " ${reservationsController.reservationsDetalisUserList[0].attendeesNumber}",
              ),
              if (isPublicEventDetails)
                BookingDetailsListTileWidget(
                  icon: Icons.book,
                  title: "Category",
                  subtitle:
                      " ${reservationsController.reservationsDetalisUserList[0].category}",
                ),
              BookingDetailsListTileWidget(
                icon: Icons.calendar_month_sharp,
                title: "Start in:",
                subtitle:
                    " ${reservationsController.reservationsDetalisUserList[0].startDate} •  ${reservationsController.reservationsDetalisUserList[0].startTime}",
              ),
              BookingDetailsListTileWidget(
                icon: Icons.calendar_month_sharp,
                title: "End in:",
                subtitle:
                    " ${reservationsController.reservationsDetalisUserList[0].endDate} •  ${reservationsController.reservationsDetalisUserList[0].endTime}",
              ),
              Divider(
                thickness: 6,
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 68, 68, 68)
                    : const Color(0xffF5F5F5),
              ),
              const SizedBox(
                height: 30,
              ),
              //============================================
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: ThemesStyles.littelFontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 68, 68, 68)
                          : const Color(0xffF5F5F5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //here if the notes are null
                        if (reservationsController
                                    .reservationsDetalisUserList[0].notes ==
                                null ||
                            reservationsController
                                    .reservationsDetalisUserList[0].notes ==
                                "")
                          const Icon(
                            Icons.warning_amber_rounded,
                            size: 30,
                          ).marginSymmetric(horizontal: 5),
                        Flexible(
                          child: Text(
                            //here if the notes are null
                            reservationsController
                                            .reservationsDetalisUserList[0]
                                            .notes ==
                                        null ||
                                    reservationsController
                                            .reservationsDetalisUserList[0]
                                            .notes ==
                                        ""
                                ? "There is no note added in this reservation."
                                : " ${reservationsController.reservationsDetalisUserList[0].notes}",
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (isPublicEventDetails)
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: ThemesStyles.littelFontSize + 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (isPublicEventDetails)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 68, 68, 68)
                            : const Color(0xffF5F5F5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              " ${reservationsController.reservationsDetalisUserList[0].description}",
                              style: TextStyle(
                                fontSize: ThemesStyles.littelFontSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              //============================================
              Text(
                "Payment Summary",
                style: TextStyle(
                  fontSize: ThemesStyles.littelFontSize + 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Payment status"),
                  Obx(
                    () => Text(
                      reservationsController
                                  .reservationsDetalisUserList[0].payment ==
                              0
                          ? "Unpayed"
                          : "Payed",
                      style: TextStyle(
                          color: reservationsController
                                      .reservationsDetalisUserList[0].payment ==
                                  0
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (isPublicEventDetails &&
                  !isTheReservationDetailComeFromInvestorHalls)
                Center(
                  child: SizedBox(
                    width: 300,
                    child: DefultButton(
                        buttonColor: ThemesStyles.primary,
                        borderColor: Colors.transparent,
                        textColor: ThemesStyles.seconndTextColor,
                        title: "See reserve tickets for this public event",
                        onPressed: () {
                          final publicEventTicketsController =
                              Get.put(ReservationController());
                          publicEventTicketsController
                              .commingPublicEventTicketsList
                              .clear();
                          publicEventTicketsController
                              .getCommingPublicEventTickets();
                          Get.to(() => const CommingPublicEventTicketsPage());
                        }),
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              if (isTheReservationDetailComeFromInvestorHalls &&
                  reservationsController
                          .reservationsDetalisUserList[0].payment ==
                      0)
                Center(
                  child: SizedBox(
                    width: 150,
                    child: DefultButton(
                        buttonColor: ThemesStyles.primary,
                        borderColor: Colors.transparent,
                        textColor: ThemesStyles.seconndTextColor,
                        title: "Edit payment",
                        onPressed: () {
                          final publicEventTicketsController =
                              Get.put(ReservationController());
                          _showRatingDialog(context);
                        }),
                  ),
                ),
              const Divider(
                endIndent: 10,
                indent: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal"),
                  Text(
                    " ${reservationsController.reservationsDetalisUserList[0].totalPrice} SYP",
                    style: const TextStyle(color: ThemesStyles.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //=====================================
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    final TextEditingController _ratingController = TextEditingController();
    final GlobalKey<FormState> _rateForm = GlobalKey<FormState>();
    final publicEventTicketsController = Get.put(ReservationController());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const SizedBox(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // // Make sure the baseURL is correctly set with a proper host
                  // await DioHelper.submitRating(reservationId, rating);
                  await publicEventTicketsController
                      .editPaymentStatusForCommingInvestorReservation();
                  // print("Rating submitted: $rating");
                  Get.back();
                } catch (e) {
                  // Handle exceptions appropriately
                  Get.snackbar("Error", e.toString());
                  print("Error submitting rating: $e");
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

class BookingDetailsListTileWidget extends StatelessWidget {
  const BookingDetailsListTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 168, 168, 168),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: ThemesStyles.littelFontSize,
                      color: const Color.fromARGB(255, 168, 168, 168)),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: ThemesStyles.littelFontSize + 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
