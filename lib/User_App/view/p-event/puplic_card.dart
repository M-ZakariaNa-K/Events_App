import 'package:events_app/User_App/controllers/publicEvent/public_eevent_controller.dart';
import 'package:events_app/User_App/view/p-event/p_event_details.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PuplicEventCard extends StatelessWidget {
  const PuplicEventCard({
    Key? key,
    required this.image,
    required this.width,
    required this.isNewOnApp,
  }) : super(key: key);

  final String image;
  final double width;
  final bool isNewOnApp;

  @override
  Widget build(BuildContext context) {
    final publicEventsController = Get.put(PublicEventController());
    return SizedBox(
      height: 180,
      child: Obx(() {
        if (publicEventsController.publicEventsItemsDependOnDate.isEmpty) {
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
                      'No recent public events found',
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
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:
                publicEventsController.publicEventsItemsDependOnDate.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  publicEventsController.publicEventId.value =
                      publicEventsController.publicEventsItems[index].id;
                  publicEventsController.publicEventsDetilaItems.clear();
                  await publicEventsController.getPublicEventsDetailsItems();
                  Get.to(P_Event_Details());
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 200,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: isNewOnApp
                          ? BorderRadius.only(
                              topLeft: Radius.circular(
                                ThemesStyles.borderradiusprimary,
                              ),
                              topRight: Radius.circular(
                                ThemesStyles.borderradiusprimary,
                              ),
                            )
                          : BorderRadius.all(
                              Radius.circular(
                                ThemesStyles.borderradiusprimary,
                              ),
                            ),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            publicEventsController
                                .publicEventsItemsDependOnDate[index].eventName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${DateFormat('dd/MM/yyyy').format(publicEventsController.publicEventsItemsDependOnDate[index].startDate)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
