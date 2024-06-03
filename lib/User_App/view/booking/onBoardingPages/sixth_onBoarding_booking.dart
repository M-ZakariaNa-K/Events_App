import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SixthOnBoardingBooking extends StatelessWidget {
  SixthOnBoardingBooking({super.key});

  final List<String> radioData = ['No', 'Yes'];
  final selectedData = {};
  @override
  Widget build(BuildContext context) {
    final RadioController _mixedController =
        Get.put(RadioController(), tag: 'MixedServices');
    final RadioController _dinnerController =
        Get.put(RadioController(), tag: 'DinnerServices');
    final RadioController _photographyController =
        Get.put(RadioController(), tag: 'PhotographyServices');

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const OnBoardingQuestionsComponent(
            title: "Manage your event",
            supTitle: "Do you want any of the following services:",
            image: "assets/images/customer-service.png",
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff2B2B2B)
                    : ThemesStyles.thirdColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemesStyles.borderradiusprimary))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17.0),
                        child: Text(
                          "Mixed Services",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19.0),
                        child: Text(
                          "Dinner Services",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19.0),
                        child: Text(
                          "Prevent Photography",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      _buildRadioButtonGroup(
                          "Mixed Services", _mixedController),
                      _buildRadioButtonGroup(
                          "Dinner Services", _dinnerController),
                      _buildRadioButtonGroup(
                          "Prevent Photography", _photographyController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButtonGroup(String title, RadioController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRadioButtons(radioData, controller),
    );
  }

  List<Widget> _buildRadioButtons(
      List<String> radioData, RadioController controller) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: 100,
          child: Obx(() => RadioListTile<int>(
                contentPadding: EdgeInsets.zero, // Remove all padding
                activeColor: ThemesStyles.secondary,
                title: Text(
                  radioData[index],
                  style: TextStyle(
                    fontSize: ThemesStyles.littelFontSize,
                  ),
                ),
                value: index,
                groupValue: controller.selectedValue.value,
                onChanged: (int? value) {
                  controller.setSelectedValue(value!);
                },
              )),
        );
      },
    );
  }
}
