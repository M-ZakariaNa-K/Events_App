import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class OrganizerReservedTimeListWidget extends StatelessWidget {
  const OrganizerReservedTimeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bookNowController = BookNowController();
    return SizedBox(
      height: bookNowController.timesReservedOrganizerList.isEmpty ? 0 : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookNowController.timesAvilableList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemesStyles.thirdColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   const  Text(
                      "Start: ",
                      style: TextStyle(
                        color: ThemesStyles.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${bookNowController.timesReservedOrganizerList[index].startTime}",
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "End: ",
                      style: TextStyle(
                        color: ThemesStyles.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${bookNowController.timesReservedOrganizerList[index].endTime}",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
