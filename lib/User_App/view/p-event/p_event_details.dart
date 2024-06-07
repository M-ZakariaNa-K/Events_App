import 'package:get/get.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventController extends GetxController {
  var selectedDate = 'Monday, December 24, 2022'.obs;
  var ticketCount = 1.obs;
  final double ticketPrice = 100;

  List<String> availableDates = [
    'Monday, December 24, 2022',
    'Tuesday, December 25, 2022',
    'Wednesday, December 26, 2022'
  ];

  double get totalPrice => ticketCount.value * ticketPrice;
}

// ignore: camel_case_types
class P_Event_Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventScreen(),
    );
  }
}

class EventScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final EventController eventController = Get.put(EventController());

  final List<String> images = [
    'assets/images/Profile.png',
    'assets/images/person.png',
    'assets/images/OffersCardBackgroundGraident1.jpeg',
    'assets/images/third_boanding.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: ThemesStyles.primary,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    padding: EdgeInsets.all(10),
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
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
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
                        count: images.length,
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
                        'National Music Festival',
                        style: TextStyle(
                          fontSize: ThemesStyles.mainFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'By: Zena Alsaadi',
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
                            decoration: BoxDecoration(
                                color: Color(0xFFFBEFF6),
                                shape: BoxShape.circle),
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.person,
                              color: ThemesStyles.primary,
                              size: 30,
                            )),
                        SizedBox(width: 8),
                        Text(
                          'going 20,000+ ',
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
                            child: Icon(Icons.person_remove,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          'almost Sold Out ',
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
                            child: Icon(Icons.calendar_today,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          'Monday, December 24, 2022',
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
                          '18.00 - 23.00 PM (GMT +07:00)',
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
                            'Grand Park, New York City, US\nGrand City St. 100, New York, United States.',
                            style: TextStyle(
                              fontSize: ThemesStyles.littelFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('See Location on Maps'),
                      ),
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
                            child: Icon(Icons.description,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          'Description:GetMa\nterialController" has been created',
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
                            child: Icon(Icons.price_change,
                                color: ThemesStyles.primary)),
                        SizedBox(width: 8),
                        Text(
                          '\$20.00 - \$100.00',
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
              _showBookingDialog(context);
            },
            // ignore: sort_child_properties_last
            child: const Text(
              ' !Book Now',
              style: TextStyle(
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
            children: [
              Obx(() => DropdownButton<String>(
                    value: eventController.selectedDate.value,
                    onChanged: (String? newValue) {
                      eventController.selectedDate.value = newValue!;
                    },
                    items: eventController.availableDates
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Number of Tickets',
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  eventController.ticketCount.value = int.tryParse(value) ?? 1;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                    'Total Price: \$${eventController.totalPrice}',
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
              onPressed: () {
                // Add booking confirmation logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
