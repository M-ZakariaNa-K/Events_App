// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/User_App/controllers/publicEvent/public_eevent_controller.dart';
import 'package:events_app/User_App/view/booking/book_now_public_events.dart';
import 'package:events_app/User_App/view/booking/main_booking_page.dart';
import 'package:events_app/common/components/general/main_loading_widget.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:events_app/User_App/view/p-event/p_event_details.dart';
import 'package:events_app/User_App/view/p-event/puplic_card.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:intl/intl.dart';

class PublicEventPage extends StatelessWidget {
  const PublicEventPage({
    Key? key,
    required this.isUserLoggedIn,
  }) : super(key: key);
  final bool isUserLoggedIn;

  @override
  Widget build(BuildContext context) {
    final publicEventsController = Get.put(PublicEventController());
    return Scaffold(
      appBar: token != ""
          ? null
          : AppBar(
              title: const Text("Public Events"),
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
                  publicEventsController.existedCategoriesList.clear();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ThemesStyles.paddingprimary,
            vertical: ThemesStyles.paddingprimary),
        child: Obx(() {
          if (publicEventsController.publicEventsLoading.value) {
            return const Center(
              child: MainLoadingWidget(),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //فعاليات عامة
              const PuplicEventCard(
                isNewOnApp: false,
                image: 'assets/images/person.png',
                width: 200,
              ),
              //=====================================3=======================================
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 30,
                  child: Obx(() {
                    return publicEventsController
                            .existedCategoriesList.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: publicEventsController
                                .existedCategoriesList.length,
                            itemBuilder: (context, index) {
                              final isAll = index == 0;
                              return GestureDetector(
                                onTap: () async {
                                  publicEventsController.isAllSelected.value =
                                      isAll;

                                  await publicEventsController
                                      .getPublicEventsItems(
                                          category_id: publicEventsController
                                              .existedCategoriesList[index].id);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: isAll
                                          ? ThemesStyles.primary
                                          : Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: isAll
                                          ? null
                                          : Border.all(
                                              color: ThemesStyles.primary,
                                              width: 1)),
                                  child: Center(
                                      child: Text(
                                    publicEventsController
                                        .existedCategoriesList[index].name,
                                    style: TextStyle(
                                      color: isAll
                                          ? ThemesStyles.seconndTextColor
                                          : ThemesStyles.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ),
                              );
                            })
                        : const SizedBox();
                  }),
                ),
              ),
              //=====================================4======================================
              Expanded(
                child: Obx(() {
                  if (publicEventsController.publicEventsItems.isEmpty) {
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Text(
                                'There are no public events to show',
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
                  } else {
                    return ListView.builder(
                      itemCount:
                          publicEventsController.publicEventsItems.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () async {
                            publicEventsController.publicEventId.value =
                                publicEventsController.publicEventsItems[i].id;
                            publicEventsController.publicEventsDetilaItems
                                .clear();
                            await publicEventsController
                                .getPublicEventsDetailsItems();
                            publicEventsController.ticketPrice = double.parse(
                                publicEventsController
                                    .publicEventsDetilaItems[0].ticketPrice);
                            Get.to(P_Event_Details());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xff2B2B2B)
                                  : const Color.fromARGB(255, 243, 243, 243),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: publicEventsController
                                                      .publicEventsItems[i]
                                                      .photo !=
                                                  null ||
                                              publicEventsController
                                                      .publicEventsItems[i]
                                                      .photo !=
                                                  ""
                                          ? NetworkImage(
                                              "$photoBaseUrl${publicEventsController.publicEventsItems[i].photo}")
                                          : AssetImage("assets/images/Logo.png")
                                              as ImageProvider,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          publicEventsController
                                              .publicEventsItems[i].eventName,
                                          style: TextStyle(
                                            fontSize: ThemesStyles.mainFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: 200,
                                          child: Text(
                                            "${DateFormat('dd/MM/yyyy').format(publicEventsController.publicEventsItems[i].startDate)}, ${publicEventsController.publicEventsItems[i].startTime} - ${publicEventsController.publicEventsItems[i].endTime}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: ThemesStyles.primary),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            size: 18,
                                            color: ThemesStyles.primary,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: SizedBox(
                                              width: 140,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                publicEventsController
                                                    .publicEventsItems[i]
                                                    .ticketPrice,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 170, 170, 170),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          SizedBox(
                                            width: 60,
                                            child: Text(
                                              publicEventsController
                                                  .publicEventsItems[i]
                                                  .confirmedGuestId,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: ThemesStyles.primary,
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
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
                    );
                  }
                }),
              )
            ],
          );
        }),
      ),
    );
  }
}
