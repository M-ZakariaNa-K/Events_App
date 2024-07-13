import 'package:events_app/User_App/model/get_favorate_mode.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class FavorateController extends GetxController {
  var favoriteItems =
      <GetFavorateDataModel>[].obs; // Use RxList to observe changes
  var favoriteItemsLoading = true.obs;

  void getFavorateItems() async {
    try {
      favoriteItemsLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/get-favorites");

      final a = GetFavorateModel.fromJson(data1);
      print(a);
      print(a.data.length);

      for (int i = 0; i < a.data.length; i++) {
        favoriteItems.add(a.data[i]);
      }
      print('favoriteItems: ${favoriteItems}');
    } catch (e) {
      print('Error fetching favorite items: $e');
    } finally {
      favoriteItemsLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFavorateItems();
  }

  @override
  void onClose() {
    favoriteItems.value = [];
    favoriteItems.clear();
    super.onClose();
  }
}
