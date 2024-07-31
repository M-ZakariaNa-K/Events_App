import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ChoosenUserReservationTime extends StatelessWidget {
  ChoosenUserReservationTime({super.key});

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    final bookNowController = Get.put(BookNowController());
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: width / 2.3,
            child: TextField(
              keyboardType: TextInputType.datetime,
              controller: bookNowController.startTimeController,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                hintText: 'Start',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff979797),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0, // Adjust vertical padding
                  horizontal: 10.0, // Adjust horizontal padding
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null) {
                      bookNowController.startTimeController.text = formatTimeOfDay(pickedTime);
                    }
                  },
                ),
              ),
            )),
        Container(
            width: width / 2.3,
            child: TextField(
              keyboardType: TextInputType.datetime,
              controller: bookNowController.endTimeController,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                hintText: 'End',
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff979797),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.0, // Adjust vertical padding
                  horizontal: 10.0, // Adjust horizontal padding
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                    if (pickedTime != null) {
                      bookNowController.endTimeController.text = formatTimeOfDay(pickedTime);
                    }
                  },
                ),
              ),
            )),
      ],
    );
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime =
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
    return formattedTime;
  }
}
