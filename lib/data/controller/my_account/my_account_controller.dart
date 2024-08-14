import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/utils/color_resources.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';

class MyAccountController extends GetxController {
  late AnimationController animationController;
  late Animation<Color?> borderColorAnimation;
  double profileCompleteProgress = 0.6;
  List accountServiceTitleLst = [
    LocalStrings.orders,
    LocalStrings.addCart,
    LocalStrings.wishlist,
    LocalStrings.videoCall,
  ];
  List accountServiceSubtitleLst = [
    LocalStrings.viewStatus,
    LocalStrings.viewCart,
    LocalStrings.viewCallHistory,
    LocalStrings.viewWishlist,
  ];
  List<Color> accountServiceColorLst = [
    ColorResources.offerFirstColor.withOpacity(0.2),
    ColorResources.accountSarviceColor.withOpacity(0.5),
    ColorResources.helpNeedFirstColor.withOpacity(0.4),
    ColorResources.sortSelectedColor.withOpacity(0.2),
  ];
  List<Color> accountServiceSubColorLst = [
    ColorResources.offerColor,
    ColorResources.offerFirstColor,
    ColorResources.activeCardColor,
    ColorResources.buttonGradientColor,
  ];
  List accountServiceSubIconLst = [
    Icons.gif_box_outlined,
    Icons.add_shopping_cart,
    Icons.favorite_border_sharp,
    Icons.video_call_sharp,
  ];
  List accountServiceLst = [
    LocalStrings.faqs,
    LocalStrings.shipping,
    LocalStrings.exchangeText,
    LocalStrings.returnText,
    LocalStrings.repair,
    LocalStrings.rateUs,
    LocalStrings.shareApp,
    LocalStrings.sendFeedback,
    LocalStrings.termsUse,
  ];
  List offerLst = [
    LocalStrings.buyProducts,
    LocalStrings.flatProducts,
    LocalStrings.buyProducts,
  ];
  List offerCodeLst = [
    LocalStrings.rafralCodeFirst,
    LocalStrings.rafralCodeSecond,
    LocalStrings.rafralCodeFirst,
  ];
}
