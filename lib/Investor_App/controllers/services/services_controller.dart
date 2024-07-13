import 'package:events_app/Investor_App/models/lounge_details_model.dart';
import 'package:events_app/Investor_App/models/services_homepage_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class ServicesHomePageController extends GetxController {
  var servicesItems = <ServicesHomepageDataModel>[].obs;
  var servicesDetailsItems = <LoungeDetailsDataModel>[].obs;
  var servicesLoading = true.obs;

  Future<void> getServicesItems() async {
    try {
      servicesLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/list-for-investor");
      final a = ServicesHomepageModel.fromJson(data1);
      for (int i = 0; i < a.data.length; i++) {
        servicesItems.add(a.data[i]);
      }
    } catch (e) {
      print('Error fetching ServicesItems items: $e');
    } finally {
      servicesLoading.value = false;
    }
  }

  Future<void> getServicesDetailsItems({required int id}) async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/get?id=$id");
      final a = LoungeDetailsModel.fromJson(data1);
      // loungeDetailsItems.add(a.data);
      // print('loungeDetailsItems: ${loungeDetailsItems}');
    } catch (e) {
      print('Error fetching loungeDetailsItems items: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getServicesItems();
  }

  @override
  void onClose() {
    servicesItems.clear();
    servicesDetailsItems.clear();
    super.onClose();
  }
}
