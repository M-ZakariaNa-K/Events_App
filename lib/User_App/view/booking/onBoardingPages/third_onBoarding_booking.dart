// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/User_App/components/booking/time_picker.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';

class ThirdOnBoardingBooking extends StatefulWidget {
  ThirdOnBoardingBooking({
    Key? key,
    required this.onTimeSelected,
  }) : super(key: key);

  final void Function(String time) onTimeSelected;

  @override
  _ThirdOnBoardingBookingState createState() => _ThirdOnBoardingBookingState();
}

class _ThirdOnBoardingBookingState extends State<ThirdOnBoardingBooking> {
  int? selectedCardIndex;
  final List<String> items =
      List<String>.generate(6, (index) => '2:00 - ${index + 1}:00');
  final double cardHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1
          const Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: OnBoardingQuestionsComponent(
              title: "Manage your event",
              supTitle: "Choose the event time you want.",
              image: "assets/images/clock.png",
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Wrap(
          //     spacing: 8.0, // spacing between items
          //     runSpacing: 8.0, // spacing between lines
          //     children: items.map((item) {
          //       int currentIndex = items.indexOf(item);
          //       bool isSelected = selectedCardIndex == currentIndex;
          //       return SizedBox(
          //         width: 100,
          //         height: cardHeight,
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selectedCardIndex = currentIndex;
          //             });
          //             widget.onTimeSelected(item); // Notify parent widget
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Theme.of(context).brightness == Brightness.dark
          //                   ? const Color(0xff2B2B2B)
          //                   : ThemesStyles.thirdColor,
          //               borderRadius: const BorderRadius.all(
          //                 Radius.circular(5),
          //               ),
          //               border: isSelected
          //                   ? Border.all(
          //                       color: ThemesStyles.secondary, width: 1)
          //                   : null,
          //             ),
          //             child: Center(
          //                 child: Text(
          //               item,
          //               style: const TextStyle(),
          //             )),
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
          //==========================================================
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: 150,
          //       child: CustomeTextFormField(
          //         hintText: "Min Time Range",
          //         inputType: TextInputType.datetime,
          //         title: "",
          //         controller: widget.startTimeController,
          //         validator: (value) {},
          //         prefixIcon: null,
          //       ),
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 10.0),
          //       child: Text("<->"),
          //     ),
          //     SizedBox(
          //       width: 150,
          //       child: CustomeTextFormField(
          //         hintText: "Max Time Range",
          //         inputType: TextInputType.number,
          //         title: "",
          //         controller: widget.endTimeController,
          //         validator: (value) {},
          //         prefixIcon: null,
          //       ),
          //     ),
          //   ],
          // ),
          //=========================================
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Min range:"),
                Text("Max range:"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TimePickerWidget(
                isStartRange: true,
              ),
              TimePickerWidget(
                isStartRange: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
