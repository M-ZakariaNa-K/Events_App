import 'package:events_app/User_App/components/search/search_bar_widget.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//============================================here to show the people who reserve my public event============================================
class CommingPublicEventTicketsPage extends StatelessWidget {
  const CommingPublicEventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final publicEventTicketsController = Get.put(ReservationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comming Teckits"),
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
            publicEventTicketsController.commingPublicEventTicketsList.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemesStyles.paddingprimary),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    final publicEventTicketsController = Get.put(ReservationController());

    return Obx(() {
      if (publicEventTicketsController.reservationsLoading.value) {
        return const MainLoadingWidget();
      }
      return ListView.builder(
        itemCount:
            publicEventTicketsController.commingPublicEventTicketsList.length,
        itemBuilder: (context, i) {
          if (publicEventTicketsController
              .commingPublicEventTicketsList.isEmpty) {
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .2),
              child: Center(
                child: Opacity(
                  opacity: 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image:
                            AssetImage('assets/images/searchNotFoundImage.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Text(
                          'There are no resereved tickets',
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
            return Stack(
              children: [
                Container(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width - 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        bottom: 10, top: 5),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        border: Border.all(
                                          width: 2,
                                          color: ThemesStyles.primary,
                                        )),
                                    child: Text(
                                      "${i + 1}",
                                      style: TextStyle(
                                        fontSize: ThemesStyles.mainFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                publicEventTicketsController
                                    .commingPublicEventTicketsList[i].eventName,
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
                                  "${publicEventTicketsController.commingPublicEventTicketsList[i].eventDate}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: ThemesStyles.primary),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "${publicEventTicketsController.commingPublicEventTicketsList[i].eventStartTime} -> ${publicEventTicketsController.commingPublicEventTicketsList[i].eventEndTime}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 170, 170, 170),
                                ),
                              ),
                            ),
                            Text(
                                "Tickt price: ${publicEventTicketsController.commingPublicEventTicketsList[i].ticketsPrice}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 170, 170, 170),
                                )),
                            Text(
                                "Tickt number: ${publicEventTicketsController.commingPublicEventTicketsList[i].ticketsNumber}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 170, 170, 170),
                                )),
                            Obx(
                              () => Text(
                                  "payment: ${publicEventTicketsController.commingPublicEventTicketsList[i].payment == 0 ? "Unpayed" : "Payed"}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (publicEventTicketsController
                        .commingPublicEventTicketsList[0].payment ==
                    0)
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              _showRatingDialog(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ThemesStyles.primary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Edit payment",
                                  style: TextStyle(
                                    color: ThemesStyles.seconndTextColor,
                                    fontSize: 11,
                                  ),
                                ))),
                      )),
              ],
            );
          }
        },
      );
    });
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
                      .editPaymentStatusForUserPublicEvent();
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
