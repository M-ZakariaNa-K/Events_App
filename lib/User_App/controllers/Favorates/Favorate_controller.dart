import 'package:events_app/User_App/model/get_favorate_mode.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class FavorateController extends GetxController {
  var favoriteItems = <GetFavorateDataModel>[].obs; // Use RxList to observe changes
  var favoriteItemsLoading = true.obs;

  void getFavorateItems() async {
    try {
      favoriteItemsLoading.value = true;
      Map<String, dynamic> data1 = await DioHelper.get(url: "$baseUrl/assets/get-favorites");

      final a = GetFavorateModel.fromJson(data1);
      print(a);
      print(a.data.length);

      favoriteItems.assignAll(a.data);
      print('favoriteItems: ${favoriteItems}');
    } catch (e) {
      print('Error fetching favorite items: $e');
    } finally {
      favoriteItemsLoading.value = false;
    }
  }

  void deleteFavoriteItem(int id) async {
    try {
      await DioHelper.delete(url: "$baseUrl/assets/delete-favorite?id=$id");
      favoriteItems.removeWhere((item) => item.id == id);
    } catch (e) {
      print("Error deleting favorite item: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getFavorateItems();
    // In drawer page I call it
  }

  @override
  void onClose() {
    favoriteItems.value = [];
    favoriteItems.clear();
    super.onClose();
  }
}
