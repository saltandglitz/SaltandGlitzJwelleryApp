import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// <<< To show snackBar massage  --------- >>>
void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required IconData icon,
  required Color iconColor,
}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(icon, color: iconColor),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.black12,
    colorText: Colors.black,
    duration: const Duration(seconds: 3),
    isDismissible: true,
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

/// <<< Error Massage Red color --------- >>>
void printActionError(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[91m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}

/// <<< Action Massage Blue Color --------- >>>
void printAction(String text) {
  if (Platform.isAndroid) {
    debugPrint('\x1B[94m$text\x1B[0m');
  } else {
    debugPrint(text);
  }
}
