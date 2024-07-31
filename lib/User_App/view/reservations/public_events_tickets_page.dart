import 'package:events_app/User_App/components/search/search_bar_widget.dart';
import 'package:events_app/User_App/components/search/search_taps_widget.dart';
import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicEventTicketsPage extends StatelessWidget {
  const PublicEventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final publicEventTicketsController = Get.put(ReservationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Teckits"),
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
            publicEventTicketsController.publicEventTicketsList.clear();
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

    return ListView.builder(
      itemCount: publicEventTicketsController.publicEventTicketsList.length,
      itemBuilder: (context, i) {
        if (publicEventTicketsController.reservationsLoading.value) {
          return const MainLoadingWidget();
        }
        if (publicEventTicketsController.publicEventTicketsList.value.isEmpty) {
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
        }
        return Container(
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
                      width: MediaQuery.sizeOf(context).width * .5 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                border: Border.all(
                                  width: 2,
                                  color: ThemesStyles.primary,
                                )),
                            child: Text(
                              publicEventTicketsController
                                  .publicEventTicketsList[i].ticketId
                                  .toString(),
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
                            .publicEventTicketsList[i].eventName,
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
                          "${publicEventTicketsController.publicEventTicketsList[i].eventDate}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ThemesStyles.primary),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "${publicEventTicketsController.publicEventTicketsList[i].eventStartTime} -> ${publicEventTicketsController.publicEventTicketsList[i].eventEndTime}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                        ),
                      ),
                    ),
                    Text(
                        "Tickt price: ${publicEventTicketsController.publicEventTicketsList[i].ticketsPrice}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                        )),
                    Text(
                        "Tickt number: ${publicEventTicketsController.publicEventTicketsList[i].ticketsNumber}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                        )),
                    Text(
                        "payment: ${publicEventTicketsController.publicEventTicketsList[i].payment == 0 ? "Unpayed" : "Payed"}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
