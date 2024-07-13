import 'package:events_app/User_App/model/ListServicesForSecondSlideReservationModel.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/state_manager.dart';

class ListServicesForSecondSlideReservationController extends GetxController{
   var listServicesItems = <ListServicesForSecondSlideReservationDataModel>[].obs;
  var listServicesLoading = true.obs;

  Future<List<ListServicesForSecondSlideReservationDataModel>> getListServicesItems({required String kind}) async {
    try {
      listServicesLoading.value = true;
      Map<String, dynamic> data1 =
          await DioHelper.get(url: "$baseUrl/service/list?identifier=$kind");

      final a = ListServicesForSecondSlideReservationModel.fromJson(data1);
      for (int i = 0; i < a.data.length; i++) {
        listServicesItems.add(a.data[i]);
      }

      return listServicesItems;
    } catch (e) {
      print('Error fetching recentlyAdded items: $e');
      return listServicesItems ;
    } finally {
      listServicesLoading.value = false;
    }
  }

} 