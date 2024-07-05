// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';

class SixthOnBoardingBooking extends StatelessWidget {
  SixthOnBoardingBooking({
    Key? key,
    required this.startPriceController,
    required this.endPriceController,
  }) : super(key: key);
  final TextEditingController startPriceController;
  final TextEditingController endPriceController;
  final List<String> radioData = ['No', 'Yes'];
  final selectedData = {};
  @override
  Widget build(BuildContext context) {
    final RadioController _mixedController =
        Get.put(RadioController(), tag: 'MixedServices');
    final RadioController _dinnerController =
        Get.put(RadioController(), tag: 'DinnerServices');

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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            width: 350,
            child: Text(
              "Please enter your range of paying:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ThemesStyles.mainFontSize,
                // color: ThemesStyles.textColor.withOpacity(.8),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: CustomeTextFormField(
                  hintText: "Min Price Range",
                  inputType: TextInputType.number,
                  title: "",
                  controller: startPriceController,
                  validator: (value) {},
                  prefixIcon: null,
                ),
              ),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("<->"),
              ),
              SizedBox(
                width: 150,
                child: CustomeTextFormField(
                  hintText: "Max Price Range",
                  inputType: TextInputType.number,
                  title: "",
                  controller: endPriceController,
                  validator: (value) {},
                  prefixIcon: null,
                ),
              ),
            ],
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
