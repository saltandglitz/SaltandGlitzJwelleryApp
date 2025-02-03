import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';

import '../../../local_storage/pref_manager.dart';

class MyAccountController extends GetxController {
  late AnimationController animationController;
  late Animation<Color?> borderColorAnimation;
  double profileCompleteProgress = 0.6;
  String userLoginType = '';
  RxBool isEnableNetwork = false.obs;
  List accountServiceTitleLst = [
    LocalStrings.orders,
    LocalStrings.addCart,
    LocalStrings.wishlist,
    LocalStrings.coins,
  ];
  List accountServiceSubtitleLst = [
    LocalStrings.viewStatus,
    LocalStrings.viewCart,
    LocalStrings.viewWishlist,
    LocalStrings.comingSoon,
  ];
  List<Color> accountServiceColorLst = [
    ColorResources.offerFirstColor.withOpacity(0.2),
    ColorResources.accountServiceColor.withOpacity(0.5),
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
    Icons.currency_rupee,
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
    LocalStrings.referralCodeFirst,
    LocalStrings.referralCodeSecond,
    LocalStrings.referralCodeFirst,
  ];
  showLogInType() {
    userLoginType = PrefManager.getString('loginType') ?? '';
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
