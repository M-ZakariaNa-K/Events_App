import 'dart:ffi';
import 'dart:io';
import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
import 'package:events_app/Investor_App/controllers/services/add_services_controller.dart';
import 'package:events_app/Investor_App/controllers/services/services_controller.dart';
import 'package:events_app/Investor_App/view/lounges/requestServicePage.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddServicesPage extends GetView<AddServiceController> {
  AddServicesPage({super.key, required this.isTheFirstVisit});
  var size, height, width;
  final bool isTheFirstVisit;
  TextEditingController addressController = TextEditingController();
  TextEditingController servicesPriceController = TextEditingController();
  TextEditingController servicesProporationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  final GlobalKey<FormState> _serviceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _allFormKey = GlobalKey<FormState>();
  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime =
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final addServiceController = Get.put(AddServiceController());
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
      body: Form(
        key: _allFormKey,
        child: ListView(
          children: [
            if (isTheFirstVisit)
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
                          itemCount: controller.selectedImagePaths.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2, color: ThemesStyles.secondary),
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
                                          offset: const Offset(5, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: width * 0.3,
                                    height: height,
                                    child: Image.file(File(imagePath),
                                        fit: BoxFit.fill),
                                  ).marginOnly(left: width * 0.03),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: ThemesStyles.secondary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            controller.removeImage(imagePath),
                                      ),
                                    ),
                                  ),
                                ],
                              ).marginOnly(left: width * 0.05);
                            }
                          },
                        ),
                      ).marginSymmetric(horizontal: width * 0.01),
                    ),
                  ],
                ),
              ),
            if (isTheFirstVisit)
              Text(
                "Work Hours",
                style: TextStyle(
                    color: ThemesStyles.textColor,
                    fontWeight: ThemesStyles.fontWeightBold,
                    fontSize: ThemesStyles.mainFontSize),
              ).marginSymmetric(horizontal: width * 0.03, vertical: 20),
            if (isTheFirstVisit)
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width / 2.3,
                      child: addServiceController.isTextFildEditing.value
                          ? TextField(
                              keyboardType: TextInputType.datetime,
                              controller: startTimeController,
                              onSubmitted: (value) {
                                startTimeController.text != ""
                                    ? addServiceController
                                        .isTextFildEditing.value = false
                                    : addServiceController
                                        .isTextFildEditing.value = true;
                              },
                              decoration: InputDecoration(
                                hintText: 'Start',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff979797),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, // Adjust vertical padding
                                  horizontal: 10.0, // Adjust horizontal padding
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (pickedTime != null) {
                                      startTimeController.text =
                                          formatTimeOfDay(pickedTime);
                                    }
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: InkWell(
                                onTap: () {
                                  addServiceController.isTextFildEditing.value =
                                      true;
                                },
                                child: Text(startTimeController.text),
                              ),
                            ),
                    ),
                    Container(
                      width: width / 2.3,
                      child: addServiceController.isTextFildEditing.value
                          ? TextField(
                              keyboardType: TextInputType.datetime,
                              controller: endTimeController,
                              onSubmitted: (value) {
                                endTimeController.text != ""
                                    ? addServiceController
                                        .isTextFildEditing.value = false
                                    : addServiceController
                                        .isTextFildEditing.value = true;
                              },
                              decoration: InputDecoration(
                                hintText: 'End',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff979797),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, // Adjust vertical padding
                                  horizontal: 10.0, // Adjust horizontal padding
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (pickedTime != null) {
                                      endTimeController.text =
                                          formatTimeOfDay(pickedTime);
                                    }
                                  },
                                ),
                              ),
                            )
                          : Center(
                              child: InkWell(
                                onTap: () {
                                  addServiceController.isTextFildEditing.value =
                                      true;
                                },
                                child: Text(endTimeController.text),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            Text(
              "Services",
              style: TextStyle(
                  color: ThemesStyles.textColor,
                  fontWeight: ThemesStyles.fontWeightBold,
                  fontSize: ThemesStyles.mainFontSize),
            )
                .marginSymmetric(
                  horizontal: width * 0.03,
                )
                .marginOnly(top: 20),
            Form(
              key: _serviceFormKey,
              child: Container(
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
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration:
                                BoxDecoration(
                                    border: Border.all(
                                        color: ThemesStyles.secondary),
                                    borderRadius: BorderRadius.circular(20)),
                            child: Obx(
                              () => DropdownButton<String>(
                                value: addServiceController
                                        .dropdownValue.value.isNotEmpty
                                    ? addServiceController.dropdownValue.value
                                    : null,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: ThemesStyles.secondary,
                                ).marginOnly(left: width * 0.62),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                    color: ThemesStyles.secondary),
                                onChanged: (value) {
                                  addServiceController.dropdownValue.value =
                                      value!;
                                },
                                items: addServiceController.dropdownItems
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ))
                        .marginSymmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
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
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              controller: servicesProporationController,
                              enableSuggestions: false,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              textInputAction: TextInputAction.next,
                              cursorColor: ThemesStyles.primary,
                              // enabled: addServiceController
                              //         .dropdownValue.value ==
                              //     "Birhtday", // Adjust the condition as per your logic
                              // validator: (String? value) {
                              //   if (addServiceController
                              //               .dropdownValue.value ==
                              //           "Birhtday" &&
                              //       (value == null || value.isEmpty)) {
                              //     return "This field is required";
                              //   }
                              //   return null;
                              // },
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: "Proportion",
                                hintStyle: TextStyle(
                                    color: ThemesStyles.textColor.withAlpha(80),
                                    fontSize: ThemesStyles.mainFontSize - 2),
                                floatingLabelStyle: const TextStyle(
                                  color: ThemesStyles.primary,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: ThemesStyles.primary.withAlpha(80),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: ThemesStyles.primary,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: ThemesStyles.primary,
                                    )),
                              ),
                            ),
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
                            onPressed: () {
                              if (_serviceFormKey.currentState!.validate()) {
                                addServiceController.serviceList.add({
                                  "name":
                                      addServiceController.dropdownValue.value,
                                  // "proporation":
                                  //     servicesProporationController.text,
                                  "price": servicesPriceController.text,
                                });
                                servicesProporationController.clear();
                                servicesPriceController.clear();
                                addServiceController.dropdownValue.value = '';
                              }

                              print(addServiceController.serviceList);
                            },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: width / 2.5,
                          child: Center(
                            child: InkWell(
                              child: Text(
                                "Request a service",
                                style: TextStyle(
                                    color: ThemesStyles.primary,
                                    fontSize: ThemesStyles.littelFontSize,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ThemesStyles.primary),
                              ),
                              onTap: () {
                                Get.to(() => RequestServicePage(
                                      isEditPage: false,
                                      isOrganizer: true,
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ).marginOnly(top: height * 0.01)
                  ],
                ).marginOnly(top: height * 0.01),
              ).marginSymmetric(
                  horizontal: width * 0.03, vertical: height * 0.03),
            ),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addServiceController.serviceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      border:
                          Border.all(color: ThemesStyles.secondary, width: 2),
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
                              addServiceController.serviceList[index]["name"],
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
                              addServiceController.serviceList[index]
                                      ["proporation"] ??
                                  "",
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
                              addServiceController.serviceList[index]
                                      ["price"] ??
                                  "",
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
                              onPressed: () {
                                addServiceController.serviceList
                                    .remove(controller.serviceList[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).marginSymmetric(
                      horizontal: width * 0.02, vertical: height * 0.01);
                },
              ).marginSymmetric(horizontal: width * 0.03),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Center(
                child: DefultButton(
                  buttonColor: ThemesStyles.primary,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  title: "Add Services",
                  onPressed: () async {
                    if (
                        // _allFormKey.currentState!.validate()
                        addServiceController.serviceList.isNotEmpty &&
                            isTheFirstVisit) {
                              final servicesShowController = Get.put(ServicesHomePageController());
                              servicesShowController.isFirstTimeForOrganizer.value = false;
                              
                      await addServiceController.submitData();

                      //===============================================

                      //------------------------------------------------------
                      List<Map<String, dynamic>> existed =
                          addServiceController.createExistedList(
                              addServiceController.serviceList,
                              addServiceController.dropdownItemsAllData);
                      addServiceController.allDataToAPI["services"] = {
                        "existed": existed,
                        "added": [
                          // {
                          //   "name": {"ar": "عرس", "en": "Wedding"},
                          //   "kind": "private",
                          //   "price": "100"
                          // }
                        ],
                      };
                      addServiceController
                              .allDataToAPI["organizer_start_time"] =
                          startTimeController.text;
                      addServiceController.allDataToAPI["organizer_end_time"] =
                          endTimeController.text;
                      print(
                          ' addServiceController.allDataToAP: ${addServiceController.allDataToAPI}');
                      //------------------------------------------------------
                      //===============================================

                      await addServiceController.postServicesData();
                    }
                    if (
                        // _allFormKey.currentState!.validate()
                        addServiceController.serviceList.isNotEmpty &&
                            !isTheFirstVisit) {
                      List<Map<String, dynamic>> existed =
                          addServiceController.createExistedList(
                              addServiceController.serviceList,
                              addServiceController.dropdownItemsAllData);
                      addServiceController.allDataToAPISecondTime["services"] =
                          {
                        "existed": existed,
                        "added": [
                          // {
                          //   "name": {"ar": "عرس", "en": "Wedding"},
                          //   "kind": "private",
                          //   "price": "100"
                          // }
                        ],
                      };

                      await addServiceController.postServicesDataSecondTime();
                      print(
                          ' addServiceController.allDataToAP: ${addServiceController.allDataToAPISecondTime}');
                      //------------------------------------------------------
                      //===============================================
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
