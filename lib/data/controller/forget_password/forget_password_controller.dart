import 'dart:async';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  var isTextEnabled = true.obs;
  var remainingTime = 60.obs;
  Timer? timer;

  void startTimer() {
    isTextEnabled.value = false;
    remainingTime.value = 60;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          isTextEnabled.value = true;
        }
      },
    );
    update();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
