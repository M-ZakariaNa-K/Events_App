import 'package:events_app/Investor_App/view/lounges/addLoungesPage..dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/core/constants/theme.dart';

class RequestServicePage extends StatelessWidget {
  RequestServicePage({super.key});
  var size, height, width;
  final RadioController _eventKindController =
      Get.put(RadioController(), tag: 'EventKindController');

  final List<String> eventKindRadioData = ['Public', 'Privte'];
  @override
  Widget build(BuildContext context) {
    TextEditingController d = TextEditingController();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('Back'),
        ),
        drawer: const Drawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Request a service",
                style: TextStyle(
                    color: ThemesStyles.textColor,
                    fontWeight: ThemesStyles.fontWeightBold,
                    fontSize: ThemesStyles.mainFontSize),
              ).marginSymmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ThemesStyles.secondary)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      child: DefaultFormFeild(
                        autoFoucs: false,
                        hintText: "service",
                        validator: (String? value) {
                          if (value == '') {
                            return "this field is required";
                          }
                          return null;
                        },
                        textEditingController: d,
                        obscureText: false,
                      ),
                    )
                        .paddingSymmetric(horizontal: width * 0.02)
                        .marginSymmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildRadioButtons(
                          eventKindRadioData, _eventKindController),
                    ),
                    // Your existing widgets...
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width / 2.5,
                          child: DefaultFormFeild(
                            autoFoucs: false,
                            hintText: "Price",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: d,
                            obscureText: false,
                          ),
                        ),
                        Container(
                          width: width / 2.5,
                          child: DefaultFormFeild(
                            autoFoucs: false,
                            hintText: "Proportion",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: d,
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10,
                      ),
                      child: DefultButton(
                        buttonColor: ThemesStyles.secondary,
                        borderColor: Colors.transparent,
                        textColor: Colors.white,
                        title: "Request",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ).marginOnly(top: height * 0.01),
              ).marginSymmetric(horizontal: width * 0.02),
            ],
          ),
        ));
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
