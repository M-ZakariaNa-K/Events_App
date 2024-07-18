import 'package:events_app/User_App/model/offers_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class OffersController extends GetxController {
  var offersItems =
      <ShowOffersDataModel>[].obs; // Use RxList to observe changes
  var offersLoading = true.obs;
  void getOffersItems() async {
    try {
      offersLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/discounts/list");
      final showOffersListModel = ShowOffersModel.fromJson(data1);
      offersItems
          .assignAll(showOffersListModel.data); // Use assignAll for RxList
    } catch (e) {
      print('Error fetching Offers items: $e');
    } finally {
      offersLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOffersItems();
  }
}
