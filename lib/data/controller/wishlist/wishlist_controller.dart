import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/data/model/get_wishlist_view_model.dart';
import 'package:saltandGlitz/local_storage/pref_manager.dart';

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

  removeLocally(int index) {
    productsImage.removeAt(index);
    productsName.removeAt(index);
    productsPriceLst.removeAt(index);
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

  //Todo : Wishlist products get data api method
  Future getWishlistDataApiMethod() async {
    try {
      isWishlistProduct.value = true;
      Response response = await APIFunction().apiCall(
          apiName:
              "${LocalStrings.getWishlistProductApi}${PrefManager.getString('user_id')}",
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

//Todo : After wishlist add products remove to wishlist api method
  Future deleteWishlistProductApiMethod() async {

  }
}
