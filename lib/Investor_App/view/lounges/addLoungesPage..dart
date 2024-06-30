import 'dart:io';

import 'package:events_app/Investor_App/view/lounges/requestServicePage.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';

import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/lounges/addLoungesController..dart';

class AddLoungesPage extends GetView<AddLoungesController> {
  AddLoungesPage({super.key});
  var size, height, width;
  // Use a tagged controller for EventKind
  final RadioController _mixedController =
      Get.put(RadioController(), tag: 'MixedServices');
  final RadioController _dinnerController =
      Get.put(RadioController(), tag: 'DinnerServices');
  final List<String> radioData = ['No', 'Yes'];
  TextEditingController hallNameARController = TextEditingController();
  TextEditingController hallNameENController = TextEditingController();
  TextEditingController capcityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dinnerPriceController = TextEditingController();
  TextEditingController mixedPriceController = TextEditingController();
  TextEditingController startWorkHourController = TextEditingController();
  TextEditingController endWorkHourController = TextEditingController();
  TextEditingController servicesPriceController = TextEditingController();
  TextEditingController servicesProporationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final addLoungecontroller =
        Get.put(AddLoungesController()); // Initialize the controller
    Get.put(AddLoungesController());
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
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: height * 0.15,
                      width: width,
                      child: Obx(
                        () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: controller.selectedImagePaths.length +
                                1, // Increase itemCount by 1
                            itemBuilder: (context, index) {
                              // Check if the current index is 0
                              if (index == 0) {
                                // Return the Container for adding a new picture
                                return Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 2,
                                        color: ThemesStyles.secondary),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: width * 0.3,
                                  height: height * 0.15,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.getImage(ImageSource.gallery);
                                    },
                                    child: const Center(
                                      child: Icon(
                                        size: 30,
                                        Icons.add_a_photo,
                                        color: ThemesStyles.secondary,
                                      ),
                                    ),
                                  ),
                                ).marginOnly(left: width * 0.0);
                              } else {
                                // Adjust the index to account for the first item
                                final imagePath =
                                    controller.selectedImagePaths[index - 1];
                                return Stack(
                                  children: [
                                    Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 0.5,
                                                    blurRadius: 2,
                                                    color: Colors.grey.shade300,
                                                    offset: Offset(5, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            width: width * 0.3,
                                            height: height,
                                            child: Image.file(File(imagePath),
                                                fit: BoxFit.fill))
                                        .marginOnly(left: width * 0.03),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: ThemesStyles.secondary,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controller.removeImage(imagePath),
                                        ),
                                      ),
                                    )
                                  ],
                                ).marginOnly(left: width * 0.05);
                              }
                            }),
                      ).marginSymmetric(horizontal: width * 0.01),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hall Name",
                    style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize),
                  ).marginSymmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width / 2.3,
                        child:
                            //  CustomeTextFormField(
                            //   hintText: "Name in English",
                            //   inputType: TextInputType.text,
                            //   title: "",
                            //   controller: d,
                            //   validator: (String? value) {
                            //     if (value == '') {
                            //       return "this field is required";
                            //     }
                            //     return null;
                            //   },
                            //   prefixIcon: null,
                            // ),
                            DefaultFormFeild(
                          autoFoucs: false,
                          hintText: "Name in English",
                          validator: (String? value) {
                            if (value == '') {
                              return "this field is required";
                            }
                            return null;
                          },
                          textEditingController: hallNameENController,
                          obscureText: false,
                        ),
                      ),
                      Container(
                        width: width / 2.3,
                        child:
                            // CustomeTextFormField(
                            //   hintText: "الاسم باللغة العربية",
                            //   inputType: TextInputType.text,
                            //   title: "",
                            //   controller: d,
                            //   validator: (String? value) {
                            //     if (value == '') {
                            //       return "this field is required";
                            //     }
                            //     return null;
                            //   },
                            //   prefixIcon: null,
                            // ),
                            DefaultFormFeild(
                          autoFoucs: false,
                          hintText: "الاسم باللغة العربية",
                          validator: (String? value) {
                            if (value == '') {
                              return "this field is required";
                            }
                            return null;
                          },
                          textEditingController: hallNameARController,
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Capcity",
                    style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize),
                  ).marginSymmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  Container(
                    width: width / 2.3,
                    child: DefaultFormFeild(
                      autoFoucs: false,
                      hintText: "Capcity",
                      validator: (String? value) {
                        if (value == '') {
                          return "this field is required";
                        }
                        return null;
                      },
                      textEditingController: capcityController,
                      obscureText: false,
                    ),
                  ).marginSymmetric(horizontal: width * 0.03),
                  Text(
                    "Address",
                    style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize),
                  ).marginSymmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  Container(
                    width: width,
                    child: DefaultFormFeild(
                      autoFoucs: false,
                      hintText: "Address",
                      validator: (String? value) {
                        if (value == '') {
                          return "this field is required";
                        }
                        return null;
                      },
                      textEditingController: addressController,
                      obscureText: false,
                    ),
                  ).marginSymmetric(horizontal: width * 0.03),
                  Text(
                    "Main services",
                    style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize),
                  ).marginSymmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),

                  Container(
                    width: width,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
                                child: Text(
                                  "Mixed",
                                  style: TextStyle(
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 19.0),
                                child: Text(
                                  "Dinner",
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

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width / 2.3,
                          child: DefaultFormFeild(
                            autoFoucs: false,
                            hintText: "Dinner Price",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: dinnerPriceController,
                            obscureText: false,
                          ),
                        ),
                        Container(
                          width: width / 2.3,
                          child: DefaultFormFeild(
                            autoFoucs: false,
                            hintText: "Mixed Price",
                            validator: (String? value) {
                              if (value == '') {
                                return "this field is required";
                              }
                              return null;
                            },
                            textEditingController: mixedPriceController,
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //===========================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Work hours",
                        style: TextStyle(
                            color: ThemesStyles.textColor,
                            fontWeight: ThemesStyles.fontWeightBold,
                            fontSize: ThemesStyles.mainFontSize),
                      ).marginSymmetric(
                          horizontal: width * 0.03, vertical: height * 0.01),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ThemesStyles.secondary),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ).marginSymmetric(horizontal: width * 0.03)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width / 2.3,
                        child: DefaultFormFeild(
                          autoFoucs: false,
                          hintText: "start",
                          validator: (String? value) {
                            if (value == '') {
                              return "this field is required";
                            }
                            return null;
                          },
                          textEditingController: startWorkHourController,
                          obscureText: false,
                        ),
                      ),
                      Container(
                        width: width / 2.3,
                        child: DefaultFormFeild(
                          autoFoucs: false,
                          hintText: "End",
                          validator: (String? value) {
                            if (value == '') {
                              return "this field is required";
                            }
                            return null;
                          },
                          textEditingController: endWorkHourController,
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  //=============================================================
                  Text(
                    "Services",
                    style: TextStyle(
                        color: ThemesStyles.textColor,
                        fontWeight: ThemesStyles.fontWeightBold,
                        fontSize: ThemesStyles.mainFontSize),
                  ).marginSymmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  Container(
                    width: width,
                    height: height / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ThemesStyles.secondary)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              border: Border.all(color: ThemesStyles.secondary),
                              borderRadius: BorderRadius.circular(20)),
                          child: Obx(
                            () => DropdownButton<String>(
                              value: addLoungecontroller
                                      .dropdownValue.value.isNotEmpty
                                  ? addLoungecontroller.dropdownValue.value
                                  : null,
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: ThemesStyles.secondary,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style:
                                  const TextStyle(color: ThemesStyles.primary),
                              onChanged: (value) {
                                addLoungecontroller.dropdownValue.value =
                                    value!;
                              },
                              items: addLoungecontroller.dropdownItems
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ).marginSymmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.01,
                        ),
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
                                textEditingController: servicesPriceController,
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
                                textEditingController:
                                    servicesProporationController,
                                obscureText: false,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              child: DefultButton(
                                buttonColor: ThemesStyles.primary,
                                borderColor: Colors.transparent,
                                textColor: Colors.white,
                                title: "ADD",
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              height: 50,
                              width: width / 2.5,
                              child: Center(
                                child: InkWell(
                                  child: Text(
                                    "Request a services",
                                    style: TextStyle(
                                        color: ThemesStyles.primary,
                                        fontSize: ThemesStyles.littelFontSize,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ThemesStyles.primary),
                                  ),
                                  onTap: () {
                                    Get.to(() => RequestServicePage());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ).marginOnly(top: height * 0.01)
                      ],
                    ).marginOnly(top: height * 0.01),
                  ).marginSymmetric(horizontal: width * 0.02),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 2, // Adjust this based on your actual data
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 2.0, // Space between columns
                      mainAxisSpacing: 10.0, // Space between rows
                      childAspectRatio: 3 /
                          3, // Adjust this value to change the aspect ratio of the grid items
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: width / 2,
                        height: height / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 15,
                              offset: Offset(5, 5),
                            )
                          ],
                          border: Border.all(
                              color: ThemesStyles.secondary, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Services :",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "AnyThing",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ).marginSymmetric(horizontal: width * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Proportion : ",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "300",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Price : ",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "500",
                                  style: TextStyle(
                                    color: ThemesStyles.textColor,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ).marginSymmetric(horizontal: width * 0.05),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                width: 100,
                                child: DefultButton(
                                  buttonColor: ThemesStyles.background,
                                  borderColor: ThemesStyles.secondary,
                                  textColor: Colors.red,
                                  title: "Delete",
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).marginSymmetric(
                          horizontal: width * 0.02, vertical: height * 0.01);
                    },
                  ),
                  Center(
                    child: DefultButton(
                      buttonColor: ThemesStyles.primary,
                      borderColor: Colors.transparent,
                      textColor: Colors.white,
                      title: "Add Hall",
                      onPressed: () {
                        addLoungecontroller.submitData();
                      },
                    ),
                  
                  )
                ],
              ).marginOnly(top: height * 0.01)
            ],
          ).marginSymmetric(horizontal: width * 0.03, vertical: height * 0.04),
        ));
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
