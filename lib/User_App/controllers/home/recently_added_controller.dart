import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import 'package:events_app/User_App/model/resently_added_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';

class RecentlyAddedController extends GetxController {
  var resntlyAddedItems = <RecentlyAddedDataModel>[].obs;
  var recentlyAddedLoading = true.obs;
  final bool isOrganizer;
  RecentlyAddedController({
    required this.isOrganizer,

  });
  Future<List<RecentlyAddedDataModel>> getRecentlyAddedItems({required String role}) async {
    try {
      recentlyAddedLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/recent?role=$role");

      final a = RecentlyAddedModel.fromJson(data1);
      print(a);
      print(a.data.length);

      for (int i = 0; i < a.data.length; i++) {
        resntlyAddedItems.add(a.data[i]);
      }
      print('resntlyAddedItems: ${resntlyAddedItems}');
      return resntlyAddedItems;
    } catch (e) {
      print('Error fetching recentlyAdded items: $e');
      return resntlyAddedItems ;
    } finally {
      recentlyAddedLoading.value = false;
    }
  }

  @override
  void onInit()

   {
    // TODO: implement onInit
    super.onInit();
    // isOrganizer
    //     ? getRecentlyAddedItems(role: "Organizer")
    //     : getRecentlyAddedItems(role: "HallOwner");
  }

}
