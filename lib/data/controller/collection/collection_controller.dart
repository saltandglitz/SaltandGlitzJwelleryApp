import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/add_to_cart/add_to_cart_controller.dart';
import 'package:saltandGlitz/data/controller/wishlist/wishlist_controller.dart';
import 'package:saltandGlitz/data/product/product_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/app_const.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../local_storage/sqflite_local_storage.dart';
import '../../model/create_wishlist_view_model.dart';

class CollectionController extends GetxController {
  var currentIndex = (-1).obs;
  var favoriteStatus = <bool>[];
  RxBool isEnableNetwork = false.obs;
  RxBool isShowCategories = false.obs;
  RxBool isShowSearchField = false.obs;
  RxBool isMoveWishlist = false.obs;
  Wishlist? isWishlist;

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
      String image, String name, String totalCost, String productId) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnImage: image,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnTotalCost: totalCost,
      DatabaseHelper.productId: productId,
    };

    final dbHelper = DatabaseHelper.instance;

    // Check if the product already exists
    List<Map<String, dynamic>> existingProducts =
        await dbHelper.queryRowsByName(
      image: image,
      name: name,
      totalCost: totalCost,
      productIdData: productId,
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
  Future favoritesProducts(
      {String? userId,
      String? productId,
      int? index,
      int? size,
      String? carat,
      String? color,
      String? isMoveWishlistText}) async {
    try {
      isMoveWishlist.value = true;
      final addProductController =
          Get.put<AddToCartController>(AddToCartController());
      final wishlistController =
          Get.put<WishlistController>(WishlistController());
      final productController = Get.put<ProductController>(ProductController());
      // Get userId from PrefManager
      String currentUserId = PrefManager.getString('userId') ?? '';
      // If the user is logged in, currentUserId will be a valid userId
      // If the user is a guest, currentUserId will be an empty string.
      Map<String, dynamic> params =
          currentUserId == null || currentUserId.trim().isEmpty
              ? {
                  "productId": productId,
                }
              : {
                  "userId": currentUserId, // Send the trimmed userId
                  "productId": productId,
                };
      print("Wishlist params: '$params'");
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.wishlistProductApi,
        context: Get.context!,
        params: params,
        isLoading: false,
      );

      if (response.statusCode == 201) {
        isWishlist = Wishlist.fromJson(response.data['wishlist']);
        PrefManager.setString('userId', isWishlist?.userId ?? '');
        // PrefManager.addWishlistProductToList('wishlistProductId', '$productId');
        PrefManager.addCartAndWishlistProductToList(
            'wishlistProductId', '$productId', "${size ?? 6}", carat!, color!);
        // PrefManager.addProductToList('wishlistProductId', '$productId');
        List<String>? wishlistData =
            PrefManager.getStringList('wishlistProductId');
        print("Stored Data wishlist : ${wishlistData?.toList()}");
        //Todo : isMoveWishlistText == LocalStrings.moveWishlist this time remove cart item and add wishlist
        if (isMoveWishlistText == LocalStrings.moveWishlist) {
          //Todo : Remove product to the cart api method & removeProduct remove locally
          addProductController.removeCartApiMethod(itemId: productId);
          addProductController.removeProduct(index!);
          wishlistController.getWishlistDataApiMethod();
          Get.back();
        } else {
          filterProductData[index!].isAlready = true;
          productController.productData.isAlready = true;
        }
      } else {
        showSnackBar(context: Get.context!, message: response.data['message']);
      }
    } catch (e) {
      print("Favorites Products error  : $e");
    } finally {
      isMoveWishlist.value = false;
      update();
    }
  }

//Todo : Remove wishlist particular product
  Future removeWishlistApiMethod({String? productId}) async {
    try {
      String? userId = PrefManager.getString('userId');
      String apiName =
          "${LocalStrings.removeWishlistProductApi}$userId/$productId";
      Response response = await APIFunction().delete(
          apiName: apiName,
          context: Get.context!,
          token: PrefManager.getString('token') ?? '',
          isLoading: false);

      if (response.statusCode == 200) {
        // PrefManager.removeCartWishlistListItem('wishlistProductId', '$productId');
        PrefManager.removeCartWishlistListItem(
            'wishlistProductId', '$productId');
        // PrefManager.removeListItem('wishlistProductId', '$productId');
        List<String>? wishlistData =
            PrefManager.getStringList('wishlistProductId');
        print("Stored Data wishlist remove: ${wishlistData?.toList()}");
      }
    } catch (e) {
      print("Remove Wishlist : $e");
    }
  }
}
