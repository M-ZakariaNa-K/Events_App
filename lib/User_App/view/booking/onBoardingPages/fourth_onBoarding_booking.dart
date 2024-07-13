import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/User_App/model/ListServicesForSecondSlideReservationModel.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FourthOnBoardingBooking extends StatefulWidget {
  const FourthOnBoardingBooking(
      {super.key,
      required this.onCategorySelected,
      required this.listOfServicesSecondSlide});
  final void Function(String time) onCategorySelected;
  final List<ListServicesForSecondSlideReservationDataModel>
      listOfServicesSecondSlide;
  @override
  State<FourthOnBoardingBooking> createState() =>
      _FourthOnBoardingBookingState();
}

class _FourthOnBoardingBookingState extends State<FourthOnBoardingBooking> {
  int? selectedCardIndex;

  double cardHeight = 40.0;

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
                children: List.generate(widget.listOfServicesSecondSlide.length,
                    (index) {
                  int currentIndex = widget.listOfServicesSecondSlide
                      .indexOf(widget.listOfServicesSecondSlide[index]);
                  bool isSelected = selectedCardIndex == currentIndex;
                  return SizedBox(
                    width: 100,
                    height: cardHeight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCardIndex = currentIndex;
                           sharedServiceId=widget.listOfServicesSecondSlide[index].id;
                        });
                        widget.onCategorySelected(widget
                            .listOfServicesSecondSlide[index]
                            .name); // Notify parent widget
                        //Here we will save the Event Kind
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xff2B2B2B)
                              : ThemesStyles.thirdColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: isSelected
                              ? Border.all(
                                  color: ThemesStyles.secondary, width: 1)
                              : null,
                        ),
                        child: Center(
                            child: Text(
                          widget.listOfServicesSecondSlide[index].name,
                          style: const TextStyle(),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
