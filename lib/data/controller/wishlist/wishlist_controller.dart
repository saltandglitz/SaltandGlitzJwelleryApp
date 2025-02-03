import 'package:get/get.dart';

import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';

class WishlistController extends GetxController {
  RxBool isEnableNetwork = false.obs;
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
}
