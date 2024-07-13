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
  final RadioController _roleController =
      Get.put(RadioController(), tag: 'role');

  final List<String> radioData = ['Public', 'Private'];
  final List<String> roleData = ['Organizer', 'Hall owner'];

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
            children: _buildRadioButtons(radioData, false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildRadioButtons(roleData, true),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRadioButtons(List<String> radioData, bool isrole) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: 180,
          child: Obx(() => RadioListTile<int>(
                activeColor: ThemesStyles.secondary,
                title: Text(isrole ? roleData[index] : radioData[index]),
                value: index,
                groupValue: isrole
                    ? _roleController.selectedValue.value
                    : _eventKindController.selectedValue.value,
                onChanged: (int? value) {
                  isrole
                      ? _roleController.setSelectedValue(value!)
                      : _eventKindController.setSelectedValue(value!);
                },
              )),
        );
      },
    );
  }
}
