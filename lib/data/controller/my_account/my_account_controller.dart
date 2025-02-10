import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/style.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../view/components/common_button.dart';
import '../create_account/create_account_controller.dart';

class MyAccountController extends GetxController {
  late AnimationController animationController;
  late Animation<Color?> borderColorAnimation;
  double profileCompleteProgress = 0.6;
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

  //Todo : Logout user api method
  Future logoutApiMethod() async {
    final createAccountController =
        Get.put<CreateAccountController>(CreateAccountController());
    try {
      createAccountController.isLoading = true;
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.logoutApi,
          context: Get.context,
          isLoading: false,
          token: "Bearer ${PrefManager.getString('token')}",
          params: {} // Params if form data set if you have not any parameter formData set {}
          );

      if (response.statusCode == 200) {
        /// Remove device local data in device stored isLogin ,First name ,Last name ,Email , Phone number
        PrefManager.removeString('isLogin');
        PrefManager.removeString('firstName');
        PrefManager.removeString('lastName');
        PrefManager.removeString('email');
        PrefManager.removeString('phoneNumber');
        PrefManager.removeString('gender');
        PrefManager.removeString('token');
        //Todo : Off all navigation and move My account screen
        Get.offAllNamed(RouteHelper.bottomBarScreen);
        printAction("Logout Users");
      }
    } catch (e) {
      showSnackBar(context: Get.context!, message: "$e");
    } finally {
      createAccountController.isLoading = false;
      update();
    }
  }

//Todo : Logout confirm ya cancel options show dialog
  void logoutConfirmationDialog(BuildContext context) {
    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              // Duration of the fade-in
              child: Material(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(8.0),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(LocalStrings.logoutDialogText,
                          style: semiBoldMediumLarge.copyWith(
                              color: ColorResources.conceptTextColor)),
                      const SizedBox(height: Dimensions.space10),
                      Text(LocalStrings.askLogout,
                          textAlign: TextAlign.center,
                          style: semiBoldLarge.copyWith(
                              color: ColorResources.conceptTextColor)),
                      const SizedBox(height: Dimensions.space20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CommonButton(
                              onTap: () {
                                Get.back();
                              },
                              buttonName: LocalStrings.cancel,
                              buttonColor: ColorResources.buttonColorDark,
                              textStyle: semiBoldMediumLarge.copyWith(),
                              gradientFirstColor:
                                  ColorResources.offerThirdTextColor,
                              gradientSecondColor:
                                  ColorResources.offerThirdTextColor,
                            ),
                          ),
                          const SizedBox(width: Dimensions.space20),
                          Expanded(
                            child: CommonButton(
                              onTap: () {
                                Get.back();
                                /// Logout api method
                                logoutApiMethod();
                              },
                              buttonName: LocalStrings.logoutDialogText,
                              buttonColor: ColorResources.buttonColorDark,
                              textStyle: semiBoldMediumLarge.copyWith(
                                  color: ColorResources.whiteColor),
                              gradientFirstColor:
                                  ColorResources.notValidateColor,
                              gradientSecondColor:
                                  ColorResources.notValidateColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      barrierDismissible: false, // Prevents tapping outside to dismiss
    );
  }
}
