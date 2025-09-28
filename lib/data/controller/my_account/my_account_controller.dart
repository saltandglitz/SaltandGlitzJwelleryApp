import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/api_repository/dio_client.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/style.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../view/components/common_button.dart';
import '../../model/user_profile_model.dart';
import '../create_account/create_account_controller.dart';

class MyAccountController extends GetxController {
  late AnimationController animationController;
  late Animation<Color?> borderColorAnimation;

  double profileCompleteProgress = 0.0;
  RxBool isEnableNetwork = false.obs;
  RxBool isProfileCompleted = false.obs;
  UserProfile? userProfile;
  List accountServiceTitleLst = [
    LocalStrings.orders,
    LocalStrings.addCart,
    LocalStrings.wishlist,
    LocalStrings.userSaltCash,
  ];
  List accountServiceSubtitleLst = [
    LocalStrings.viewStatus,
    LocalStrings.viewCart,
    LocalStrings.viewWishlist,
    LocalStrings.logInToViewUserSaltCase,
  ];
  List logInAccountServiceSubtitleLst = [
    LocalStrings.logInViewStatus,
    LocalStrings.logInViewCart,
    LocalStrings.logInViewWishlist,
    "0",
  ];
  List<Color> accountServiceColorLst = [
    ColorResources.offerColor.withOpacity(0.1),
    ColorResources.offerFirstColor.withOpacity(0.2),
    ColorResources.activeCardColor.withOpacity(0.1),
    ColorResources.buttonGradientColor.withOpacity(0.1),
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
    LocalStrings.shippingPolicy,
    LocalStrings.warrantyAccount,
    LocalStrings.exchangeText,
    LocalStrings.returnText,
    LocalStrings.repair,
    LocalStrings.rateUs,
    LocalStrings.shareApp,
    LocalStrings.sendFeedback,
    LocalStrings.termsUse,
    LocalStrings.cancellation,
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

  @override
  void onInit() {
    super.onInit();
    // Check if user is logged in and fetch profile
    if (PrefManager.getString('isLogin') == 'yes') {
      getUserProfile();
    }
    // Load profile status from local storage
    String profileCompletedStr =
        PrefManager.getString('profileCompleted') ?? 'false';
    isProfileCompleted.value = profileCompletedStr == 'true';
  }

  //Todo: Get user profile method to fetch complete user data
  Future<void> getUserProfile() async {
    try {
      String? token = PrefManager.getString('token');
      if (token == null || token.isEmpty) return;

      Response response;

      try {
        response = await Dioclient.get(
          "/api/users/profile",
        );
      } catch (e) {
        debugPrint(token);
        debugPrint(
            'Error fetching user profile fddddddd-----------------------------: $e');
        return;
      }
      debugPrint('User profile data: ${response.data}');
      if (response.statusCode == 200) {
        // Parse the user profile data

        userProfile = UserProfile.fromJson(response.data);
        debugPrint(
            'User profile data after response -----------------------: ${response.data}');
        // Store complete user profile data in PrefManager
        if (userProfile != null) {
          PrefManager.setString('firstName', userProfile!.firstName ?? '');
          PrefManager.setString('lastName', userProfile!.lastName ?? '');
          PrefManager.setString('email', userProfile!.email ?? '');
          PrefManager.setString('phoneNumber', userProfile!.mobileNumber ?? '');
          PrefManager.setString('gender', userProfile!.gender ?? '');
          PrefManager.setString('userId', userProfile!.id ?? '');
          PrefManager.setString(
              'userSaltCash', userProfile!.userSaltCash?.toString() ?? '0');
          PrefManager.setString('profileCompleted',
              userProfile!.profileCompleted?.toString() ?? 'false');
          PrefManager.setString(
              'memberShipTier', userProfile!.memberShipTier ?? '');

          // Store additional profile fields
          PrefManager.setString('pincode', userProfile!.pincode ?? '');
          PrefManager.setString('occupation', userProfile!.occupation ?? '');

          if (userProfile!.dateOfBirth != null) {
            PrefManager.setString('dateOfBirth',
                userProfile!.dateOfBirth!.toString().split(' ')[0]);
          }

          if (userProfile!.aniversaryDate != null) {
            PrefManager.setString('aniversaryDate',
                userProfile!.aniversaryDate!.toString().split(' ')[0]);
          }

          // Store shipping address
          if (userProfile!.shippingAddress != null) {
            PrefManager.setString('streetAndHouseNumber',
                userProfile!.shippingAddress!.streetAndHouseNumber ?? '');
            PrefManager.setString('additionalInfo',
                userProfile!.shippingAddress!.additionalInfo ?? '');
            PrefManager.setString(
                'city', userProfile!.shippingAddress!.city ?? '');
            PrefManager.setString(
                'state', userProfile!.shippingAddress!.state ?? '');
          }

          // Update profile completion status
          isProfileCompleted.value = userProfile!.profileCompleted ?? false;
          profileCompleteProgress =
              userProfile!.getProfileCompletionPercentage();

          // Update account service list with actual userSaltCash
          if (userProfile!.userSaltCash != null) {
            logInAccountServiceSubtitleLst[3] =
                userProfile!.userSaltCash.toString();
          }
        }

        update();
      }
    } catch (e) {
      print("Error fetching user profile: $e");
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
        PrefManager.removeString('userId');
        PrefManager.removeString('profileCompleted');
        PrefManager.removeString('userSaltCash');
        PrefManager.removeString('memberShipTier');
        PrefManager.removeString('pincode');
        PrefManager.removeString('occupation');
        PrefManager.removeString('dateOfBirth');
        PrefManager.removeString('aniversaryDate');
        PrefManager.removeString('streetAndHouseNumber');
        PrefManager.removeString('additionalInfo');
        PrefManager.removeString('city');
        PrefManager.removeString('state');
        PrefManager.removeEntireItem('wishlistProductId');
        PrefManager.removeEntireItem('cartProductId');
        //Todo : Off all navigation and move My account screen
        Get.offAllNamed(RouteHelper.bottomBarScreen);
        printAction("Logout Users");
      }
    } catch (e) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: "$e",
        icon: Icons.error,
        iconColor: Colors.red,
      );
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
                              color: ColorResources.buttonColor)),
                      const SizedBox(height: Dimensions.space10),
                      Text(LocalStrings.askLogout,
                          textAlign: TextAlign.center,
                          style: semiBoldLarge.copyWith(
                              color: ColorResources.buttonColor)),
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
