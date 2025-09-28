import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart' hide Response;
import 'package:saltandglitz/local_storage/pref_manager.dart';
import 'package:saltandglitz/view/components/common_message_show.dart';

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
  RxString selectedCategory = 'Ring'.obs;
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

// Method to change selected category
  void changeCategory(String category) {
    selectedCategory.value = category;
    update(); // to refresh UI widgets using GetBuilder
  }

  Future getDashboardJewelleryData() async {
    try {
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.getHomeViewApi,
        context: Get.context,
        isGet: true,
        isLoading: false,
      );
      print("Get Home :${response.statusCode} ");
      if (response.statusCode == 200) {
        bottomBannerList = (response.data['bottomBanner'] as List)
            .map((banner) => BottomBanner.fromJson(banner))
            .toList();
        print("Get Home 1:${response.statusCode} ");

        categoryList = (response.data['categoryImage'] as List)
            .map((category) => CategoryImage.fromJson(category))
            .toList();
        print("Get Home 2:${response.statusCode} ");

        filterCategoryList = (response.data['filterCategory'] as List)
            .map((filterCategory) => FilterCategory.fromJson(filterCategory))
            .toList();
        print("Get Home 3:${response.statusCode} ");

        newArrivalList = (response.data['newArrivals'] as List)
            .map((newArrivals) => NewArrivals.fromJson(newArrivals))
            .toList();
        print("Get Home 4:${response.statusCode} ");

        giftElementList = (response.data['gifts'] as List)
            .map((gifts) => Gifts.fromJson(gifts))
            .toList();
        print("Get Home 5:${response.statusCode} ");

        mediaList = (response.data['media'] as List)
            .whereType<Map<String, dynamic>>()
            .where((media) => media['mobileBannerImage'] != null)
            .map((media) => Media.fromJson(media))
            .toList();
        print("RAW MEDIA RESPONSE: ${response.data['media']}");
        print("MEDIA LIST : ${mediaList.length}");
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

  //Todo : Fetch firebase to whole app strings
  Future<void> fetchStringFirebaseData() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .refFromURL('https://saltand-glitz-default-rtdb.firebaseio.com/');

    // Fetch the data
    try {
      final snapshot = await databaseReference.get();
      print("Firebase Snapshot: $snapshot"); // Print snapshot to debug
      print("Snapshot Value: ${snapshot.value}");
      if (snapshot.exists) {
        // Successfully found data, now store it in the appStrings map
        appStrings = Map<String, dynamic>.from(snapshot.value as Map);
        print("Fetched data: ${appStrings['appName']}");
      } else {
        // No data found at the 'app_strings' path
        throw Exception('No data found in Firebase Database');
      }
    } catch (e) {
      // Catch any errors that happen during the fetch
      print('Error fetching data from Firebase: $e');
      throw Exception('Error fetching data from Firebase: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Token : ${PrefManager.getString('token')}");
  }
}
