import 'package:events_app/User_App/controllers/booking/choosen_user_date_widget.dart';
import 'package:events_app/User_App/controllers/booking/choosen_user_time_widget.dart';
import 'package:events_app/User_App/controllers/booking/date-picker.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/controllers/loungees&organizers/services_user_controller.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookNowPage extends StatefulWidget {
  const BookNowPage({super.key});

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  final RadioController _paymentController =
      Get.put(RadioController(), tag: 'Payment');
  TextEditingController _audincesNumber = TextEditingController();
  final List<String> radioData = ['Cashe', 'Electro'];
  int? selectedCardIndex;
  @override
  Widget build(BuildContext context) {
    final servicesDetailsController = Get.put(ServicesUserController());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 181, 181, 181)),
                  ),
                  child: CustomeTextFormField(
                    hintText: "Audinces number",
                    inputType: TextInputType.number,
                    title: "",
                    controller: _audincesNumber,
                    validator: (value) {},
                    prefixIcon: null,
                  ),
                ),
                //==================================================================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Choose your reservation time:",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 203, 203, 203),
                      fontSize: ThemesStyles.mainFontSize,
                    ),
                  ),
                ),
                ChoosenUserReservationTime(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Choose your reservation start date:",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 203, 203, 203),
                      fontSize: ThemesStyles.mainFontSize,
                    ),
                  ),
                ),
                const CalendarDialog(
                  isStart: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Choose your reservation end date:",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 203, 203, 203),
                      fontSize: ThemesStyles.mainFontSize,
                    ),
                  ),
                ),
                const CalendarDialog(
                  isStart: false,
                ),
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
                  itemCount: servicesDetailsController.servicesDetailsItems[0]
                      .services.length, // Adjust this based on your actual data
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 2.0, // Space between columns
                    mainAxisSpacing: 10.0, // Space between rows
                    childAspectRatio: 3 /
                        2, // Adjust this value to change the aspect ratio of the grid items
                  ),
                  itemBuilder: (context, index) {
                    int currentIndex = servicesDetailsController.servicesItems
                        .indexOf(
                            servicesDetailsController.servicesItems[index]);
                    bool isSelected = selectedCardIndex == currentIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCardIndex = currentIndex;
                        });
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
                                    "${servicesDetailsController.servicesDetailsItems[0].services[index].name}",
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
                                    "${servicesDetailsController.servicesDetailsItems[0].services[index].discountedPrice ?? 0}",
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
                                    "${servicesDetailsController.servicesDetailsItems[0].services[index].price}",
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
                _buildRadioButtonGroup("Payment type", _paymentController),
                //===============================================
                DefultButton(
                  buttonColor: ThemesStyles.primary,
                  borderColor: Colors.transparent,
                  textColor: ThemesStyles.seconndTextColor,
                  title: "Book..",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                )
              ]),
        ),
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
