
import 'package:get/get.dart';

class RadioController extends GetxController {
  RxInt selectedValue = 0.obs; // Observe changes to the selected value

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }
    int? getSelectedValue() {
    return selectedValue.value;
  }

  // RxString selectedEventKindValue = ''.obs; // Observe changes to the selected value

  // void setEventKindSelectedValue(int value) {
  //   selectedValue.value = value;
  // }
  //   String? getEventKindSelectedValue() {
  //   return selectedEventKindValue.value;
  // }
}