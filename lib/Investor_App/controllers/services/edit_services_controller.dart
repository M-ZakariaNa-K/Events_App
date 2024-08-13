import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class EditServicesController extends GetxController{
    var addedList = <Map<String, dynamic>>[].obs;

    Future<void> postEditedServiceDetailsItems(
      {required Map<String, dynamic> body}) async {
    try {
      Map<String, dynamic> data1 =
          await DioHelper.post(url: "$baseUrl/assets/update-service", body: body);
      if (data1["code"] == 200) {
        Get.snackbar('Success', 'Edited successful',
            snackPosition: SnackPosition.TOP);

      }
    } catch (e) {
      print('Error fetching loungeDetailsItems items: $e');
    }
  }
}