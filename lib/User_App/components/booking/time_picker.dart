// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:events_app/common/core/constants/theme.dart';

class TimePickerWidget extends StatefulWidget {
  TimePickerWidget({
    Key? key,
    required this.isStartRange,
  }) : super(key: key);
  var hour = 0;
  var minute = 0;
  final bool isStartRange;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //=============1==============
        Stack(
          alignment: Alignment.center,
          children: [
            // Container for the background, you can replace this with your own decoration
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ThemesStyles.background.withOpacity(.4)
                    : ThemesStyles.backgroundDark.withOpacity(.1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            // NumberPicker
            NumberPicker(
              minValue: 0,
              maxValue: 12,
              value: widget.hour,
              zeroPad: true,
              infiniteLoop: true,
              itemWidth: 40,
              itemHeight: 22,
              onChanged: (value) {
                setState(() {
                  widget.isStartRange
                      ? starthourShared = value
                      : endhourShared = value;
                  widget.hour = value;
                });
              },
              textStyle: TextStyle(
                color: Colors.grey.withOpacity(.3),
                fontSize: 14,
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.transparent, // Set the color to be transparent
              ),
            ),
          ],
        ),
        //=============2==============
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            ":",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //=============3==============
        Stack(
          alignment: Alignment.center,
          children: [
            // Container for the background, you can replace this with your own decoration
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ThemesStyles.background.withOpacity(.4)
                    : ThemesStyles.backgroundDark.withOpacity(.1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            // NumberPicker
            NumberPicker(
              minValue: 0,
              maxValue: 59,
              value: widget.minute,
              zeroPad: true,
              infiniteLoop: true,
              itemWidth: 40,
              itemHeight: 22,
              onChanged: (value) {
                setState(() {
                  widget.isStartRange
                      ? startminuteShared = value
                      : endminuteShared = value;
                  widget.minute = value;
                });
              },
              textStyle: TextStyle(
                color: Colors.grey.withOpacity(.3),
                fontSize: 14,
              ),
              selectedTextStyle: const TextStyle(
                fontSize: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.transparent, // Set the color to be transparent
              ),
            ),
          ],
        ),
      ],
    );
  }
}
