import 'package:get/get.dart';

class DrawerPageController extends GetxController {
  var currentIndexBottom = 0.obs;
  var currentIndexDrawer = 0.obs;

  void changeTabIndex(int index) {
    currentIndexBottom.value = index;
    currentIndexDrawer.value =
        0; // Update the drawer index as well (When i pressed Home in bottom and drawer)
  }

  void changeDrawerTabIndex(int index) {
    currentIndexDrawer.value = index;
  }
}
