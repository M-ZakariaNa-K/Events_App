import 'package:events_app/Investor_App/models/lounge_details_model.dart';
import 'package:events_app/User_App/model/lounges_List_user_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class LoungesUserController extends GetxController {
  var loungesItems = <LoungesListUserDataModel>[].obs;
  var loungeDetailsItems = <LoungeDetailsDataModel>[].obs;
  var loangesLoading = true.obs;

  Future<void> getloungesItems({
    required String identifier,
    int? service_id,
    required String role,
  }) async {
    try {
      loangesLoading.value = true;
      Map<String, dynamic> data1 = service_id != null
          ? await DioHelper.get(
              url:
                  "$baseUrl/assets/list?service_id=$service_id&role=$role&identifier=$identifier")
          : await DioHelper.get(
              url: "$baseUrl/assets/list?&role=$role&identifier=$identifier");
      print(data1);
      final a = LoungesListUserModel.fromJson(data1);
      print(a);
      print(a.data.length);

      for (int i = 0; i < a.data.length; i++) {
        loungesItems.add(a.data[i]);
      }
      print('loungesItems: ${loungesItems}');
    } catch (e) {
      print('Error fetching loungesItems items: $e');
    } finally {
      loangesLoading.value = false;
    }
  }

  Future<void> getloungeDetailsItems({required int id}) async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/get?id=$id");
      final a = LoungeDetailsModel.fromJson(data1);
      loungeDetailsItems.add(a.data);
      print('loungeDetailsItems: ${loungeDetailsItems}');
    } catch (e) {
      print('Error fetching loungeDetailsItems items: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // await getloungesItems();
  }

  @override
  void onClose() {
    loungesItems.clear();
    super.onClose();
  }
}
