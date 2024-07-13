import 'package:events_app/User_App/controllers/booking/ListServicesForSecondSlideReservationController.dart';
import 'package:events_app/User_App/controllers/booking/radio_controller.dart';
import 'package:events_app/User_App/model/ListServicesForSecondSlideReservationModel.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/fifth_onBoarding_booking.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/fourth_onBoarding_booking.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/sixth_onBoarding_booking.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/third_onBoarding_booking.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/first_onBoarding_booking.dart';
import 'package:events_app/User_App/view/booking/onBoardingPages/second_onBoarding_booking%20copy.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainBookingPage extends StatefulWidget {
  MainBookingPage({super.key});

  @override
  State<MainBookingPage> createState() => _MainBookingPageState();
}

class _MainBookingPageState extends State<MainBookingPage> {
  final PageController _controller = PageController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();

  final TextEditingController _startPriceController = TextEditingController();

  final TextEditingController _endPriceController = TextEditingController();

  final RadioController _eventKindController =
      Get.put(RadioController(), tag: 'EventKind');
  final RadioController _roleController =
      Get.put(RadioController(), tag: 'role');
  String? selectedTime;

  String? selectedEventCatigory;

  Map<String, dynamic> selectedData = {};

  List<ListServicesForSecondSlideReservationDataModel>
      listOfServicesSecondSlide = [];

  // Method to save the selected data
  void saveData(BuildContext context) {
    final RadioController _eventKindController = Get.find(tag: 'EventKind');
    final RadioController _mixedController = Get.find(tag: 'MixedServices');
    final RadioController _dinnerController = Get.find(tag: 'DinnerServices');

    selectedData = {
      //====================================================
      //0 -> public , 1 -> privte
      'serviceId': sharedServiceId,
      'EventKind': _eventKindController.getSelectedValue(),
      'role': _roleController.getSelectedValue(),
      //====================================================
      'MixedServices': _mixedController.getSelectedValue(),
      'DinnerServices': _dinnerController.getSelectedValue(),
      'Region': _regionController.text,
      'audiencesNumber': _numberController.text,
      'SelectedTime': selectedTime,
      'EventCatigory': selectedEventCatigory,
      'min_price': _startPriceController.text,
      'max_price': _endPriceController.text,
      "start_time": "$starthourShared:$startminuteShared:00",
      "end_time": "$endhourShared:$endminuteShared:00",
    };
// Check if the current page is the third slide (index 2)
    if (_controller.page == 2) {
      // Get the selected time from the ThirdOnBoardingBooking page
      final Map<String, dynamic>? thirdPageData =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (thirdPageData != null) {
        selectedData['SelectedTime'] = thirdPageData['SelectedTime'];
      }
    }
    print('Saved Data: $selectedData');
    // You can now use the selectedData as needed, e.g., send to backend, save locally, etc.
  }

  void nextPage(BuildContext context) async {
    if (_controller.page == 5) {
      // If on the sixth slide, save data
      saveData(context);
      // Response response = await DioHelper.get(
      //   url:
      //       "$baseUrl/assets/get-filters?role=${selectedData["role"]==0?"Organizer":"HallOwner"}&service_id=$sharedServiceId&mixed_service=${selectedData["MixedServices"]}&dinner_service=${selectedData["DinnerServices"]}&region=${selectedData["Region"]}&audiences_number=${selectedData["audiencesNumber"]}&start_time=${selectedData["start_time"]}&end_time=${selectedData["end"]}&min_price=${selectedData["min_price"]}&max_price=${selectedData["max_price"]}",
      // );
      starthourShared = 0;
      startminuteShared = 0;
      endhourShared = 0;
      endminuteShared = 0;
      // Get.to(DrawerPage());
    } else {
      //Here i will sent a request of data of the second slide
      if (_controller.page == 0) {
        final servicesController =
            ListServicesForSecondSlideReservationController();

        listOfServicesSecondSlide =
            await servicesController.getListServicesItems(
          kind: _eventKindController.getSelectedValue() == 0
              ? "public"
              : "private",
        );
        setState(() {});
      }
      // Check if the current page is the fifth or second slide and validate the form
      if (_controller.page == 4 || _controller.page == 1) {
        if (_formKey.currentState!.validate()) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      } else {
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //=====================First slide================
                  FirstOnBoardingBooking(),
                  FourthOnBoardingBooking(
                    onCategorySelected: (category) {
                      selectedEventCatigory =
                          category; // Store the selected time
                    },
                    listOfServicesSecondSlide: listOfServicesSecondSlide,
                  ),
                  //=====================Second slide================
                  SecondOnBoardingBooking(
                    reagionController: _regionController,
                  ),
                  //=====================Third slide================
                  ThirdOnBoardingBooking(onTimeSelected: (time) {
                    selectedTime = time; // Store the selected time
                  }),
                  //=====================Fourth slide================
                  //=====================Fifth slide================
                  FifthOnBoardingBooking(
                    numberController: _numberController,
                  ),
                  //=====================Sixth slide================
                  SixthOnBoardingBooking(
                    startPriceController: _startPriceController,
                    endPriceController: _endPriceController,
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the previous page
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text("BACK"),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 6,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: ThemesStyles.primary,
                      dotColor: Color(0xff45444B),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      nextPage(context);
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                        color: ThemesStyles.primary,
                        fontSize: ThemesStyles.mainFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
