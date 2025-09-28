import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandglitz/api_repository/api_function.dart';
import 'package:saltandglitz/data/model/get_wishlist_view_model.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';

import '../../../core/utils/app_const.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';

class WishlistController extends GetxController {
  RxBool isEnableNetwork = false.obs;
  RxBool isWishlistProduct = false.obs;
  List<WishlistProducts> wishlistProducts = [];
  List productsImage = [
    MyImages.ringsProductsImage,
    MyImages.earringsProductsImage,
    MyImages.chainProductsImage,
    MyImages.rings,
    MyImages.mangalsutraCategories,
    MyImages.menAnniversaryGiftImage,
    MyImages.platinumRingImage,
    MyImages.cocktailImage,
  ];
  List productsName = [
    LocalStrings.rings,
    LocalStrings.earrings,
    LocalStrings.chain,
    LocalStrings.noseRings,
    LocalStrings.mangalsutra,
    LocalStrings.birthdayGifts,
    LocalStrings.platinumRings,
    LocalStrings.cocktail,
  ];
  List productsPriceLst = [
    LocalStrings.wishlistPriceFirst,
    LocalStrings.wishlistPriceSecond,
    LocalStrings.wishlistPriceThird,
    LocalStrings.wishlistPriceFor,
    LocalStrings.wishlistPriceFive,
    LocalStrings.wishlistPriceSix,
    LocalStrings.wishlistPriceSeven,
    LocalStrings.wishlistPriceEight,
  ];

  // Using Rx to make the selected number observable
  Rx<int> selectedNumber = 6.obs; // Initial value is 6

  // Update the selected number
  void updateSelectedNumber(int number) {
    selectedNumber.value = number;
  }

  removeLocallyWishlist(int index) {
    wishlistProducts.removeAt(index);
    update();
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

  // Method to update the 'isAlready' status for products in 'filterProductData'
  void updateProductStatus(String productId, bool isAlready) {
    // Update the 'isAlready' status for the product with matching productId
    for (var product in filterProductData) {
      if (product.productId == productId) {
        product.isAlready = isAlready;
        break;
      }
    }
    update();
  }

  //Todo : Wishlist products get data api method
  Future getWishlistDataApiMethod() async {
    try {
      isWishlistProduct.value = true;
      Response response = await APIFunction().apiCall(
          apiName:
              "${LocalStrings.getWishlistProductApi}${PrefManager.getString('userId')}",
          context: Get.context,
          isGet: true,
          isLoading: false);
      if (response.statusCode == 200) {
        wishlistProducts = (response.data['wishlist']['products'] as List)
            .map((getWishlistProducts) =>
                WishlistProducts.fromJson(getWishlistProducts))
            .toList();
        print("Wishlist product length : ${wishlistProducts.length}");
      }
    } catch (e) {
      print('Get Wishlist data :$e');
    } finally {
      isWishlistProduct.value = false;
      update();
    }
  }
}
