import 'package:events_app/common/core/shared/shared.dart';
import 'package:events_app/common/helper/api.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  Future<void> postOtpNumber() async {
    Map<String, dynamic> data = await DioHelper.post(
      body: {"email": "zakariana2003@gmail.com"},
      url: '$baseUrl/auth/forget-password',
    );
  }
}
