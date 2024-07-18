import 'package:events_app/User_App/model/reservation_filter_model.dart';

import 'package:get/get.dart';

class ReservationFilterController extends GetxController{
     var listReservationFilterItems = <ReservaionFilterDataModel>[].obs;
  var listReservationFilterLoading = true.obs;
// Future<List<ReservaionFilterDataModel>>getFilterData()async{

//     try {
//       listReservationFilterLoading.value = true;
//       Map<String, dynamic> data1 =
//          await DioHelper.get(
//         url:
//             "$baseUrl/assets/get-filters?role=${selectedData["role"]==0?"Organizer":"HallOwner"}&service_id=$sharedServiceId&mixed_service=${selectedData["MixedServices"]}&dinner_service=${selectedData["DinnerServices"]}&region=${selectedData["Region"]}&audiences_number=${selectedData["audiencesNumber"]}&start_time=${selectedData["start_time"]}&end_time=${selectedData["end"]}&min_price=${selectedData["min_price"]}&max_price=${selectedData["max_price"]}",
//       );
//       final a = ListServicesForSecondSlideReservationModel.fromJson(data1);
//       for (int i = 0; i < a.data.length; i++) {
//         listReservationFilterItems.add(a.data[i]);
//       }

//       return listReservationFilterItems;
//     } catch (e) {
//       print('Error fetching recentlyAdded items: $e');
//       return listReservationFilterItems ;
//     } finally {
//       listReservationFilterLoading.value = false;
//     }
// }
}