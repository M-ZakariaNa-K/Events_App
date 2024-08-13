import 'package:events_app/User_App/model/search_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController {
  final TextEditingController searchControllerTextFild =
      TextEditingController();
  var searchItems = <SearchDataModel>[].obs;
  var searchLoading = false.obs;

  Future<void> getSearchItems({
    required String identifier,
    required String value,
  }) async {
    try {
      searchLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(
          url:
              "$baseUrl/assets/search-user?identifier=$identifier&value=$value");

      print(data1);
      final a = SearchModel.fromJson(data1);
      print(a);
      print(a.data.length);
      searchItems.assignAll(a.data);
      // for (int i = 0; i < a.data.length; i++) {
      //   searchItems.add(a.data[i]);
      // }
    } catch (e) {
      print('Error fetching loungesItems items: $e');
    } finally {
      searchLoading.value = false;
    }
  }
}
