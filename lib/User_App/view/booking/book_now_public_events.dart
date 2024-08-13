import 'dart:io';

import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
import 'package:events_app/User_App/components/booking/book_event_category_widget.dart';
import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/User_App/controllers/booking/date-picker.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/lounges_user_controller.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class PublicEventsBookNowPage extends StatefulWidget {
  PublicEventsBookNowPage({super.key});

  @override
  State<PublicEventsBookNowPage> createState() =>
      _PublicEventsBookNowPageState();
}

class _PublicEventsBookNowPageState extends State<PublicEventsBookNowPage> {
  var size, height, width;

  final List<String> radioData1 = ['Cash', 'Electro'];

  final List<String> radioData2 = ['No', 'Yes'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedTimeCardIndex = -1;
  int selectedCardIndex = -1;

  // to check if the required fields are selected
  void _validateAndBook() async {
    final bookNowController = Get.put(BookNowController());
    if (selectedTimeCardIndex == -1) {
      _showError("Please select a reservation time.");
      return;
    } else if (selectedCardIndex == -1) {
      _showError("Please select a service.");
      return;
    } else if (bookNowController.selectedCategoryCardIndex == -1 &&
        bookNowController.addedCategorriesMap.isEmpty &&
        bookNowController.selectedServiceType.value == "public") {
      _showError("Please select an event category.");
      return;
    }

    // If all fields are valid, proceed with the booking
    else {
      if (_formKey.currentState!.validate()) {
        final addLoungeController = AddLoungesController();
        await bookNowController.postPublicEventData();
        print("====================================================");
        print(
            'bookNowController.publicEventBookedIdToUploadTheImage.value: ${bookNowController.publicEventBookedIdToUploadTheImage.value}');
        if (bookNowController.publicEventBookedIdToUploadTheImage.value != 0) {
          await addLoungeController.submitImagesForPublicEventBooking(
              id: bookNowController.publicEventBookedIdToUploadTheImage.value);
        }

        Navigator.pop(context);
      }
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      // colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookNowController = Get.put(BookNowController());
    final loungeDetailsController = Get.put(LoungesUserController());
    final addLoungeController = Get.put(AddLoungesController());
    Get.put(AddLoungesController());
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            bookNowController.selectedChoosenCategoryId.value = -1;
            bookNowController.existedCategoriesList.clear();
            bookNowController.addedCategorriesMap.value = {};
            bookNowController.nameController.clear();
            bookNowController.descraptionController.clear();
            bookNowController.addresaController.clear();
            bookNowController.audincesNumber.clear();
            bookNowController.addedArabicnameController.clear();
            bookNowController.addedEnglishnameController.clear();
            bookNowController.selectedServiceType.value = '';
            bookNowController.ticketPriceController.clear();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //=================upload images=======================
                  if (bookNowController.selectedServiceType.value == "public")
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
                                  itemCount: addLoungeController
                                          .selectedImagePaths.length +
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: width * 0.3,
                                        height: height * 0.15,
                                        child: GestureDetector(
                                          onTap: () {
                                            addLoungeController
                                                .getImage(ImageSource.gallery);
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
                                      final imagePath = addLoungeController
                                          .selectedImagePaths[index - 1];
                                      print('imagePath: ${imagePath}');
                                      return Stack(
                                        children: [
                                          Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 0.5,
                                                          blurRadius: 2,
                                                          color: Colors
                                                              .grey.shade300,
                                                          offset: const Offset(
                                                              5, 2))
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  width: width * 0.3,
                                                  height: height,
                                                  child: Image.file(
                                                      File(imagePath),
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
                                                      BorderRadius.circular(
                                                          20)),
                                              child: IconButton(
                                                icon: const Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () =>
                                                    addLoungeController
                                                        .removeImage(imagePath),
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
                  //=================upload images=======================
                  //==================================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Choose your audinces number:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),
                  CustomeTextFormField(
                    hintText: "Audinces number",
                    inputType: TextInputType.number,
                    title: "",
                    controller: bookNowController.audincesNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your audinces number';
                      }
                      return null;
                    },
                    prefixIcon: null,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose your reservation date:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),

                  const CalendarDialog(
                    isStart: true,
                    isOrganizer: false,
                  ),
                  //=======================================
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose your reservation time:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),

                  Obx(() {
                    return Column(
                      children: [
                        if (bookNowController.timesAvilableList.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color.fromARGB(255, 55, 55, 55)
                                      : const Color.fromARGB(
                                          255, 230, 230, 230),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 30,
                                    ).marginSymmetric(horizontal: 5),
                                    Flexible(
                                      child: Text(
                                        "Note: Choose another date to see available times in",
                                        style: TextStyle(
                                          fontSize: ThemesStyles.littelFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (bookNowController.timesAvilableList.isNotEmpty)
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  bookNowController.timesAvilableList.length,
                              itemBuilder: (context, index) {
                                bool isSelected =
                                    selectedTimeCardIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    selectedTimeCardIndex = index;
                                    setState(() {
                                      bookNowController
                                              .selectedChoosenTimeHall.value =
                                          bookNowController
                                              .timesAvilableList[index].id;
                                    });
                                  },
                                  child: Obx(
                                    () => Container(
                                      margin: const EdgeInsets.all(20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ThemesStyles.thirdColor,
                                        border: isSelected
                                            ? Border.all(
                                                color: ThemesStyles.primary,
                                                width: 1)
                                            : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Start: ",
                                                style: TextStyle(
                                                  color: ThemesStyles.secondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${bookNowController.timesAvilableList[index].startTime}",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "End: ",
                                                style: TextStyle(
                                                  color: ThemesStyles.secondary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${bookNowController.timesAvilableList[index].endTime}",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  }),
                  //==================HallOwner=====================
                  //=========================================
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose Service you want reserve:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: loungeDetailsController
                        .loungeDetailsItems[0]
                        .services
                        .length, // Adjust this based on your actual data
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 2.0, // Space between columns
                      mainAxisSpacing: 10.0, // Space between rows
                      childAspectRatio: 3 /
                          2, // Adjust this value to change the aspect ratio of the grid items
                    ),
                    itemBuilder: (context, index) {
                      int currentIndex = loungeDetailsController
                          .loungeDetailsItems[0].services
                          .indexOf(loungeDetailsController
                              .loungeDetailsItems[0].services[index]);
                      bool isSelected = selectedCardIndex == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCardIndex = currentIndex;
                            //to show the textfilds nedded in the UI when service kind is public

                            bookNowController.selectedServiceType.value =
                                loungeDetailsController.loungeDetailsItems[0]
                                    .services[currentIndex].kind;

                            bookNowController.selectedHallServiceId.value =
                                loungeDetailsController.loungeDetailsItems[0]
                                    .services[selectedCardIndex].id;
                          });
                          if (bookNowController.selectedServiceType.value ==
                              "public") {
                            bookNowController.getCategoriesList();
                          }
                        },
                        child: Obx(
                          () => Container(
                            width: 200,
                            // height: height / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 255, 237, 240),
                              border: isSelected
                                  ? Border.all(
                                      color: ThemesStyles.primary, width: 1)
                                  : null,
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
                                      "${loungeDetailsController.loungeDetailsItems[0].services[index].name}",
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.littelFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ).marginSymmetric(horizontal: 10),
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
                                      "${loungeDetailsController.loungeDetailsItems[0].services[index].discountedPrice ?? 0}",
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
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.littelFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${loungeDetailsController.loungeDetailsItems[0].services[index].price}",
                                      style: TextStyle(
                                        color: ThemesStyles.textColor,
                                        fontSize: ThemesStyles.littelFontSize,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ).marginSymmetric(horizontal: 10),
                              ],
                            ),
                          ).marginSymmetric(horizontal: 10, vertical: 10),
                        ),
                      );
                    },
                  ).marginSymmetric(vertical: 10),
                  //=====================================================
                  //SHOWING THE NEDDED TEXTFILDS WHEN THE SERVICE IS PUBLIC ZAK
                  Obx(() {
                    if (bookNowController.selectedServiceType.value ==
                        "public") {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Choose your name:",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 203, 203, 203),
                                fontSize: ThemesStyles.mainFontSize,
                              ),
                            ),
                          ),
                          CustomeTextFormField(
                            hintText: "Name",
                            inputType: TextInputType.text,
                            title: "",
                            controller: bookNowController.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          //==================================================================
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Type a descraption about your event:",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 203, 203, 203),
                                fontSize: ThemesStyles.mainFontSize,
                              ),
                            ),
                          ),
                          CustomeTextFormField(
                            hintText: "Descraption",
                            inputType: TextInputType.text,
                            title: "",
                            controller: bookNowController.descraptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your descraption';
                              }
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          //==================================================================
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Type your address:",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 203, 203, 203),
                                fontSize: ThemesStyles.mainFontSize,
                              ),
                            ),
                          ),
                          CustomeTextFormField(
                            hintText: "Address",
                            inputType: TextInputType.text,
                            title: "",
                            controller: bookNowController.addresaController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          //==================================================================
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Choose your event's ticket price:",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 203, 203, 203),
                                fontSize: ThemesStyles.mainFontSize,
                              ),
                            ),
                          ),
                          CustomeTextFormField(
                            hintText: "Ticket Price",
                            inputType: TextInputType.number,
                            title: "",
                            controller: bookNowController.ticketPriceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ticket price';
                              }
                              return null;
                            },
                            prefixIcon: null,
                          ),
                          //==================================================================
                          //===================================================
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Choose your event category:",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 203, 203, 203),
                                fontSize: ThemesStyles.mainFontSize,
                              ),
                            ),
                          ),
                          const BookEventCategoryWidget(),
                          //===================================================
                        ],
                      );
                    }
                    return SizedBox
                        .shrink(); // Return an empty widget if not public
                  }),
                  //===================================================
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose payment type:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),
                  _buildRadioButtonGroup("Payment type",
                      bookNowController.paymentController, radioData1),

                  //===================================================

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose services you want:",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 203, 203, 203),
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
                                child: Text(
                                  "Mixed Services",
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
                                  "Mixed Services",
                                  bookNowController.mixedController,
                                  radioData2),
                              _buildRadioButtonGroup(
                                  "Dinner Services",
                                  bookNowController.dinnerController,
                                  radioData2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //===============================================
                  DefultButton(
                    buttonColor: ThemesStyles.primary,
                    borderColor: Colors.transparent,
                    textColor: ThemesStyles.seconndTextColor,
                    title: "Book..",
                    onPressed: _validateAndBook,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup(
      String title, RadioController controller, List<String> radioData1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildRadioButtons(radioData1, controller),
    );
  }

  List<Widget> _buildRadioButtons(
      List<String> radioData, RadioController controller) {
    return List<Widget>.generate(
      radioData.length,
      (index) {
        return SizedBox(
          width: 110,
          child: Obx(() => RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
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
