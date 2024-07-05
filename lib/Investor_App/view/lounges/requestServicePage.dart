import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
import 'package:events_app/Investor_App/view/lounges/addLoungesPage..dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/core/constants/theme.dart';

class RequestServicePage extends StatelessWidget {
  RequestServicePage({super.key});
  var size, height, width;
  final RadioController _eventKindController =
      Get.put(RadioController(), tag: 'EventKindController');

  final List<String> eventKindRadioData = ['Public', 'Private'];
  @override
  Widget build(BuildContext context) {
    TextEditingController enNameController = TextEditingController();
    TextEditingController arNameController = TextEditingController();
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
                    // Container(
                    //   width: width,
                    //   child: DefaultFormFeild(
                    //     autoFoucs: false,
                    //     hintText: "service",
                    //     validator: (String? value) {
                    //       if (value == '') {
                    //         return "this field is required";
                    //       }
                    //       return null;
                    //     },
                    //     textEditingController: d,
                    //     obscureText: false,
                    //   ),
                    // )
                    //     .paddingSymmetric(horizontal: width * 0.02)
                    //     .marginSymmetric(
                    //         horizontal: width * 0.02, vertical: height * 0.01),
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
                            hintText: "English name",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: enNameController,
                            obscureText: false,
                          ),
                        ),
                        Container(
                          width: width / 2.5,
                          child: DefaultFormFeild(
                            autoFoucs: false,
                            hintText: "Arabic name",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: arNameController,
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
                          onPressed: () async {
                            // Instantiate the controller once
                            final addLoungesController = AddLoungesController();

                            try {
                              // Post the new service data
                              await DioHelper.post(
                                  url: "$baseUrl/service/create",
                                  body: {
                                    "services": [
                                      {
                                        "kind": _eventKindController
                                                    .selectedValue.value ==
                                                0
                                            ? "public"
                                            : "private",
                                        "name": {
                                          "ar": arNameController.text,
                                          "en": enNameController.text
                                        }
                                      }
                                    ]
                                  });

                              // Clear the text controllers
                              arNameController.clear();
                              enNameController.clear();

                              // Fetch and refresh the dropdown items
                              addLoungesController.fetchDropdownItems();

                              // Go back to the previous screen

                              Get.back();
                            } catch (e) {
                              print('Error creating service: $e');
                              Get.snackbar("Error", "Failed to create service");
                            }
                          }),
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
          width: 120,
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
