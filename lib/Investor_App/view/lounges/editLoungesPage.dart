import 'dart:io';

import 'package:events_app/Investor_App/controllers/lounges/editLoungesController.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:events_app/Investor_App/models/lounge_details_model.dart';
import 'package:events_app/Investor_App/view/lounges/requestServicePage.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';

import '../../controllers/lounges/addLoungesController..dart';

class EditLoungesPage extends GetView<AddLoungesController> {
  EditLoungesPage({
    required this.id,
    required this.loungeDetailsItems,
  });

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

  TextEditingController servicesPriceController = TextEditingController();
  TextEditingController servicesProporationController = TextEditingController();
  final GlobalKey<FormState> _serviceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _allFormKey = GlobalKey<FormState>();
  final int id;
  final LoungeDetailsDataModel loungeDetailsItems;
  @override
  Widget build(BuildContext context) {
    hallNameARController.text = loungeDetailsItems.name;
    hallNameENController.text = loungeDetailsItems.name;
    capcityController.text = loungeDetailsItems.capacity.toString();
    addressController.text = loungeDetailsItems.address;
    _mixedController.selectedValue.value = loungeDetailsItems.mixedPrice;
    _dinnerController.selectedValue.value = loungeDetailsItems.dinner;
    dinnerPriceController.text = loungeDetailsItems.dinnerPrice.toString();
    mixedPriceController.text = loungeDetailsItems.mixedPrice.toString();

    final addLoungeController = Get.put(AddLoungesController());
    final editLoungeController = Get.put(EditLoungesController());
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
          child: Form(
            key: _allFormKey,
            child: Wrap(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Display fetched images
                      Container(
                          height: height * 0.15,
                          width: width,
                          child: Obx(() => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: editLoungeController
                                        .loungeDetailsItems.isNotEmpty
                                    ? editLoungeController.loungeDetailsItems[0]
                                            .photos.length +
                                        1
                                    : 1,
                                itemBuilder: (context, index) {
                                  // Check if the current index is for adding a new picture
                                  if (index == 0) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller
                                            .getImage(ImageSource.gallery);
                                      },
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 2,
                                            color: ThemesStyles.secondary,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: width * 0.3,
                                        height: height * 0.15,
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 30,
                                            color: ThemesStyles.secondary,
                                          ),
                                        ),
                                      ),
                                    ).marginOnly(left: width * 0.0);
                                  } else {
                                    // Display fetched images
                                    final imagePath = editLoungeController
                                            .loungeDetailsItems.isNotEmpty
                                        ? editLoungeController
                                            .loungeDetailsItems[0]
                                            .photos[index - 1]
                                        : null;

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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          width: width * 0.3,
                                          height: height,
                                          child: imagePath != null
                                              ? Image.network(
                                                  'http://10.0.2.2:8000/storage/$imagePath',
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Text(
                                                        'Failed to load image',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                        ).marginOnly(left: width * 0.03),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: ThemesStyles.secondary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                if (imagePath != null) {
                                                  // Remove image logic here
                                                  editLoungeController
                                                      .removeImage(imagePath);
                                                }
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ).marginOnly(left: width * 0.05);
                                  }
                                },
                              )).marginSymmetric(horizontal: width * 0.01)),
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
                        textInputType: TextInputType.number,
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
                          borderRadius: BorderRadius.all(Radius.circular(
                              ThemesStyles.borderradiusprimary))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 17.0),
                                  child: Text(
                                    "Mixed",
                                    style: TextStyle(
                                      fontSize: ThemesStyles.littelFontSize,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 19.0),
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
                          Obx(
                            () => Container(
                              width: width / 2.3,
                              child: DefaultFormFeild(
                                textInputType: TextInputType.number,
                                autoFoucs: false,
                                hintText: "Dinner Price",
                                validator:
                                    _dinnerController.selectedValue.value != 0
                                        ? (String? value) {
                                            if (value == '') {
                                              return "this field is required";
                                            }
                                            return null;
                                          }
                                        : (String? value) {},
                                textEditingController: dinnerPriceController,
                                obscureText: false,
                                enable:
                                    _dinnerController.selectedValue.value != 0,
                              ),
                            ),
                          ),
                          Obx(
                            () => Container(
                              width: width / 2.3,
                              child: DefaultFormFeild(
                                textInputType: TextInputType.number,
                                autoFoucs: false,
                                hintText: "Mixed Price",
                                validator:
                                    _mixedController.selectedValue.value != 0
                                        ? (String? value) {
                                            if (value == '') {
                                              return "this field is required";
                                            }
                                            return null;
                                          }
                                        : (String? value) {},
                                textEditingController: mixedPriceController,
                                obscureText: false,
                                enable:
                                    _mixedController.selectedValue.value != 0,
                              ),
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
                          onTap: () {
                            addLoungeController.addWorkHourController();
                          },
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
                    Obx(() {
                      return Column(
                        children: [
                          Column(
                            children: List.generate(
                              editLoungeController.workHourControllers.length,
                              (i) {
                                final workHourController =
                                    editLoungeController.workHourControllers[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width / 2.3,
                                        child: Obx(() {
                                          return workHourController['isEditing']
                                                  .value
                                              ? TextField(
                                                  controller:
                                                      workHourController[
                                                          'start'],
                                                  onSubmitted: (value) {
                                                    workHourController[
                                                                'isEditing']
                                                            .value =
                                                        workHourController[
                                                                'start']
                                                            .text
                                                            .isNotEmpty;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Start',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff979797),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 10.0,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      workHourController[
                                                              'isEditing']
                                                          .value = true;
                                                    },
                                                    child: Text(
                                                        workHourController[
                                                                'start']
                                                            .text),
                                                  ),
                                                );
                                        }),
                                      ),
                                      // Container(
                                      //   width: width / 2.3,
                                      //   child: TextField(
                                      //     controller:
                                      //         workHourController['start'],
                                      //     onSubmitted: (value) {
                                      //       workHourController['isEditing']
                                      //               .value =
                                      //           workHourController['start']
                                      //               .text
                                      //               .isNotEmpty;
                                      //     },
                                      //     decoration: const InputDecoration(
                                      //       hintText: 'Start',
                                      //       enabledBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color: Color(0xff979797),
                                      //         ),
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //         borderSide: BorderSide(
                                      //           color: Colors.red,
                                      //         ),
                                      //       ),
                                      //       contentPadding:
                                      //           EdgeInsets.symmetric(
                                      //         vertical: 5.0,
                                      //         horizontal: 10.0,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        width: width / 2.3,
                                        child: Obx(() {
                                          return workHourController['isEditing']
                                                  .value
                                              ? TextField(
                                                  controller:
                                                      workHourController['end'],
                                                  onSubmitted: (value) {
                                                    workHourController[
                                                                'isEditing']
                                                            .value =
                                                        workHourController[
                                                                'end']
                                                            .text
                                                            .isNotEmpty;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'End',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xff979797),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 10.0,
                                                    ),
                                                  ),
                                                )
                                              : Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      workHourController[
                                                              'isEditing']
                                                          .value = true;
                                                    },
                                                    child: Text(
                                                        workHourController[
                                                                'end']
                                                            .text),
                                                  ),
                                                );
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          //===================================================
                          Column(
                            children: List.generate(
                              addLoungeController.workHourControllers.length,
                              (i) {
                                final workHourController =
                                    addLoungeController.workHourControllers[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width / 2.3,
                                        child: workHourController['isEditing']
                                                .value
                                            ? TextField(
                                                controller:
                                                    workHourController['start'],
                                                onSubmitted: (value) {
                                                  workHourController['start']
                                                              .text !=
                                                          ""
                                                      ? workHourController[
                                                              'isEditing']
                                                          .value = false
                                                      : workHourController[
                                                              'isEditing']
                                                          .value = true;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Start',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xff979797),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical:
                                                        5.0, // Adjust vertical padding
                                                    horizontal:
                                                        10.0, // Adjust horizontal padding
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    workHourController[
                                                            'isEditing']
                                                        .value = true;
                                                  },
                                                  child: Text(
                                                      workHourController[
                                                              'start']
                                                          .text),
                                                ),
                                              ),
                                      ),
                                      Container(
                                        width: width / 2.3,
                                        child: workHourController['isEditing']
                                                .value
                                            ? TextField(
                                                controller:
                                                    workHourController['end'],
                                                onSubmitted: (value) {
                                                  workHourController['end']
                                                              .text !=
                                                          ""
                                                      ? workHourController[
                                                              'isEditing']
                                                          .value = false
                                                      : workHourController[
                                                              'isEditing']
                                                          .value = true;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'End',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xff979797),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical:
                                                        5.0, // Adjust vertical padding
                                                    horizontal:
                                                        10.0, // Adjust horizontal padding
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    workHourController[
                                                            'isEditing']
                                                        .value = true;
                                                  },
                                                  child: Text(
                                                      workHourController['end']
                                                          .text),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                    //=============================================================
                    Text(
                      "Services",
                      style: TextStyle(
                          color: ThemesStyles.textColor,
                          fontWeight: ThemesStyles.fontWeightBold,
                          fontSize: ThemesStyles.mainFontSize),
                    ).marginSymmetric(
                        horizontal: width * 0.03, vertical: height * 0.01),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ThemesStyles.secondary),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(
                                () => DropdownButton<String>(
                                  value: addLoungeController
                                          .dropdownValue.value.isNotEmpty
                                      ? addLoungeController.dropdownValue.value
                                      : null,
                                  icon: const Icon(
                                    Icons.arrow_downward,
                                    color: ThemesStyles.secondary,
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: ThemesStyles.primary),
                                  onChanged: (value) {
                                    addLoungeController.dropdownValue.value =
                                        value!;
                                  },
                                  items: addLoungeController.dropdownItems
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
                                    textInputType: TextInputType.number,
                                    autoFoucs: false,
                                    hintText: "Price",
                                    validator: (String? value) {
                                      if (value == '') {
                                        return "this field is required";
                                      }
                                      return null;
                                    },
                                    textEditingController:
                                        servicesPriceController,
                                    obscureText: false,
                                  ),
                                ),
                                Container(
                                  width: width / 2.5,
                                  child: Obx(
                                    () => Container(
                                      height: 50,
                                      child: TextFormField(
                                        controller:
                                            servicesProporationController,
                                        enableSuggestions: false,
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: ThemesStyles.primary,
                                        enabled: addLoungeController
                                                .dropdownValue.value ==
                                            "Birhtday", // Adjust the condition as per your logic
                                        validator: (String? value) {
                                          if (addLoungeController
                                                      .dropdownValue.value ==
                                                  "Birhtday" &&
                                              (value == null ||
                                                  value.isEmpty)) {
                                            return "This field is required";
                                          }
                                          return null;
                                        },
                                        autofocus: false,
                                        decoration: InputDecoration(
                                            hintText: "Proportion",
                                            hintStyle: TextStyle(
                                                color: ThemesStyles.textColor
                                                    .withAlpha(80),
                                                fontSize:
                                                    ThemesStyles.mainFontSize -
                                                        2),
                                            floatingLabelStyle: TextStyle(
                                              color: ThemesStyles.primary,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: ThemesStyles.primary
                                                    .withAlpha(80),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: ThemesStyles.primary,
                                                )),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                  color: Colors.red,
                                                )),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: ThemesStyles.primary,
                                                ))),
                                      ),
                                    ),
                                    // DefaultFormFeild(
                                    //   autoFoucs: false,
                                    //   hintText: "Proportion",
                                    //   validator: (String? value) {
                                    //     if (value == '') {
                                    //       return "this field is required";
                                    //     }
                                    //     return null;
                                    //   },
                                    //   textEditingController:
                                    //       servicesProporationController,
                                    //   obscureText: false,
                                    // ),
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
                                      if (_serviceFormKey.currentState!
                                          .validate()) {
                                        addLoungeController.serviceList.add({
                                          "name": addLoungeController
                                              .dropdownValue.value,
                                          // "proporation":
                                          //     servicesProporationController
                                          //         .text,
                                          "price": servicesPriceController.text,
                                        });
                                        servicesProporationController.clear();
                                        servicesPriceController.clear();
                                        addLoungeController
                                            .dropdownValue.value = '';
                                      }

                                      print(addLoungeController.serviceList);
                                    },
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
                                            fontSize:
                                                ThemesStyles.littelFontSize,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                ThemesStyles.primary),
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
                      ).marginSymmetric(horizontal: width * 0.02, vertical: 10),
                    ),
                    //====================================for EDIT=================================
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: loungeDetailsItems.services.length,
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
                                    loungeDetailsItems.services[index].name,
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
                                    loungeDetailsItems
                                            .services[index].discountedPrice ??
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
                                    loungeDetailsItems.services[index].price ??
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
                                      // loungeDetailsItems.services.remove(
                                      //     controller.serviceList[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).marginSymmetric(
                            horizontal: width * 0.02, vertical: height * 0.01);
                      },
                    ),
                    //====================================for EDIT=================================
                    Obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: addLoungeController.serviceList.length,
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
                                      addLoungeController.serviceList[index]
                                          ["name"],
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
                                      addLoungeController.serviceList[index]
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
                                      addLoungeController.serviceList[index]
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
                                        addLoungeController.serviceList.remove(
                                            controller.serviceList[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).marginSymmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01);
                        },
                      ),
                    ),
                    Center(
                      child: DefultButton(
                        buttonColor: ThemesStyles.primary,
                        borderColor: Colors.transparent,
                        textColor: Colors.white,
                        title: "Add Hall",
                        onPressed: () async {
                          if (_allFormKey.currentState!.validate()) {}
                        },
                      ),
                    ).marginOnly(top: 10)
                  ],
                ).marginOnly(top: height * 0.01)
              ],
            ).marginSymmetric(
                horizontal: width * 0.03, vertical: height * 0.04),
          ),
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

  EditLoungesPage copyWith({
    int? id,
    LoungeDetailsDataModel? loungeDetailsItems,
  }) {
    return EditLoungesPage(
      id: id ?? this.id,
      loungeDetailsItems: loungeDetailsItems ?? this.loungeDetailsItems,
    );
  }
}
