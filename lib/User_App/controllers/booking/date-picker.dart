// ignore_for_file: camel_case_types

import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog(
      {Key? key, required this.isStart, required this.isOrganizer})
      : super(key: key);

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
  final bool isStart;
  final bool isOrganizer;
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      widget.isStart
          ? showStartDateMap.addAll({
              "date": today.toString().split(' ')[0],
            })
          : showEndDateMap.addAll({
              "date": today.toString().split(' ')[0],
            });
      final bookNowController = Get.find<BookNowController>();
      if (!widget.isOrganizer) {
        bookNowController.timesAvilableList.clear();
        bookNowController.getTimesAvailbleList(
            assetId: bookNowController.enteredHallId.value,
            date: showStartDateMap["date"]);
      } else {
        bookNowController.timesReservedOrganizerList.clear();
        bookNowController.getTimesReservedOrgainzerList(
            assetId: bookNowController.enteredOrganizerId.value,
            date: showStartDateMap["date"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 55, 55, 55)
              : const Color.fromARGB(255, 232, 232, 232),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("Selected day = " + today.toString().split(' ')[0]),
            //===================Calendar========================
            TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              //-----------Header decoration----------------
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 16),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  // color: ThemesStyles.textColor,
                  size: 14,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              //-----------end Header decoration----------------

              //-----------decoration----------------
              calendarStyle: CalendarStyle(
                // Customize the color of the calendar
                // defaultTextStyle:
                //     const TextStyle(color: ThemesStyles.textColor),
                // selectedTextStyle:
                //     const TextStyle(color: ThemesStyles.textColor),
                outsideTextStyle: const TextStyle(color: Colors.grey),
                // weekendTextStyle:
                //     const TextStyle(color: ThemesStyles.textColor),
                // Customize the size of the calendar
                outsideDaysVisible: true,
                cellMargin: const EdgeInsets.all(8),
                defaultDecoration: BoxDecoration(
                  color: ThemesStyles.background.withOpacity(.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                weekendDecoration: BoxDecoration(
                  color: ThemesStyles.background.withOpacity(.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                todayDecoration: BoxDecoration(
                  color: ThemesStyles.primary.withOpacity(.3),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedDecoration: BoxDecoration(
                  color: ThemesStyles.primary,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              //-----------decoration----------------

              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  // color: ThemesStyles.textColor,
                  fontWeight: FontWeight.bold,
                ),
                weekendStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }
}
