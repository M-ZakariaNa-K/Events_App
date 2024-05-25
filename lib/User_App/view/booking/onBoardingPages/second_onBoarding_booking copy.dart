import 'package:events_app/User_App/components/booking/onBoarding_Questions_Component.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';

class SecondOnBoardingBooking extends StatelessWidget {
  const SecondOnBoardingBooking({super.key, required this.reagionController});
  final TextEditingController reagionController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //1
          const OnBoardingQuestionsComponent(
            title: "Manage your event",
            supTitle:
                "What are the reagions which you search about Lounges, organizers or Public Events in?",
            image: "assets/images/street-map.png",
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ThemesStyles.paddingprimary * 2),
            child: CustomeTextFormField(
                prefixIcon: null,
                hintText: "Ex: Mohjeren",
                inputType: TextInputType.text,
                title: "",
                controller: reagionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reagion';
                  }
                  return null;
                }),
          )
        ],
      ),
    );
  }
}
