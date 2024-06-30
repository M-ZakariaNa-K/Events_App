import 'dart:io';
import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
import 'package:events_app/common/components/auth/defaultFormField.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddServicesPage extends GetView<AddLoungesController> {
  AddServicesPage({super.key});
  var size, height, width;
  TextEditingController d = TextEditingController();
  String? dropdownValue; // Variable to hold the selected value
  List<String> dropdownItems = ['Item 1', 'Item 2', 'Item 3'];
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                                        width: width / 2,
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
          ).marginSymmetric(horizontal: width * 0.03, vertical: width * 0.03),
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
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: ThemesStyles.secondary,
                          ).marginOnly(left: width * 0.62),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: ThemesStyles.secondary),
                          onChanged: (value) {},
                          items: dropdownItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ).paddingSymmetric(horizontal: width * 0.02))
                    .marginSymmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
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
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(top: height * 0.01)
              ],
            ).marginOnly(top: height * 0.01),
          ).marginSymmetric(horizontal: width * 0.03, vertical: height * 0.03),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 2, // Adjust this based on your actual data
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
                  border: Border.all(color: ThemesStyles.secondary, width: 2),
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
          ).marginSymmetric(horizontal: width * 0.03),
          Expanded(
            child: Center(
              child: DefultButton(
                buttonColor: ThemesStyles.primary,
                borderColor: Colors.transparent,
                textColor: Colors.white,
                title: "Add Services",
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
