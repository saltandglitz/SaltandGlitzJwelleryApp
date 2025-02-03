import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../analytics/app_analytics.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/images.dart';
import '../../core/utils/local_strings.dart';

class ProductController extends GetxController {
  var currentIndex = 0.obs;
  var colorCurrentIndex = (2).obs;
  var ktCurrentIndex = (0).obs;
  bool isFavorites = false;
  final CarouselController carouselController =
  CarouselController(); // Add CarouselController

  TextEditingController search = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String productImage='';
  List<String> imageUrls = [
  ];
  List<Color> colorLst = [
    ColorResources.offerNineColor,
    ColorResources.borderColor.withOpacity(0.2),
    ColorResources.updateCardColor,
  ];
  List ctLst = [
    LocalStrings.ktFirst,
    LocalStrings.ktSecond,
  ];
  List goldTypeMessageLst = [
    LocalStrings.roseGold,
    LocalStrings.whiteGold,
    LocalStrings.yellowGold,
  ];
  List ktTypeMessageLst = [
    LocalStrings.ktFirst,
    LocalStrings.ktSecond,
  ];
  List diamondWeightTableLst = [
    LocalStrings.sizeText,
    LocalStrings.colorText,
    LocalStrings.clarity,
    LocalStrings.shape,
    LocalStrings.noDiamonds,
    LocalStrings.total,
  ];
  List diamondWeightTableValueLst = [
    LocalStrings.sizeGold,
    LocalStrings.gh,
    LocalStrings.vs,
    LocalStrings.round,
    LocalStrings.diamondSize,
    LocalStrings.wrightSize,
  ];
  List breakupItemLst = [
    LocalStrings.goldText,
    LocalStrings.diamond,
    LocalStrings.makingCharg,
    LocalStrings.gst,
    LocalStrings.totalText,
  ];
  List breakupItemPriceLst = [
    LocalStrings.goldPrice,
    LocalStrings.diamondPrice,
    LocalStrings.chargFirst,
    LocalStrings.gstPrice,
    LocalStrings.totalPrice,
  ];
  List promiseImageLst = [
    MyImages.buyBackImage,
    MyImages.exchangeImage,
    MyImages.returnImage,
    MyImages.freeShipingImage,
    MyImages.hallmarkImage,
    MyImages.certifiedImage,
  ];
  List promiseNameLst = [
    LocalStrings.buyBack,
    LocalStrings.exchange,
    LocalStrings.returns,
    LocalStrings.shippingInsuranceFree,
    LocalStrings.hallmarked,
    LocalStrings.certified,
  ];
  RxBool isEnableNetwork = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      /// Previous screen to get image data
      productImage=Get.arguments[0];
      /// Stored get image
      imageUrls=[
        productImage,
        productImage,
        productImage,
        productImage
      ];
    }
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
  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;

    /// Particular Product angle view analysis log
    if (changeReason == CarouselPageChangedReason.manual) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductAngleView,
          productImage: imageUrls[index],
          productName: LocalStrings.goldenRing,
          index: 6);
    }
  }

  void goToPage(int index) {
    carouselController.animateToPage(index); // Add method to change page
  }

  void isFavoritesMethod() {
    isFavorites = !isFavorites;
    if (isFavorites == false) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductUnFavoriteClick,
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    } else {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductFavoriteClick,
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    }
    update();
  }

  void colorSelectionJewellery(int index) {
    colorCurrentIndex.value = index;
    if (colorCurrentIndex.value == 1) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName:
          "${LocalStrings.logProductSliver}_${LocalStrings.logProductProductTypeSelection}",
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    } else if (colorCurrentIndex.value == 2) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName:
          "${LocalStrings.logProductGold}_${LocalStrings.logProductProductTypeSelection}",
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    }
    update();
  }

  void ktSelectionJewellery(int index) {
    ktCurrentIndex.value = index;

    /// Product name now static but when integration dynamic data set product name dynamic
    AppAnalytics().actionTriggerWithProductsLogs(
        eventName:
        "${ctLst[index] == '18Kt' ? 'Eighteen_Kt' : 'Fourteen_Kt'}_${LocalStrings.logProductProductTypeSelection}",
        productName: LocalStrings.goldenRing,
        productImage: imageUrls[0],
        index: 6);
    update();
  }

  var originalPrice = 75386.obs;
  var discountedPrice = 57386.obs;
  var discountCode = 'JB10';

  void applyDiscount() {
    originalPrice.value = discountedPrice.value;
  }
}
