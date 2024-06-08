import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  bool isEmailValid = true;
  var statusCode = 0.obs;
  var isLoading = false.obs;
  String email = "";
  String? otpNumber1 = "";
  String? otpNumber2 = "";
  String? otpNumber3 = "";
  String? otpNumber4 = "";

  final _dio = Dio();
  
  Future<void> post({
    required String url,
    required dynamic body,
    required String theEmail,
  }) async {
    isLoading.value = true; // Start loading
    try {
      final headers = <String, dynamic>{
        'Accept': 'application/json',
      };

      final response = await _dio.post(url, data: body, options: Options(headers: headers));
      print(response.data);
      print('Request body: $body');
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        email = theEmail;
        statusCode.value = 200;
      } else {
        statusCode.value = response.statusCode ?? 0;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  //====================================================OTP PAGE=============================================
  String maskEmailOtp(String email) {
    int visibleChars = 6; // Number of characters to keep visible
    int index = email.indexOf('@');
    if (index <= visibleChars) return email; // Not enough characters to mask
    String maskedPart = '*' * (index - visibleChars);
    return email.substring(0, visibleChars) + maskedPart + email.substring(index);
  }
}
