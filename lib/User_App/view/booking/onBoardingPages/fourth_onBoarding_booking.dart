import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FourthOnBoardingBooking extends StatefulWidget {
  FourthOnBoardingBooking({super.key, required this.onCategorySelected});
  final void Function(String time) onCategorySelected;
  @override
  State<FourthOnBoardingBooking> createState() =>
      _FourthOnBoardingBookingState();
}

class _FourthOnBoardingBookingState extends State<FourthOnBoardingBooking> {
  int? selectedCardIndex;

  double cardHeight = 40.0;

  //if user choose the event as Privte
  final List<String> items = [
    "Wedding",
    "Birthday Party",
    "Graduation",
  ];

  //if user choose the event as Public
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1
          const OnBoardingQuestionsComponent(
            title: "Manage your event",
            supTitle: "What is your event kind?",
            image: "assets/images/categories.png",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0, // spacing between items
              runSpacing: 8.0, // spacing between lines
              children: items.map((item) {
                int currentIndex = items.indexOf(item);
                bool isSelected = selectedCardIndex == currentIndex;
                return SizedBox(
                  width: 100,
                  height: cardHeight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCardIndex = currentIndex;
                      });
                      widget.onCategorySelected(item); // Notify parent widget
                      //Here we will save the Event Kind
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemesStyles.thirdColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: isSelected
                            ? Border.all(color: Colors.red, width: 1)
                            : null,
                      ),
                      child: Center(
                          child: Text(
                        item,
                        style: const TextStyle(
                          color: ThemesStyles.textColor,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
