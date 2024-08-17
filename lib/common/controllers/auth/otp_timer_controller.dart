import 'dart:async';
import 'package:events_app/common/controllers/auth/forget_password_controller.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  var start = '1:00'.obs; // Duration in seconds
  bool isTimerEnd = false;
  Timer? timer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    int secondsLeft = 60; // Initial timer duration in seconds
    timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (secondsLeft == -1) {
          timer.cancel();
          // Send request or perform action here after timer ends
          final forgetPasswordController = Get.put(ForgetPasswordController());
          final response = await forgetPasswordController.post(
            theEmail: createPasswordEmail,
            body: {"email": createPasswordEmail},
            url: '$baseUrl/auth/forget-password',
          );

          if (forgetPasswordController.statusCode.value == 200) {
            Get.snackbar(
              'Cool',
              'Check your masseging box',
            );
          } else {
            Get.snackbar(
              'Warning',
              'Somthing went wrong...',
            );
          }
          print('Timer ended');
        } else {
          // Convert seconds to "mm:ss" format
          int minutes = secondsLeft ~/ 60;
          int seconds = secondsLeft % 60;
          start.value = '$minutes:${seconds.toString().padLeft(2, '0')}';
          secondsLeft--;
        }
      },
    );
  }

  @override
  void onClose() {
    timer?.cancel();
    isTimerEnd = true;
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
