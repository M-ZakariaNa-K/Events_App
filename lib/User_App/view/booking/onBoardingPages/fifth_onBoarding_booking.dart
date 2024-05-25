import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class FifthOnBoardingBooking extends StatelessWidget {
  FifthOnBoardingBooking({super.key, required this.numberController});
  final TextEditingController numberController;
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
            supTitle: "What is the number of your audiences?",
            image: "assets/images/audience.png",
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ThemesStyles.paddingprimary * 2),
            child: CustomeTextFormField(
                prefixIcon: null,
                hintText: "Ex: 200",
                inputType: TextInputType.number,
                title: "",
                controller: numberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Number of audiences';
                  }
                  return null;
                }),
          )
        ],
      ),
    );
  }
}
