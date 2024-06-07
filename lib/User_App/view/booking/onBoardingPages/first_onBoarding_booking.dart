import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstOnBoardingBooking extends StatelessWidget {
  FirstOnBoardingBooking({super.key});

  // Use a tagged controller for EventKind
  final RadioController _eventKindController =
      Get.put(RadioController(), tag: 'EventKind');

  final List<String> radioData = ['Public', 'Private'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1
          const OnBoardingQuestionsComponent(
            title: "Manage your event",
            supTitle: "Is the event you want public or private?",
            image: "assets/images/publiceventBooking.png",
          ),
          //2 radio button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildRadioButtons(radioData),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRadioButtons(List<String> radioData) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: 150,
          child: Obx(() => RadioListTile<int>(
                activeColor: ThemesStyles.secondary,
                title: Text(radioData[index]),
                value: index,
                groupValue: _eventKindController.selectedValue.value,
                onChanged: (int? value) {
                  _eventKindController.setSelectedValue(value!);
                },
              )),
        );
      },
    );
  }
}
