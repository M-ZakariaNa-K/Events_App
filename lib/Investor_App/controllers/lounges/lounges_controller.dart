import 'package:events_app/Investor_App/models/lounge_details_model.dart';
import 'package:events_app/Investor_App/models/lounges_model.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class LoungesController extends GetxController {
  var loungesItems = <LoungesDataModel>[].obs;
  var loungeDetailsItems = <LoungeDetailsDataModel>[].obs;

  Future<void> getloungesItems(
      // { required int id}
      ) async {
    try {

      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/assets/list-for-investor");

      final a = LoungesModel.fromJson(data1);
      print(a);
      for (int i = 0; i < a.data.length; i++) {
        loungesItems.add(a.data[i]);
      }
      print('loungesItems: ${loungesItems}');
    } catch (e) {
      print('Error fetching loungesItems items: $e');
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
    await getloungesItems();
  }
}
