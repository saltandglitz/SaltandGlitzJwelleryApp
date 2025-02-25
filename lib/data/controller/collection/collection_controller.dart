import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/app_const.dart';
import '../../../local_storage/sqflite_local_storage.dart';

class CollectionController extends GetxController {
  var currentIndex = (-1).obs;
  var favoriteStatus = <bool>[];
  RxBool isEnableNetwork = false.obs;
  RxBool isShowCategories = false.obs;
  RxBool isShowSearchField = false.obs;

  // Sort collection data
  List sortProductsLst = [
    LocalStrings.latest,
    LocalStrings.featured,
    LocalStrings.priceLow,
    LocalStrings.priceHigh,
  ];

  // Collection image
  List collectionDataImageLst = [
    MyImages.ringOneImage,
    MyImages.ringSecondImage,
    MyImages.ringThirdImage,
    MyImages.ringForImage,
    MyImages.ringFiveImage,
    MyImages.ringOneImage,
    MyImages.ringThirdImage,
    MyImages.ringSecondImage,
  ];

  // Collection item name
  List collectionDataNameLst = [
    LocalStrings.goldenRing,
    LocalStrings.diamondRingFirst,
    LocalStrings.diamondRingSecond,
    LocalStrings.stoneRing,
    LocalStrings.stoneDiamondRing,
    LocalStrings.goldenRing,
    LocalStrings.diamondRingSecond,
    LocalStrings.diamondRingFirst,
  ];

  // Collection item cutoff price
  List collectionCutOffPrice = [
    LocalStrings.priceProductItemFirst,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFive,
    LocalStrings.priceProductItemSeven,
    LocalStrings.priceProductItemNine,
    LocalStrings.priceProductItemEleven,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFirst,
  ];

// Collection item total price

  List collectionTotalPrice = [
    LocalStrings.priceProductItemSecond,
    LocalStrings.priceProductItemFor,
    LocalStrings.priceProductItemSix,
    LocalStrings.priceProductItemEight,
    LocalStrings.priceProductItemTen,
    LocalStrings.priceProductItemTwelve,
    LocalStrings.priceProductItemFor,
    LocalStrings.priceProductItemSecond,
  ];

  //Collection rating lst
  List collectionRatingLst = [
    LocalStrings.ratingFirst,
    LocalStrings.ratingSecond,
    LocalStrings.ratingThird,
    LocalStrings.ratingFor,
    LocalStrings.ratingFive,
    LocalStrings.ratingSix,
    LocalStrings.ratingFirst,
    LocalStrings.ratingSecond,
  ];

  //Collection post update lst
  List collectionPostUpdateLst = [
    LocalStrings.latestText,
    LocalStrings.bestSeller,
    LocalStrings.blankText,
    LocalStrings.bestSeller,
    LocalStrings.latestText,
    LocalStrings.bestSeller,
    LocalStrings.blankText,
    LocalStrings.bestSeller,
  ];

  // Initialize with a default value (e.g., false for all items)
  @override
  void onInit() {
    super.onInit();
    favoriteStatus = List.generate(filterProductData.length, (_) => false);
  }

  enableNetworkHideLoader() {
    if (isEnableNetwork.value == false) {
      isEnableNetwork.value = true;
    }
    update();
  }

  disableNetworkLoaderByDefault() {
    if (isEnableNetwork.value == true) {
      isEnableNetwork.value = false;
    }
    update();
  }
//Todo : Hide search field to appbar search icon
  hideSearchField() {
    isShowSearchField.value = false;
    update();
  }

  /// Products Favorites & UnFavorites set
  void toggleFavorite(int index) {
    favoriteStatus[index] = !favoriteStatus[index];
    if (favoriteStatus[index] == false) {
      /// If products users favorites set then work this analysis
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logCollectionProductUnFavorite,
          productName: collectionDataNameLst[index],
          productImage: collectionDataImageLst[index],
          index: 5);
    } else {
      /// If products users UnFavorites set then work this analysis
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logCollectionProductFavorite,
          productName: collectionDataNameLst[index],
          productImage: collectionDataImageLst[index],
          index: 5);
    }
    update(); // Notify listeners
  }

  bool isFavorite(int index) {
    return favoriteStatus[index];
  }

  // Sort selecting item
  sortCurrentIndex(int index) {
    currentIndex.value = index;

    if (currentIndex.value == index) {
      // sortProductsLst[index];
      AppAnalytics().actionTriggerWithProductsLogs(
        eventName: LocalStrings.logCollectionSortProduct,
        productFilter: sortProductsLst[index],
      );
    }
    update();
  }

  /// Sqlite database using recently stored products
  void addProduct(
      String image, String name, String totalCost, String cutoffCost) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnTotalCost: totalCost,
      DatabaseHelper.columnCutoffCost: cutoffCost,
    };

    final dbHelper = DatabaseHelper.instance;

    // Check if the product already exists
    List<Map<String, dynamic>> existingProducts =
        await dbHelper.queryRowsByName(
      image: image,
      name: name,
      totalCost: totalCost,
      cutoffCost: cutoffCost,
    );

    if (existingProducts.isNotEmpty) {
      // Update the existing product
      row[DatabaseHelper.columnId] =
          existingProducts.first[DatabaseHelper.columnId];
      await dbHelper.update(row);
    } else {
      // Insert the new product
      await dbHelper.insert(row);
    }
    update();
  }

  //Todo : Favorites products api method
  Future favoritesProducts({String? userId, String? productId}) async {
    try {
      Map<String, dynamic> params = {
        'userId': userId,
        'productId': productId,
      };
      print("Wishlist Users : $params ");
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.wishlistProductApi,
        context: Get.context!,
        params: params,
        isLoading: false,
      );
      if (response.statusCode == 201) {
        print("Wishlist products  :${response.data['message']}");
      } else {
        showSnackBar(context: Get.context!, message: response.data['message']);
      }
    } catch (e) {
      print("Favorites Products error  : $e");
    }
  }
}
