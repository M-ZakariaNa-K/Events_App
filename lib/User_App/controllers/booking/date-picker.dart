// ignore_for_file: camel_case_types

import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key, required this.isStart}) : super(key: key);

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
  final bool isStart;
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 232, 232),
          borderRadius: BorderRadius.all(
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
                titleTextStyle:
                    TextStyle(color: ThemesStyles.textColor, fontSize: 16),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: ThemesStyles.textColor,
                  size: 14,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: ThemesStyles.textColor,
                  size: 14,
                ),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              //-----------end Header decoration----------------

              //-----------decoration----------------
              calendarStyle: CalendarStyle(
                // Customize the color of the calendar
                defaultTextStyle:
                    const TextStyle(color: ThemesStyles.textColor),
                selectedTextStyle:
                    const TextStyle(color: ThemesStyles.textColor),
                outsideTextStyle: const TextStyle(color: Colors.grey),
                weekendTextStyle:
                    const TextStyle(color: ThemesStyles.textColor),
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
                  color: ThemesStyles.textColor,
                  fontWeight: FontWeight.bold,
                ),
                weekendStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onDaySelected: _onDaySelected,
            ),
            //===================Two Buttons========================
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        // Handle the first button action
                        Navigator.pop(context, 'Cancel Button pressed');
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: ThemesStyles.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemesStyles.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.35, 45),
                    ),
                    onPressed: () {
                      // Handle the second button action
                      widget.isStart
                          ? showStartDateMap.addAll({
                              "date": today.toString().split(' ')[0],
                            })
                          : showEndDateMap.addAll({
                              "date": today.toString().split(' ')[0],
                            });
                      Navigator.pop(context);
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return const TimePickerDialog1();
                      //   },
                      // );
                    },
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        color: ThemesStyles.seconndTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
