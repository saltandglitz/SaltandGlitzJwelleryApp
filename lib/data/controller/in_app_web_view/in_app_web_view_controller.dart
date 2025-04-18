import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class InAppWebViewExtendController extends GetxController {
  RxDouble progress = 0.0.obs;
  String webUrl ="";
  setProgress(int newProgress) {
    progress.value = newProgress / 100;
  }

  InAppWebViewController? _inAppWebViewController;

  setWebViewController(InAppWebViewController controller) {
    _inAppWebViewController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    _inAppWebViewController?.dispose();
  }
}
