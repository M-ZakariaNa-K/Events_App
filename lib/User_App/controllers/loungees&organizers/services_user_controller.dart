import 'package:events_app/User_App/model/services_List_user_model.dart';
import 'package:events_app/User_App/model/services_details_user_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class ServicesUserController extends GetxController {
  var servicesItems = <ServicesListUserDataModel>[].obs;
  var servicesDetailsItems = <ServicesDetailsUserDataModel>[].obs;
  var servicesLoading = true.obs;
  var selectedImagePaths = <String>[].obs;
  Future<void> toggleFavorite(int loungeId) async {
    final loungeIndex =
        servicesItems.indexWhere((lounge) => lounge.id == loungeId);
    if (loungeIndex == -1) return;

    final currentStatus = servicesItems[loungeIndex].isFavorite;
    servicesItems[loungeIndex].isFavorite = !currentStatus;
    servicesItems.refresh();

    try {
      if (!currentStatus) {
        // Add to favorites
        await DioHelper.get(
          url: "$baseUrl/assets/favorite?id=$loungeId",
        );
      } else {
        // Remove from favorites
        await DioHelper.delete(
          url: "$baseUrl/assets/delete-favorite?id=$loungeId",
        );
      }
    } catch (e) {
      // Revert the change in case of an error
      servicesItems[loungeIndex].isFavorite = currentStatus;
      servicesItems.refresh();
      print('Error toggling favorite status: $e');
    }
  }

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

  Future<dynamic> getOrganizersDetailsItems({required int id}) async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/get?id=$id");
      final a = ServicesDetailsUserModel.fromJson(data1);
      servicesDetailsItems.add(a.data);
      print('servicesDetailsItems: ${servicesDetailsItems}');

      return servicesDetailsItems;
    } catch (e) {
      print('Error fetching servicesDetailsItems items: $e');
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
