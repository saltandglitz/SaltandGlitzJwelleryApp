import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/local_storage/pref_manager.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import 'api_repository/api_function.dart';
import 'core/route/route.dart';
import 'core/utils/app_const.dart';
import 'core/utils/local_strings.dart';
import 'data/controller/dashboard/dashboard_controller.dart';
import 'data/model/home_view_model.dart';

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

Future getDashboardJewelleryData() async{
  try {
    Response response = await APIFunction().apiCall(
      apiName: LocalStrings.getHomeViewApi,
      context: Get.context,
      isGet: true,
      isLoading: false,
    );
    if (response.statusCode == 200) {
      bannerList = (response.data['bottomBanner'] as List)
          .map((banner) => BottomBanner.fromJson(banner))
          .toList();
      categoryList = (response.data['categoryImage'] as List)
          .map((category) => CategoryImage.fromJson(category))
          .toList();
      filterCategoryList = (response.data['filterCategory'] as List)
          .map((filterCategory) => FilterCategory.fromJson(filterCategory))
          .toList();
      newArrivalList = (response.data['newArrivals'] as List)
          .map((newArrivals) => NewArrivals.fromJson(newArrivals))
          .toList();
      giftElementList = (response.data['gifts'] as List)
          .map((gifts) => Gifts.fromJson(gifts))
          .toList();
    } else {
      print("Something went wrong Home : ${response.data['message']}");
    }
  } catch (e) {
    print("Get Banner Error : $e");
  }
}
  //Todo : Get banner data using this api method
  // getBannerData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       bannerList = (response.data['banner'] as List)
  //           .map((banner) => Banner.fromJson(banner))
  //           .toList();
  //
  //       // log("Banner List Length:${bannerList.length} ");
  //       // log("Banner List :${bannerList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get Banner Error : $e");
  //   }
  // }

  //Todo : Get category data using this api method
  // getCategoryData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       categoryList = (response.data['category'] as List)
  //           .map((category) => Category.fromJson(category))
  //           .toList();
  //
  //       // log("Category List Length:${categoryList.length} ");
  //       // log("Category List :${categoryList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get Banner Error : $e");
  //   }
  // }

  //Todo : Get new arrival data using this api method
  // getNewArrivalData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       newArrivalList = (response.data['newArrivals'] as List)
  //           .map((newArrivals) => NewArrival.fromJson(newArrivals))
  //           .toList();
  //       // log("NewArrival List Length:${newArrivalList.length} ");
  //       // log("NewArrival List :${newArrivalList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get NewArrival Error : $e");
  //   }
  // }

  //Todo : Get gift element data using this api method
  // getGiftElementData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       giftElementList = (response.data['gifts'] as List)
  //           .map((gifts) => GiftElement.fromJson(gifts))
  //           .toList();
  //
  //       // log("Gift List Length:${giftElementList.length} ");
  //       // log("Gift List :${giftElementList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get NewArrival Error : $e");
  //   }
  // }

  //Todo : Get solitaire data using this api method
  // getSolitaireData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       log("Get Home :${response.data} ");
  //       solitaireList = (response.data['solitire'] as List)
  //           .map((solitire) => Solitire.fromJson(solitire))
  //           .toList();
  //       // log("NewArrival List Length:${newArrivalList.length} ");
  //       // log("NewArrival List :${newArrivalList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get NewArrival Error : $e");
  //   }
  // }

  //Todo : Get filter category data using this api method
  // getFilterCategoryData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       filterCategoryList = (response.data['filterCategory'] as List)
  //           .map((filterCategory) => FilterCategory.fromJson(filterCategory))
  //           .toList();
  //       // log("filterCategory List Length:${filterCategoryList.length} ");
  //       // log("filterCategory List :${filterCategoryList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get FilterCategory Error : $e");
  //   }
  // }

  //Todo : Get banner data using this api method
  // getBottomBannerData() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.getHomeViewApi,
  //       context: Get.context,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //     if (response.statusCode == 200) {
  //       bottomBannerList = (response.data['bottomBanner'] as List)
  //           .map((bottomBanner) => BottomBanner.fromJson(bottomBanner))
  //           .toList();
  //
  //       // log("Banner List Length:${bannerList.length} ");
  //       // log("Banner List :${bannerList} ");
  //       // log("Get Home :${response.data} ");
  //     } else {
  //       print("Something went wrong Home : ${response.data['message']}");
  //     }
  //   } catch (e) {
  //     print("Get Banner Error : $e");
  //   }
  // }

  splashScreenNavigation() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.toNamed(RouteHelper.bottomBarScreen);
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Token : ${PrefManager.getString('token')}");
  }
}
