import 'package:events_app/User_App/model/profile_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class DrawerPageController extends GetxController {
  var currentIndexBottom = 0.obs;
  var currentIndexDrawer = 0.obs;
    var profileItems = <ProfileDataModel>[].obs;
  var profileItemsLoading = true.obs;

  void changeTabIndex(int index) {
    currentIndexBottom.value = index;
    currentIndexDrawer.value =
        0; // Update the drawer index as well (When i pressed Home in bottom and drawer)
  }

  void changeDrawerTabIndex(int index) {
    currentIndexDrawer.value = index;
  }
  Future<void> getProfileItems() async {
    try {
      profileItemsLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/profile/get");

      final a = ProfileModel.fromJson(data1);
      print(a);
      profileItems.add(a.data);
    } catch (e) {
      print('Error fetching Profile items: $e');
    } finally {
      profileItemsLoading.value = false;
    }
  }
}
