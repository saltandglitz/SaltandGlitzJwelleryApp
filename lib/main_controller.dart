import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/view/components/common_message_show.dart';

import 'api_repository/api_function.dart';
import 'core/route/route.dart';
import 'core/utils/app_const.dart';
import 'core/utils/local_strings.dart';
import 'data/controller/dashboard/dashboard_controller.dart';

class MainController extends GetxController {
  /// Whole app analysis instance
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  RxBool? isNetworkConnection;
  final dashboardController = Get.put(DashboardController());
  Image? splashStarImage;
  Image? splashRingImage;

//Todo : Check network connection available or not if not then return false
  Future<RxBool> networkConnectivityChecked() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      printAction("Connection_Available");
      return true.obs;
    } else {
      printAction("Connection_Not_Available");
      return false.obs;
    }
  }

//Todo : First check network available or not this based assign Boolean to isNetworkConnection variable
  Future<RxBool?> checkToAssignNetworkConnections() async {
    isNetworkConnection = await networkConnectivityChecked();
    if (isNetworkConnection?.value == false) {
      showToast(message: LocalStrings.enableInternet, context: Get.context!);
    }
    printAction("Connection : $isNetworkConnection");
    update();
    return isNetworkConnection;
  }

  //Todo : Get banner data using this api method
  getBannerApiMethod() async {
    try {
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.getBannerApi,
          context: Get.context!,
          isGet: true,
          isLoading: false);

      // Handling the 'banners' data
      if (response.statusCode == 200) {
        advertiseBanner.addAll(response.data['banners'] ?? []);
      } else {
        printError(
            "Failed to load banners. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      printError('Get_Banner_Issue: $e');
    } finally {
      update();
    }
  }

//Todo : Splash screen initial after 3 seconds move dashboard screen
  splashScreenNavigation() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.toNamed(RouteHelper.bottomBarScreen);
    });
  }
}
