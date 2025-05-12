import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/edit_profile/edit_profile_controller.dart';
import 'package:saltandGlitz/data/controller/my_account/my_account_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../main_controller.dart';
import '../../components/app_circular_loader.dart';
import '../../components/common_button.dart';
import '../../components/network_connectivity_view.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  final myAccountController = Get.put<MyAccountController>(
    MyAccountController(),
  );
  final createAccountController = Get.put<CreateAccountController>(
    CreateAccountController(),
  );
  final mainController = Get.put<MainController>(
    MainController(),
  );

  @override
  void initState() {
    super.initState();
    mainController.checkToAssignNetworkConnections();

    /// Analysis log account view
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logMyAccountView, index: 2);
// Animation border login button
    myAccountController.animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // Duration of one cycle
      vsync: this,
    )..repeat(reverse: true); // Repeat animation back and forth

    myAccountController.borderColorAnimation = ColorTween(
      begin: ColorResources.offerColor, // First color
      end: ColorResources.cardTabColor, // First color
      // Second color
    ).animate(myAccountController.animationController);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    // Ensure profileCompleteProgress is between 0 and 1
    final clampedProgress =
        myAccountController.profileCompleteProgress.clamp(0.0, 1.0);
    // Convert to percentage and ensure correct formatting
    final percentage = (clampedProgress * 100).toStringAsFixed(0);
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (mainController) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          body: SafeArea(
            top: false,
            bottom: false,
            child: GetBuilder(
              init: MyAccountController(),
              builder: (controller) {
                return mainController.isNetworkConnection?.value == false
                    ? NetworkConnectivityView(
                        onTap: () async {
                          RxBool? isEnableNetwork = await mainController
                              .checkToAssignNetworkConnections();
                          if (isEnableNetwork!.value == true) {
                            controller.enableNetworkHideLoader();
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                Get.put<MyAccountController>(
                                  MyAccountController(),
                                );
                                controller.disableNetworkLoaderByDefault();
                              },
                            );
                            controller.update();
                          }
                        },
                        isLoading: controller.isEnableNetwork,
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            PrefManager.getString('isLogin') == 'yes'
                                ?
                                // After login view
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        top: padding.top * 1.3,
                                        left: 15,
                                        right: 15,
                                        bottom: 20),
                                    color: ColorResources.buttonColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${LocalStrings.hi}, ${PrefManager.getString('firstName') ?? ''} ${PrefManager.getString('lastName') ?? ''}",
                                                style:
                                                    semiBoldExtraLarge.copyWith(
                                                        color: ColorResources
                                                            .inactiveCardColor),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space2),
                                              Text(
                                                LocalStrings.completeProfile,
                                                style: mediumDefault.copyWith(
                                                    color: ColorResources
                                                        .inactiveCardColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space40),
                                        CommonButton(
                                          onTap: () {
                                            /// Analysis Complete profile
                                            AppAnalytics().actionTriggerLogs(
                                                eventName: LocalStrings
                                                    .logMyAccountCompleteProfile,
                                                index: 2);
                                            Get.toNamed(
                                                RouteHelper.editProfileScreen);
                                          },
                                          borderColor:
                                              ColorResources.whiteColor,
                                          borderRadius: 8,
                                          height: size.height * 0.040,
                                          width: size.width * 0.25,
                                          buttonColor:
                                              ColorResources.buttonColorDark,
                                          textStyle: semiBoldLarge.copyWith(),
                                          gradientFirstColor:
                                              Colors.transparent,
                                          gradientSecondColor:
                                              Colors.transparent,
                                          child: Text(
                                            LocalStrings.complete,
                                            style: mediumDefault.copyWith(
                                              color: ColorResources.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                :
                                // without Login view
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      top: padding.top * 1.3,
                                      left: 15,
                                      right: 15,
                                      bottom: 20,
                                    ),
                                    color: ColorResources.buttonColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                LocalStrings.welcome,
                                                style:
                                                    semiBoldExtraLarge.copyWith(
                                                  color: ColorResources
                                                      .inactiveCardColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space2),
                                              Text(
                                                LocalStrings.loginDiscover,
                                                style: mediumDefault.copyWith(
                                                    color: ColorResources
                                                        .inactiveCardColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space40),
                                        CommonButton(
                                          borderColor:
                                              ColorResources.whiteColor,
                                          onTap: () {
                                            AppAnalytics().actionTriggerLogs(
                                                eventName: LocalStrings
                                                    .logMyAccountLoginClick,
                                                index: 2);
                                            Get.toNamed(
                                                    RouteHelper.loginScreen)!
                                                .then(
                                              (value) {
                                                if (value == true) {
                                                  print("Coming Data : 111");
                                                  // Get string login to check already login or not
                                                  // controller.loginKey =
                                                  //     PrefManager
                                                  //         .getString(
                                                  //             'isLogin');
                                                }
                                              },
                                            );
                                            PrefManager.getString('isLogin');
                                            controller.update();
                                          },
                                          borderRadius: 8,
                                          height: size.height * 0.040,
                                          width: size.width * 0.22,
                                          textStyle: semiBoldLarge.copyWith(),
                                          gradientFirstColor:
                                              Colors.transparent,
                                          gradientSecondColor:
                                              Colors.transparent,
                                          child: Text(
                                            LocalStrings.login,
                                            style: mediumDefault.copyWith(
                                              color: ColorResources.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: Dimensions.space15),
                            GetBuilder(
                              init: MyAccountController(),
                              builder: (controller) {
                                return GridView.builder(
                                  itemCount:
                                      controller.accountServiceTitleLst.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.48,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        /// Analysis services
                                        AppAnalytics().actionTriggerLogs(
                                            eventName:
                                                "My_Account_${index == 1 ? 'Add_to_cart' : index == 3 ? 'Video_call_history' : controller.accountServiceTitleLst[index]}_${LocalStrings.logMyAccountButtonClick}",
                                            index: 2);
                                        if (index == 1) {
                                          Get.toNamed(
                                              RouteHelper.addCartScreen);
                                        } else if (index == 2) {
                                          Get.toNamed(
                                              RouteHelper.wishlistScreen);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: controller
                                              .accountServiceColorLst[index],
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.offersCardRadius),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: controller
                                                        .accountServiceSubColorLst[
                                                    index],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .defaultRadius),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  controller
                                                          .accountServiceSubIconLst[
                                                      index],
                                                  size: 15,
                                                  color:
                                                      ColorResources.whiteColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                height: Dimensions.space7),
                                            Text(
                                              controller.accountServiceTitleLst[
                                                  index],
                                              style: semiBoldLarge.copyWith(
                                                color:
                                                    ColorResources.buttonColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            GetBuilder(
                                                init: EditProfileController(),
                                                builder: (ctrl) {
                                                  return Text(
                                                    PrefManager.getString(
                                                                'isLogin') ==
                                                            'yes'
                                                        ? (index == 3
                                                            ? (ctrl.userSaltCash
                                                                    .text
                                                                    .trim()
                                                                    .isEmpty
                                                                ? '0'
                                                                : ctrl
                                                                    .userSaltCash
                                                                    .text)
                                                            : controller
                                                                    .logInAccountServiceSubtitleLst[
                                                                index])
                                                        : controller
                                                                .accountServiceSubtitleLst[
                                                            index],
                                                    style:
                                                        regularSmall.copyWith(
                                                      color: ColorResources
                                                          .buttonColor,
                                                      fontSize: 10,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space15),
                            PrefManager.getString('isLogin') == 'yes'
                                ?
                                // with login Offers view
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    color: ColorResources.deliveryColorColor
                                        .withOpacity(0.2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(MyImages.discountImage,
                                                height: size.height * 0.025,
                                                color:
                                                    ColorResources.buttonColor),
                                            const SizedBox(
                                                width: Dimensions.space7),
                                            Text(
                                              LocalStrings.yourOffers,
                                              style: semiBoldLarge.copyWith(
                                                  color: ColorResources
                                                      .buttonColor),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                /// Analysis Offer View All
                                                AppAnalytics().actionTriggerLogs(
                                                    eventName: LocalStrings
                                                        .logMyAccountViewAllOffer,
                                                    index: 2);
                                              },
                                              child: Text(
                                                LocalStrings.viewAll,
                                                style: mediumLarge.copyWith(
                                                    color: ColorResources
                                                        .offerColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        SizedBox(
                                          height: size.height * 0.14,
                                          child: ListView.builder(
                                            itemCount:
                                                controller.offerLst.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                height: size.height * 0.14,
                                                width: size.width * 0.53,
                                                padding: EdgeInsets.zero,
                                                margin: const EdgeInsets.only(
                                                    right: 13),
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorResources.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .defaultRadius),
                                                ),
                                                child: Stack(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                LocalStrings
                                                                    .offFirst,
                                                                style: semiBoldMediumLarge
                                                                    .copyWith(
                                                                        color: ColorResources
                                                                            .buttonColor),
                                                              ),
                                                              const SizedBox(
                                                                  height:
                                                                      Dimensions
                                                                          .space1),
                                                              Text(
                                                                controller
                                                                        .offerLst[
                                                                    index],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: mediumSmall
                                                                    .copyWith(
                                                                        color: ColorResources
                                                                            .buttonColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space1),
                                                        Divider(
                                                          color: ColorResources
                                                              .borderColor
                                                              .withOpacity(0.2),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                        .offerCodeLst[
                                                                    index],
                                                                style: mediumLarge
                                                                    .copyWith(
                                                                        color: ColorResources
                                                                            .buttonColor),
                                                              ),
                                                              const SizedBox(
                                                                  width: Dimensions
                                                                      .space5),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  /// Analysis Offer Referral code copy
                                                                  AppAnalytics()
                                                                      .actionTriggerLogs(
                                                                          eventName:
                                                                              "My_Account_${controller.offerCodeLst[index]}_${LocalStrings.logMyAccountReferralCodeCopy}",
                                                                          index:
                                                                              2);
                                                                  Clipboard
                                                                      .setData(
                                                                    ClipboardData(
                                                                      text: controller
                                                                              .offerCodeLst[
                                                                          index],
                                                                    ),
                                                                  );
                                                                  showToast(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        "Copied ${controller.offerCodeLst[index]}",
                                                                  );
                                                                },
                                                                child: const Icon(
                                                                    Icons
                                                                        .copy_all_rounded,
                                                                    size: 17,
                                                                    color: ColorResources
                                                                        .offerColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                :
                                // without login Offers view
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 18,
                                    ),
                                    color: ColorResources.lightGreenColour
                                        .withOpacity(0.25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(MyImages.discountImage,
                                                height: size.height * 0.025,
                                                color:
                                                    ColorResources.buttonColor),
                                            const SizedBox(
                                                width: Dimensions.space7),
                                            Text(
                                              LocalStrings.yourOffers,
                                              style: semiBoldLarge.copyWith(
                                                  color: ColorResources
                                                      .buttonColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space8),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: LocalStrings.viewOffers,
                                                style: regularDefault.copyWith(
                                                  color: ColorResources
                                                      .buttonColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TextSpan(
                                                text: LocalStrings.login,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Get.toNamed(RouteHelper
                                                            .loginScreen);

                                                        /// Analysis view offer purpose login
                                                        AppAnalytics()
                                                            .actionTriggerLogs(
                                                                eventName:
                                                                    LocalStrings
                                                                        .logMyAccountOfferLoginClick,
                                                                index: 2);
                                                      },
                                                style: regularDefault.copyWith(
                                                    color: ColorResources
                                                        .offerColor,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: Dimensions.space15),
                            GetBuilder(
                              init: MyAccountController(),
                              builder: (controller) {
                                return ListView.builder(
                                  itemCount:
                                      controller.accountServiceLst.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                        } else if (index == 1) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/plan-of-purchaes");
                                        } else if (index == 2) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/shippingPolicy");
                                        } else if (index == 3) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/warranty");
                                        } else if (index == 4) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/exchange");
                                        } else if (index == 5) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/return");
                                        } else if (index == 11) {
                                          Get.toNamed(
                                              RouteHelper.inAppWebViewScreen,
                                              arguments:
                                                  "https://saltandglitz.com/cancellation");
                                        }

                                        /// Analysis Account Users Services Provide
                                        AppAnalytics().actionTriggerLogs(
                                            eventName:
                                                "My_Account_${index == 5 ? 'Rate_Us' : index == 6 ? 'Share_App' : index == 7 ? 'Send_Feedback' : index == 8 ? 'Terms_Of_Use' : controller.accountServiceLst[index]}_${LocalStrings.logMyAccountButtonClick}",
                                            index: 2);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                              height: Dimensions.space15),
                                          Text(
                                            controller.accountServiceLst[index],
                                            style: mediumDefault.copyWith(
                                                color:
                                                    ColorResources.buttonColor),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space15),
                                          Divider(
                                            color: ColorResources.borderColor
                                                .withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Whatsapp
                                  GestureDetector(
                                    onTap: () {
                                      //Todo : Only testing purpose set this method
                                      PrefManager.setString('isLogin', '');
                                      controller.update();
                                      // /// Analysis Whatsapp
                                      // AppAnalytics().actionTriggerLogs(
                                      //     eventName: LocalStrings
                                      //         .logMyAccountWhatsappClick,
                                      //     index: 2);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: ColorResources
                                                .offerThirdTextColor
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              MyImages.whatsappImage,
                                              height: size.height * 0.025,
                                              color: ColorResources.buttonColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space5),
                                        Text(
                                          LocalStrings.whatsapp,
                                          style: semiBoldSmall.copyWith(
                                              color:
                                                  ColorResources.buttonColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Email
                                  GestureDetector(
                                    onTap: () {
                                      /// Analysis Email
                                      AppAnalytics().actionTriggerLogs(
                                          eventName: LocalStrings
                                              .logMyAccountEmailClick,
                                          index: 2);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: ColorResources
                                                .offerThirdTextColor
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              MyImages.emailImage,
                                              height: size.height * 0.025,
                                              color: ColorResources.buttonColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space5),
                                        Text(
                                          LocalStrings.email,
                                          style: semiBoldSmall.copyWith(
                                            color: ColorResources.buttonColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            GetBuilder(
                              init: MyAccountController(),
                              builder: (controller) {
                                return AnimatedBuilder(
                                  animation: controller.animationController,
                                  builder: (context, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (PrefManager.getString('isLogin') ==
                                            'yes') {
                                          if (PrefManager.getString(
                                                  'loginType') ==
                                              'Google') {
                                            createAccountController
                                                .signOutWithGoogle();

                                            /// Analysis logout Google
                                            AppAnalytics().actionTriggerLogs(
                                                eventName: LocalStrings
                                                    .logMyAccountLogoutGoogleClick,
                                                index: 2);

                                            print("Google");
                                          } else if (PrefManager.getString(
                                                  'loginType') ==
                                              'FaceBook') {
                                            createAccountController
                                                .signOutWithFacebook();

                                            /// Analysis logout FaceBook
                                            AppAnalytics().actionTriggerLogs(
                                                eventName: LocalStrings
                                                    .logMyAccountLogoutFacebookClick,
                                                index: 2);
                                            print("Facebook");
                                          } else {
                                            /// Ask to user logout confirmation dialog Box
                                            controller.logoutConfirmationDialog(
                                                context);

                                            /// Analysis logout
                                            AppAnalytics().actionTriggerLogs(
                                                eventName: LocalStrings
                                                    .logMyAccountLogoutClick,
                                                index: 2);
                                            print("Normal");
                                          }
                                        } else {
                                          /// Analysis login click
                                          AppAnalytics().actionTriggerLogs(
                                              eventName: LocalStrings
                                                  .logMyAccountLoginClick,
                                              index: 2);
                                          Get.toNamed(RouteHelper.loginScreen)!
                                              .then(
                                            (value) {
                                              if (value == true) {
                                                print("Coming Data : 333");
                                                // Get string login to check already login or not
                                                // controller.loginKey =
                                                //     PrefManager
                                                //         .getString(
                                                //             'isLogin');
                                              }
                                            },
                                          );
                                        }
                                        PrefManager.getString('isLogin');
                                        controller.update();
                                      },
                                      child: Container(
                                        height: size.height * 0.047,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: controller
                                                      .borderColorAnimation
                                                      .value ??
                                                  ColorResources.buttonColor,
                                              width: 1),
                                        ),
                                        child: createAccountController
                                                    .isLoading ==
                                                true
                                            ? AppCircularLoader()
                                            : Center(
                                                child: Text(
                                                  PrefManager.getString(
                                                              'isLogin') ==
                                                          'yes'
                                                      ?

                                                      /// With login view text
                                                      LocalStrings.logout
                                                      :

                                                      /// Without login view text
                                                      LocalStrings.login,
                                                  style:
                                                      semiBoldDefault.copyWith(
                                                          color: ColorResources
                                                              .buttonColor),
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space30),
                            Text(
                              "${LocalStrings.appVersion} 1.0.0",
                              style: semiBoldSmall.copyWith(
                                  color: ColorResources.borderColor),
                            ),
                            const SizedBox(height: Dimensions.space10),
                          ],
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }

  // Dispose animation login button border
  @override
  void dispose() {
    myAccountController.animationController.dispose();
    super.dispose();
  }
}
