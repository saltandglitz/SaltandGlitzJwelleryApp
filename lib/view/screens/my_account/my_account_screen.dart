import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/route/route.dart';
import 'package:solatn_gleeks/core/utils/color_resources.dart';
import 'package:solatn_gleeks/core/utils/dimensions.dart';
import 'package:solatn_gleeks/core/utils/images.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';
import 'package:solatn_gleeks/data/controller/my_account/my_account_controller.dart';
import 'package:solatn_gleeks/view/components/common_message_show.dart';

import '../../../core/utils/style.dart';
import '../../components/common_button.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  final myAccountController =
      Get.put<MyAccountController>(MyAccountController());

  @override
  void initState() {
    super.initState();
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
    return GetBuilder(
        init: MyAccountController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    /// After login view
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: padding.top * 0.80,
                          left: 15,
                          right: 15,
                          bottom: 20),
                      color: ColorResources.conceptTextColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${LocalStrings.hi}, Pinakin",
                                  style: mediumOverLarge.copyWith(
                                      color: ColorResources.inactiveCardColor),
                                ),
                                const SizedBox(height: Dimensions.space2),
                                Text(
                                  LocalStrings.completeProfile,
                                  style: mediumLarge.copyWith(
                                      color: ColorResources.inactiveCardColor),
                                ),
                                const SizedBox(height: Dimensions.space12),
                                GetBuilder(
                                    init: MyAccountController(),
                                    builder: (controller) {
                                      return Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.defaultRadius),
                                            child: SizedBox(
                                              height: size.height * 0.0055,
                                              width: size.width * 0.30,
                                              child:
                                                  const LinearProgressIndicator(
                                                value: 0.6, // percent filled
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        ColorResources
                                                            .videoCallColor),
                                                backgroundColor: ColorResources
                                                    .inactiveCardColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: Dimensions.space5),
                                          Text(
                                            "$percentage%",
                                            style: semiBoldSmall.copyWith(
                                                color: ColorResources
                                                    .inactiveCardColor),
                                          ),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimensions.space40),
                          CommonButton(
                            onTap: () {
                              Get.toNamed(RouteHelper.editProfileScreen);
                            },
                            height: size.height * 0.045,
                            width: size.width * 0.26,
                            buttonName: LocalStrings.complete,
                            buttonColor: ColorResources.buttonColorDark,
                            textStyle: semiBoldLarge.copyWith(),
                            gradientFirstColor: ColorResources.offerSixColor,
                            gradientSecondColor: ColorResources.offerSixColor,
                          ),
                        ],
                      ),
                    ),

                    /// without Login view
                    // Container(
                    //   width: double.infinity,
                    //   padding: EdgeInsets.only(
                    //       top: padding.top * 0.80, left: 15, right: 15, bottom: 20),
                    //   color: ColorResources.conceptTextColor,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               LocalStrings.welcome,
                    //               style: mediumOverLarge.copyWith(
                    //                   color: ColorResources.inactiveCardColor),
                    //             ),
                    //             const SizedBox(height: Dimensions.space2),
                    //             Text(
                    //               LocalStrings.loginDiscover,
                    //               style: mediumLarge.copyWith(
                    //                   color: ColorResources.inactiveCardColor),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       const SizedBox(width: Dimensions.space40),
                    //       CommonButton(
                    //         onTap: () {
                    //           Get.toNamed(RouteHelper.loginScreen);
                    //         },
                    //         height: size.height * 0.043,
                    //         width: size.width * 0.22,
                    //         buttonName: LocalStrings.login,
                    //         buttonColor: ColorResources.buttonColorDark,
                    //         textStyle: semiBoldLarge.copyWith(),
                    //         gradientFirstColor: ColorResources.offerSixColor,
                    //         gradientSecondColor: ColorResources.offerSixColor,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: Dimensions.space15),
                    GetBuilder(
                        init: MyAccountController(),
                        builder: (controller) {
                          return GridView.builder(
                            itemCount: controller.accountServiceTitleLst.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 7 / 5),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color:
                                      controller.accountServiceColorLst[index],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.offersCardRadius),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: controller
                                            .accountServiceSubColorLst[index],
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.defaultRadius),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          controller
                                              .accountServiceSubIconLst[index],
                                          size: 15,
                                          color: ColorResources.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space7),
                                    Text(
                                        controller
                                            .accountServiceTitleLst[index],
                                        style: semiBoldLarge.copyWith(
                                            color: ColorResources
                                                .conceptTextColor)),
                                    Text(
                                        controller
                                            .accountServiceSubtitleLst[index],
                                        style: regularDefault.copyWith()),
                                  ],
                                ),
                              );
                            },
                          );
                        }),

                    const SizedBox(height: Dimensions.space15),

                    /// with login Offers view
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      color: ColorResources.deliveryColorColor.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(MyImages.dicountImage,
                                  height: size.height * 0.025,
                                  color: ColorResources.conceptTextColor),
                              const SizedBox(width: Dimensions.space7),
                              Text(LocalStrings.yourOffers,
                                  style: semiBoldLarge.copyWith(
                                      color: ColorResources.conceptTextColor)),
                              const Spacer(),
                              Text(LocalStrings.viewAll,
                                  style: mediumLarge.copyWith(
                                      color: ColorResources.offerColor)),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space20),
                          SizedBox(
                            height: size.height * 0.14,
                            child: ListView.builder(
                              itemCount: controller.offerLst.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: size.height * 0.14,
                                  width: size.width * 0.53,
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(right: 13),
                                  decoration: BoxDecoration(
                                    color: ColorResources.whiteColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 15, right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(LocalStrings.offFirst,
                                                    style: semiBoldMediumLarge
                                                        .copyWith(
                                                            color: ColorResources
                                                                .conceptTextColor)),
                                                const SizedBox(
                                                    height: Dimensions.space1),
                                                Text(controller.offerLst[index],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mediumSmall.copyWith(
                                                        color: ColorResources
                                                            .conceptTextColor)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space1),
                                          Divider(
                                            color: ColorResources.borderColor
                                                .withOpacity(0.2),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                    controller
                                                        .offerCodeLst[index],
                                                    style: mediumLarge.copyWith(
                                                        color: ColorResources
                                                            .conceptTextColor)),
                                                const SizedBox(
                                                    width: Dimensions.space5),
                                                GestureDetector(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: controller
                                                                      .offerCodeLst[
                                                                  index]));
                                                      showToast(
                                                          context: context,
                                                          message:
                                                              "Copied ${controller.offerCodeLst[index]}");
                                                    },
                                                    child: const Icon(
                                                        Icons.copy_all_rounded,
                                                        size: 17,
                                                        color: ColorResources
                                                            .offerColor)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: size.height * 0.025,
                                        decoration:  BoxDecoration(
                                          color: ColorResources.deliveryColorColor.withOpacity(0.7),
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                  Dimensions.defaultRadius),
                                              bottomRight: Radius.circular(
                                                  Dimensions.defaultRadius)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                                width: Dimensions.space15),
                                            Text(LocalStrings.validDateOffer,
                                                style: mediumSmall.copyWith(
                                                    color: ColorResources
                                                        .whiteColor)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// without login Offers view
                    // Container(
                    //   width: double.infinity,
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    //   color: ColorResources.deliveryColorColor.withOpacity(0.2),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Image.asset(MyImages.dicountImage,
                    //               height: size.height * 0.025,
                    //               color: ColorResources.conceptTextColor),
                    //           const SizedBox(width: Dimensions.space7),
                    //           Text(LocalStrings.yourOffers,
                    //               style: semiBoldLarge.copyWith(
                    //                   color: ColorResources.conceptTextColor)),
                    //         ],
                    //       ),
                    //       const SizedBox(height: Dimensions.space10),
                    //       RichText(
                    //           text: TextSpan(
                    //         children: [
                    //           TextSpan(
                    //               text: LocalStrings.viewOffers,
                    //               style: regularDefault.copyWith(
                    //                   color: ColorResources.conceptTextColor)),
                    //           TextSpan(
                    //               text: LocalStrings.login,
                    //               style: mediumDefault.copyWith(
                    //                   color: ColorResources.offerColor)),
                    //         ],
                    //       ))
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: Dimensions.space20),
                    GetBuilder(
                        init: MyAccountController(),
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.accountServiceLst.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: Dimensions.space15),
                                  Text(
                                    controller.accountServiceLst[index],
                                    style: mediumDefault.copyWith(
                                        color: ColorResources.conceptTextColor),
                                  ),
                                  const SizedBox(height: Dimensions.space15),
                                  Divider(
                                    color: ColorResources.borderColor
                                        .withOpacity(0.2),
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Call Us
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      MyImages.phoneCallImage,
                                      height: size.height * 0.025,
                                      color: ColorResources.conceptTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  LocalStrings.callUs,
                                  textAlign: TextAlign.center,
                                  style: semiBoldSmall.copyWith(
                                      color: ColorResources.conceptTextColor),
                                ),
                              ],
                            ),
                          ),

                          // Chat
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      MyImages.chatImage,
                                      height: size.height * 0.025,
                                      color: ColorResources.conceptTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  LocalStrings.chat,
                                  style: semiBoldSmall.copyWith(
                                      color: ColorResources.conceptTextColor),
                                ),
                              ],
                            ),
                          ),
                          // Whatsapp
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      MyImages.whatsappImage,
                                      height: size.height * 0.025,
                                      color: ColorResources.conceptTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  LocalStrings.whatsapp,
                                  style: semiBoldSmall.copyWith(
                                      color: ColorResources.conceptTextColor),
                                ),
                              ],
                            ),
                          ), // Email
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: ColorResources.offerThirdTextColor
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      MyImages.emailImage,
                                      height: size.height * 0.025,
                                      color: ColorResources.conceptTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Text(
                                  LocalStrings.email,
                                  style: semiBoldSmall.copyWith(
                                      color: ColorResources.conceptTextColor),
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
                                  Get.toNamed(RouteHelper.loginScreen);
                                },
                                child: Container(
                                  height: size.height * 0.047,
                                  width: size.width * 0.40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.offersCardRadius),
                                    border: Border.all(
                                        color: controller
                                                .borderColorAnimation.value ??
                                            ColorResources.offerTenColor,
                                        width: 1.5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      /// With login view text
                                      LocalStrings.logout,
                                      /// Without login view text
                                      // LocalStrings.login,
                                      style: semiBoldDefault.copyWith(
                                          color:
                                              ColorResources.conceptTextColor),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                    const SizedBox(height: Dimensions.space30),
                    Text(
                      "${LocalStrings.appVersion} 1.0.0",
                      style: semiBoldSmall.copyWith(
                          color: ColorResources.borderColor),
                    ),
                    const SizedBox(height: Dimensions.space10),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Dispose animation login button border
  @override
  void dispose() {
    myAccountController.animationController.dispose();
    super.dispose();
  }
}
