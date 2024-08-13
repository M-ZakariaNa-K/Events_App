// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/controllers/publicEvent/public_eevent_controller.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:events_app/common/core/constants/theme.dart';

class DialogEventController extends GetxController {}

// ignore: camel_case_types
class P_Event_Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventScreen();
  }
}

class EventScreen extends StatelessWidget {
  final List<String> radioData1 = ['Cash', 'Electro'];
  final PageController _pageController = PageController();

  final List<String> images = [
    'assets/images/Profile.png',
    // 'assets/images/person.png',
    // 'assets/images/OffersCardBackgroundGraident1.jpeg',
    // 'assets/images/third_boanding.png',
  ];

  @override
  Widget build(BuildContext context) {
    final publicEventsController = Get.put(PublicEventController());
    DateTime startTime = DateFormat("HH:mm:ss")
        .parse(publicEventsController.publicEventsDetilaItems[0].startTime);
    DateTime endTime = DateFormat("HH:mm:ss")
        .parse(publicEventsController.publicEventsDetilaItems[0].endTime);

    // Timezone offset in hours
    int timezoneOffset = 0;
    // Adjust the DateTime objects for the timezone offset
    startTime = startTime.add(Duration(hours: timezoneOffset));
    endTime = endTime.add(Duration(hours: timezoneOffset));

    String formattedStartTime = DateFormat('HH.mm').format(startTime);
    String formattedEndTime = DateFormat('HH.mm').format(endTime);
    String timezoneLabel = "GMT +02:00";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Event Details"),
          titleTextStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? ThemesStyles.background
                : const Color(0xff464646),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: IconButton(
            color: Theme.of(context).brightness == Brightness.dark
                ? ThemesStyles.background
                : const Color(0xff464646),
            onPressed: () {
              publicEventsController.publicEventsDetilaItems.clear();
              publicEventsController.ticketPrice = 0.0;

              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ThemesStyles.primary,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 400,
                    width: MediaQuery.sizeOf(context).width,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return publicEventsController
                                        .publicEventsDetilaItems[0].photo ==
                                    "" ||
                                publicEventsController
                                        .publicEventsDetilaItems[0].photo ==
                                    null
                            ? Image.asset(
                                images[0],
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                '$photoBaseUrl${publicEventsController.publicEventsDetilaItems[0].photo}',
                                fit: BoxFit.contain,
                              );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 1,
                        effect: const WormEffect(
                          activeDotColor: ThemesStyles.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        publicEventsController
                            .publicEventsDetilaItems[0].eventName,
                        style: TextStyle(
                          fontSize: ThemesStyles.mainFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'By: ${publicEventsController.publicEventsDetilaItems[0].confirmedGuestId}',
                        style: TextStyle(
                          fontSize: ThemesStyles.littelFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: const Icon(
                              Icons.person,
                              color: ThemesStyles.primary,
                              size: 30,
                            )),
                        const SizedBox(width: 8),
                        Text(
                          'going ${publicEventsController.publicEventsDetilaItems[0].attendeesNumber} ',
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: const Icon(Icons.calendar_today,
                                color: ThemesStyles.primary)),
                        const SizedBox(width: 8),
                        Text(
                          "Start in: ",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE, MMMM dd, yyyy').format(
                              publicEventsController
                                  .publicEventsDetilaItems[0].startDate),
                          // 'almost Sold Out Tickets: zzzzzzzzzzzzzzzz',
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Icon(Icons.calendar_today,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          "End in: ",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE, MMMM dd, yyyy').format(
                              publicEventsController
                                  .publicEventsDetilaItems[0].endDate),
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Icon(Icons.access_time,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          '$formattedStartTime - $formattedEndTime (PM) ($timezoneLabel)',
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Icon(Icons.location_on,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            publicEventsController
                                .publicEventsDetilaItems[0].address,
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 16),
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: const Text('See Location on Maps'),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Icon(Icons.description,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          publicEventsController
                                  .publicEventsDetilaItems[0].notes ??
                              "There is no notes",
                          style: TextStyle(
                            fontSize: ThemesStyles.littelFontSize,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: const Icon(Icons.price_change,
                                color: ThemesStyles.primary)),
                        const SizedBox(width: 8),
                        Text(
                          'Ticket Price: ${publicEventsController.publicEventsDetilaItems[0].ticketPrice} SYR',
                          style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: ElevatedButton(
            onPressed: () {
              token != ""
                  ? _showBookingDialog(context)
                  : Get.offAll(() => LoginPage());
            },
            // ignore: sort_child_properties_last
            child: Text(
              token != "" ? ' !Book Now' : 'Sign In',
              style: const TextStyle(
                color: Color(0xFFFBEFF6),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: ThemesStyles.primary,
              textStyle: TextStyle(
                fontSize: ThemesStyles.littelFontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final publicController = Get.put(PublicEventController());
        return AlertDialog(
          title: const Text(
            'Reservation Confirmation',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(() => DropdownButton<String>(
              //       value: eventController.selectedDate.value,
              //       onChanged: (String? newValue) {
              //         eventController.selectedDate.value = newValue!;
              //       },
              //       items: eventController.availableDates
              //           .map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //     )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Choose payment type:",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 203, 203, 203),
                    fontSize: ThemesStyles.littelFontSize,
                  ),
                ),
              ),
              _buildRadioButtonGroup("Payment type",
                  publicController.paymentController, radioData1),

              Form(
                key: publicController.formKey,
                child: TextFormField(
                  controller: publicController.ticketsNumberTicketsController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Tickets',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 203, 203, 203),
                      fontSize: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    publicController.ticketCount.value =
                        int.tryParse(value) ?? 1;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of tickets';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number <= 0) {
                      return 'Please enter a valid number of tickets';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                    'Total Price: \$${publicController.totalPrice}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Approve'),
              onPressed: () async {
                if (publicController.formKey.currentState!.validate()) {
                  final String paymentType;
                  if (publicController.paymentController.selectedValue.value ==
                      0) {
                    paymentType = "cash";
                  } else {
                    paymentType = "electro";
                  }
                  await publicController.postReserveTicket(
                    eventId: publicController.publicEventsDetilaItems[0].id,
                    paymentType: paymentType,
                  );
                  print(paymentType);
                  publicController.ticketsNumberTicketsController.clear();
                  publicController.ticketCount.value = 1;
                  publicController.ticketPrice = double.parse(
                      publicController.publicEventsDetilaItems[0].ticketPrice);
                  publicController.paymentController.selectedValue.value = 0;

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
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
