import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';

import '../../core/utils/images.dart';

class ProductController extends GetxController {
  var currentIndex = 0.obs;
  var colorCurrentIndex = (2).obs;
  var ktCurrentIndex = (0).obs;
  bool isFavorites = false;
  final CarouselController carouselController =
      CarouselController(); // Add CarouselController

  TextEditingController search = TextEditingController();
  TextEditingController pincode = TextEditingController();
  final List<String> imageUrls = [
    MyImages.ringOneImage,
    MyImages.ringOneImage,
    MyImages.ringOneImage,
    MyImages.ringOneImage,
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
    LocalStrings.makingCharge,
    LocalStrings.gst,
    LocalStrings.totalText,
  ];
  List breakupItemPriceLst = [
    LocalStrings.goldPrice,
    LocalStrings.diamondPrice,
    LocalStrings.chargeFirst,
    LocalStrings.gstPrice,
    LocalStrings.totalPrice,
  ];
  List promiseImageLst = [
    MyImages.buyBackImage,
    MyImages.exchangeImage,
    MyImages.returnImage,
    MyImages.freeShippingImage,
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

  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;
  }

  void goToPage(int index) {
    carouselController.animateToPage(index); // Add method to change page
  }

  void isFavoritesMethod() {
    isFavorites = !isFavorites;
    update();
  }

  void colorSelectionJewellery(int index) {
    colorCurrentIndex.value = index;
    update();
  }

  void ktSelectionJewellery(int index) {
    ktCurrentIndex.value = index;
    update();
  }

  var originalPrice = 75386.obs;
  var discountedPrice = 57386.obs;
  var discountCode = 'JB10';

  void applyDiscount() {
    originalPrice.value = discountedPrice.value;
  }
}
