import 'package:events_app/User_App/model/services_List_user_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class ServicesUserController extends GetxController {
  var servicesItems = <ServicesListUserDataModel>[].obs;
  var servicesLoading = true.obs;

  Future<void> getServicesItems({
    required String identifier,
    int? service_id,
    required String role,
  }) async {
    try {
      servicesLoading.value = true;
      Map<String, dynamic> data1 = service_id != null
          ? await DioHelper.get(
              url:
                  "$baseUrl/assets/list?service_id=$service_id&role=$role&identifier=$identifier")
          : await DioHelper.get(
              url: "$baseUrl/assets/list?&role=$role&identifier=$identifier");
      final a = ServicesListUserModel.fromJson(data1);
      for (int i = 0; i < a.data.length; i++) {
        servicesItems.add(a.data[i]);
      }
    } catch (e) {
      print('Error fetching ServicesItems items: $e');
    } finally {
      servicesLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // await getServicesItems();
  }

  @override
  void onClose() {
    servicesItems.clear();
    super.onClose();
  }
}
