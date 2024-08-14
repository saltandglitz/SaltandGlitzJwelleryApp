import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// <<< To show snackBar massage  --------- >>>
void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  //AppColors appColors = AppColors();
  Get.snackbar(
    "",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: const Color(0xFFD55959),
    titleText: const SizedBox(),
    borderRadius: 10,
    margin: const EdgeInsets.all(12),
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    padding: const EdgeInsets.only(bottom: 15, top: 10, left: 15, right: 15),
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeInOut,
  );
}

/// <<< To show toast massage  --------- >>>
void showToast({required String message, required BuildContext context}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    textColor: Colors.white,
    backgroundColor: Colors.black26,
  );
}
