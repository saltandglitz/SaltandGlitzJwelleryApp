import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/data/product/product_controller.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/common_button.dart';
import '../../components/network_connectivity_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final mainController = Get.put<MainController>(MainController());
  final productController = Get.put<ProductController>(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// Search text field keyboard closed set conditioned to analysis which type of users search products
    // ignore: deprecated_member_use
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      // Keyboard is visible.
    } else {
      // Keyboard is not visible.
      print("Keyboard_Un_Visible");
      if (productController.search.text != '') {
        AppAnalytics().actionTriggerSearchProductLogs(
            eventName: LocalStrings.logProductSearch,
            searchProduct:
                "${productController.search.text.trim()}_${LocalStrings.logProductSearch}",
            index: 6);
      }
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: GetBuilder(
          init: ProductController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: ColorResources.scaffoldBackgroundColor,
              appBar: AppBarBackground(
                additionalHeight: 48.0, // Height of TabBar
                isShowTabBar: true,

                tabBarWidget: Column(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      color: ColorResources.whiteColor,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: controller.search,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        style: mediumDefault.copyWith(
                            color: ColorResources.conceptTextColor),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search,
                              size: 20, color: ColorResources.conceptTextColor),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            borderSide: const BorderSide(
                              color: ColorResources.conceptTextColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            borderSide: const BorderSide(
                              color: ColorResources.conceptTextColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            borderSide: const BorderSide(
                              color: ColorResources.conceptTextColor,
                              width: 2,
                            ),
                          ),
                          hintText: LocalStrings.search,
                          hintStyle: mediumDefault.copyWith(
                              color: ColorResources.borderColor),
                        ),
                      ),
                    ),
                  ],
                ),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  // title: Text(
                  //     "${LocalStrings.shoppingCart} (${addCartController.productsImage.length})"),
                  // titleTextStyle: regularLarge.copyWith(
                  //   fontWeight: FontWeight.w500,
                  //   color: ColorResources.conceptTextColor,
                  // ),
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.favorite_border_rounded,
                          color: ColorResources.iconColor),
                    ),
                    const SizedBox(width: Dimensions.space15),
                    GestureDetector(
                      onTap: mainController.isNetworkConnection?.value ==
                          false
                          ? null
                          : () {
                        /// Product name now static but when integration dynamic data set product name dynamic
                        AppAnalytics()
                            .actionTriggerWithProductsLogs(
                            eventName: LocalStrings
                                .logProductChatWithUs,
                            productName:
                            LocalStrings.goldenRing,
                            productImage:
                            controller.imageUrls[0],
                            index: 6);
                        Get.back();
                      },
                      child: const Icon(Icons.person_outline_outlined,
                          color: ColorResources.iconColor),
                    ),
                    const SizedBox(width: Dimensions.space15),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.shopping_cart_rounded,
                          color: ColorResources.iconColor),
                    ),
                    const SizedBox(width: Dimensions.space15),
                  ],
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: ColorResources.conceptTextColor,
                    ),
                  ),
                  backgroundColor: ColorResources.whiteColor,
                  // Set the background color of the AppBar
                  elevation: 0, // Remove default shadow
                ),
              ),
              bottomSheet: Container(
                height: size.height * 0.080,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: ColorResources.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.borderColor,
                      offset: Offset(0, 1),
                      // Position the shadow below the AppBar
                      blurRadius: 2, // Adjust the blur radius as needed
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Common Place order button
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.back();
                        },
                        height: size.height * 0.050,
                        buttonColor: ColorResources.buttonColorDark,
                        gradientFirstColor: ColorResources.offerThirdTextColor,
                        gradientSecondColor: ColorResources.offerThirdTextColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_shopping_cart,
                              size: 15,
                              color: ColorResources.buttonColorDark,
                            ),
                            const SizedBox(width: Dimensions.space5),
                            Text(
                              LocalStrings.addTpCart,
                              style: semiBoldDefault.copyWith(
                                  color: ColorResources.buttonColorDark),
                            ),
                          ],
                        ),
                      ),
                    ), // Common Place order button
                    const SizedBox(width: Dimensions.space15),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.back();
                        },
                        height: size.height * 0.050,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.bag,
                              size: 15,
                              color: ColorResources.whiteColor,
                            ),
                            const SizedBox(width: Dimensions.space5),
                            Text(
                              LocalStrings.buyNow,
                              style: semiBoldDefault.copyWith(
                                  color: ColorResources.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: GetBuilder(
                  init: MainController(),
                  builder: (mainController) {
                    return mainController.isNetworkConnection?.value == false
                        ? NetworkConnectivityView(
                            onTap: () async {
                              RxBool? isEnableNetwork = await mainController
                                  .checkToAssignNetworkConnections();

                              if (isEnableNetwork!.value == true) {
                                productController.enableNetworkHideLoader();
                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Get.put<ProductController>(
                                        ProductController());
                                    productController
                                        .disableNetworkLoaderByDefault();
                                  },
                                );
                                productController.update();
                              }
                            },
                            isLoading: productController.isEnableNetwork,
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.40,
                                  width: double.infinity,
                                  color: ColorResources.borderColor
                                      .withOpacity(0.1),
                                  child: CarouselSlider.builder(
                                    key: const PageStorageKey(
                                        'carousel_slider_key'),
                                    carouselController:
                                        controller.carouselController,
                                    // Add PageStorageKey
                                    itemCount: controller.imageUrls.length,
                                    options: CarouselOptions(
                                      onPageChanged: controller.onPageChanged,
                                      enlargeCenterPage: true,
                                      aspectRatio: 1 / 1.30,
                                      viewportFraction: 1,
                                    ),
                                    itemBuilder: (BuildContext context,
                                        int index, int realIndex) {
                                      return Image.asset(
                                          controller.imageUrls[index]);
                                    },
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space10),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      controller.imageUrls.length,
                                      (i) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 7,
                                          vertical: 15,
                                        ),
                                        child: CircleAvatar(
                                          radius: 4,
                                          backgroundColor:
                                              controller.currentIndex.value == i
                                                  ? ColorResources
                                                      .conceptTextColor
                                                  : Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Image scrolling CarouselSlider show and on clicked show upper chnage image
                                // Obx(() => Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: List.generate(
                                //         controller.imageUrls.length,
                                //         (i) => Stack(
                                //           alignment: Alignment.bottomLeft,
                                //           children: [
                                //             GestureDetector(
                                //               onTap: () {
                                //                 controller.goToPage(
                                //                     i); // Navigate to selected page
                                //               },
                                //               child: Container(
                                //                 height: size.height * 0.050,
                                //                 width: size.width * 0.10,
                                //                 margin: const EdgeInsets.only(right: 10),
                                //                 decoration: BoxDecoration(
                                //                   borderRadius: BorderRadius.circular(
                                //                       Dimensions.smallRadius),
                                //                   boxShadow: const [
                                //                     BoxShadow(
                                //                       color: ColorResources.borderColor,
                                //                       offset: Offset(0.0, 1.0), //(x,y)
                                //                       blurRadius: 1,
                                //                     ),
                                //                   ],
                                //                   color: controller.currentIndex.value == i
                                //                       ? ColorResources.borderColor
                                //                       : ColorResources.whiteColor,
                                //                 ),
                                //                 child: Center(
                                //                     child: Image.asset(
                                //                   controller.imageUrls[i],
                                //                   height: 50,
                                //                   width: 50,
                                //                 )),
                                //               ),
                                //             ),
                                //             controller.currentIndex.value == i
                                //                 ? Container(
                                //                     height: size.height * 0.009,
                                //                     width: size.width * 0.10,
                                //                     decoration: const BoxDecoration(
                                //                       borderRadius: BorderRadius.only(
                                //                           bottomLeft: Radius.circular(
                                //                               Dimensions.smallRadius),
                                //                           bottomRight: Radius.circular(
                                //                               Dimensions.smallRadius)),
                                //                       color: ColorResources.buttonColorDark,
                                //                     ),
                                //                   )
                                //                 : const SizedBox(),
                                //           ],
                                //         ),
                                //       ),
                                //     )),
                                const SizedBox(height: Dimensions.space15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                LocalStrings.goldenRing,
                                                maxLines: 2,
                                                softWrap: true,
                                                style: semiBoldMediumLarge
                                                    .copyWith(),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.05,
                                              width: size.width * 0.090,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.smallRadius),
                                                color: ColorResources
                                                    .borderColor
                                                    .withOpacity(0.1),
                                              ),
                                              child: Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .isFavoritesMethod();
                                                  },
                                                  child: Icon(
                                                    controller.isFavorites
                                                        ? Icons.favorite_rounded
                                                        : Icons
                                                            .favorite_border_rounded,
                                                    color: ColorResources
                                                        .conceptTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "₹${LocalStrings.priceProductItemFirst}",
                                            maxLines: 2,
                                            softWrap: true,
                                            style:
                                                semiBoldMediumLarge.copyWith()),
                                        const SizedBox(
                                            height: Dimensions.space10),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    LocalStrings.priceInclusive,
                                                style: mediumLarge.copyWith(
                                                    color: ColorResources
                                                        .buttonColorDark),
                                              ),
                                              TextSpan(
                                                text:
                                                    " ${LocalStrings.priceBreakup}",
                                                style: mediumDefault.copyWith(
                                                    color: ColorResources
                                                        .deliveryColorColor),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        /// Product name now static but when integration dynamic data set product name dynamic
                                                        AppAnalytics().actionTriggerWithProductsLogs(
                                                            eventName: LocalStrings
                                                                .logProductPriceBreakupClick,
                                                            productName:
                                                            LocalStrings
                                                                .goldenRing,
                                                            productImage:
                                                            controller
                                                                .imageUrls[0],
                                                            index: 6);
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space5),
                                        GestureDetector(
                                         onTap: () {
                                           /// Product name now static but when integration dynamic data set product name dynamic
                                           AppAnalytics()
                                               .actionTriggerWithProductsLogs(
                                               eventName: LocalStrings
                                                   .logProductSpecialOfferClick,
                                               productName:
                                               LocalStrings.goldenRing,
                                               productImage:
                                               controller.imageUrls[0],
                                               index: 6);
                                         },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                MyImages.discountImage,
                                                height: 15,
                                                width: 15,
                                                color: ColorResources
                                                    .deliveryColorColor,
                                              ),
                                              const SizedBox(
                                                  width: Dimensions.space5),
                                              Text(
                                                LocalStrings.specialOffer,
                                                style: mediumSmall.copyWith(
                                                  color: ColorResources
                                                      .deliveryColorColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // ClipPath(
                                        //   clipper: ZigzagClipper(),
                                        //   child: Container(
                                        //     color:
                                        //         ColorResources.borderColor.withOpacity(0.2),
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 16, vertical: 10),
                                        //     child: Row(
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         RichText(
                                        //             text: TextSpan(
                                        //           children: [
                                        //             TextSpan(
                                        //               text: LocalStrings.getOfferId,
                                        //               style: boldSmall.copyWith(
                                        //                   color: ColorResources
                                        //                       .buttonColorDark),
                                        //             ),
                                        //             TextSpan(
                                        //               text: LocalStrings.useJb,
                                        //               style: mediumSmall.copyWith(
                                        //                   color: ColorResources
                                        //                       .buttonColorDark),
                                        //             ),
                                        //           ],
                                        //         )),
                                        //         const Spacer(),
                                        //         GestureDetector(
                                        //           onTap: () {},
                                        //           child: Text(
                                        //             LocalStrings.apply,
                                        //             style: mediumSmall.copyWith(
                                        //                 color: ColorResources
                                        //                     .deliveryColorColor,
                                        //                 decoration:
                                        //                     TextDecoration.underline),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocalStrings.color,
                                              style: mediumDefault.copyWith(),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: size.height * 0.020,
                                              child: ListView.builder(
                                                itemCount:
                                                    controller.colorLst.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .colorSelectionJewellery(
                                                              index);
                                                    },
                                                    child: Tooltip(
                                                      message: controller
                                                              .goldTypeMessageLst[
                                                          index],
                                                      verticalOffset: -45,
                                                      child: Container(
                                                        height:
                                                            size.height * 0.020,
                                                        width:
                                                            size.width * 0.050,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: controller
                                                              .colorLst[index],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child: controller
                                                                      .colorCurrentIndex
                                                                      .value ==
                                                                  index
                                                              ? const Icon(
                                                                  Icons.check,
                                                                  size: 12,
                                                                  color: ColorResources
                                                                      .whiteColor,
                                                                )
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              LocalStrings.purity,
                                              style: mediumDefault.copyWith(),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: size.height * 0.040,
                                              child: ListView.builder(
                                                itemCount:
                                                    controller.ctLst.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .ktSelectionJewellery(
                                                              index);
                                                    },
                                                    child: Tooltip(
                                                      message: controller
                                                              .ktTypeMessageLst[
                                                          index],
                                                      verticalOffset: -50,
                                                      child: Container(
                                                        height:
                                                            size.height * 0.040,
                                                        width:
                                                            size.width * 0.13,
                                                        margin: EdgeInsets.only(
                                                            right: index !=
                                                                    controller
                                                                            .ctLst
                                                                            .length -
                                                                        1
                                                                ? 10
                                                                : 0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: controller
                                                                      .ktCurrentIndex
                                                                      .value ==
                                                                  index
                                                              ? ColorResources
                                                                  .buttonColorDark
                                                              : ColorResources
                                                                  .borderColor
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .smallRadius),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            controller
                                                                .ctLst[index],
                                                            style: mediumSmall.copyWith(
                                                                color: controller
                                                                            .ktCurrentIndex.value ==
                                                                        index
                                                                    ? ColorResources
                                                                        .whiteColor
                                                                    : ColorResources
                                                                        .buttonColorDark),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space5),
                                        Text(
                                          LocalStrings.sizeInches,
                                          style: boldLarge.copyWith(),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space10),
                                        GestureDetector(
                                          onTap: () {
                                            /// Product name now static but when integration dynamic data set product name dynamic
                                            AppAnalytics()
                                                .actionTriggerWithProductsLogs(
                                                eventName: LocalStrings
                                                    .logProductDeliveryCancellationClick,
                                                productName:
                                                LocalStrings.goldenRing,
                                                productImage:
                                                controller.imageUrls[0],
                                                index: 6);
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  MyImages.deliveryImage,
                                                  height: 20),
                                              const SizedBox(
                                                  width: Dimensions.space10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Text(
                                                  LocalStrings
                                                      .deliveryCancellation,
                                                  style: mediumSmall.copyWith(
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space15),
                                        Container(
                                          width: double.infinity,
                                          color: ColorResources.borderColor
                                              .withOpacity(0.1),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 10),
                                          child: Text(
                                            LocalStrings.productDetails,
                                            style: mediumLarge.copyWith(),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space15),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: size.height * 0.23,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .categoriesRadius),
                                                    border: Border.all(
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                        width: 2)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          MyImages.weightImage,
                                                          height: 15,
                                                        ),
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .space7),
                                                        Text(
                                                          LocalStrings.weight,
                                                          style: mediumDefault
                                                              .copyWith(),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            Dimensions.space15),
                                                    Text(
                                                      LocalStrings.gross,
                                                      style: mediumDefault
                                                          .copyWith(),
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            Dimensions.space5),
                                                    Text(
                                                      LocalStrings.net,
                                                      style: mediumDefault
                                                          .copyWith(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width: Dimensions.space30),
                                            Expanded(
                                              child: Container(
                                                height: size.height * 0.23,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .categoriesRadius),
                                                    border: Border.all(
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                        width: 2)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorResources
                                                                    .borderColor
                                                                    .withOpacity(
                                                                        0.3),
                                                                width: 2),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: Dimensions
                                                                .space7),
                                                        Text(
                                                          LocalStrings
                                                              .purityText,
                                                          style: mediumDefault
                                                              .copyWith(),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            Dimensions.space15),
                                                    Text(
                                                      LocalStrings.ktGold,
                                                      style: mediumDefault
                                                          .copyWith(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        Container(
                                          height: size.height * 0.22,
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .categoriesRadius),
                                              border: Border.all(
                                                  color: ColorResources
                                                      .buttonColorDark,
                                                  width: 2)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      MyImages.gemstoneImage,
                                                      height: 20),
                                                  const SizedBox(
                                                      width: Dimensions.space7),
                                                  Text(
                                                    LocalStrings
                                                        .diamondGemstone,
                                                    style: mediumDefault
                                                        .copyWith(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    LocalStrings.weightCt,
                                                    style:
                                                        mediumLarge.copyWith(),
                                                  ),
                                                  Text(
                                                    LocalStrings.diamondSecond,
                                                    style:
                                                        mediumLarge.copyWith(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space10),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: controller
                                                      .diamondWeightTableLst
                                                      .length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.25,
                                                          child: Text(
                                                            controller
                                                                    .diamondWeightTableLst[
                                                                index],
                                                            style: semiBoldSmall
                                                                .copyWith(
                                                                    color: ColorResources
                                                                        .borderColor),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space10),
                                                        Container(
                                                          height: size.height *
                                                              0.0010,
                                                          width:
                                                              size.width * 0.25,
                                                          color: ColorResources
                                                              .borderColor
                                                              .withOpacity(0.2),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space10),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.25,
                                                          child: Text(
                                                            controller
                                                                    .diamondWeightTableValueLst[
                                                                index],
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            style: mediumLarge.copyWith(
                                                                color: ColorResources
                                                                    .borderColor),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: Dimensions
                                                                .space10),
                                                        Container(
                                                          height: size.height *
                                                              0.0010,
                                                          width:
                                                              size.width * 0.25,
                                                          color: ColorResources
                                                              .borderColor
                                                              .withOpacity(0.2),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        Container(
                                          height: size.height * 0.0010,
                                          width: double.infinity,
                                          color: ColorResources.borderColor,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          color: ColorResources.borderColor
                                              .withOpacity(0.1),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                LocalStrings.priceBreakupUpper,
                                                style: mediumLarge.copyWith(),
                                              ),
                                              Text(
                                                "-",
                                                style: mediumLarge.copyWith(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                          itemCount:
                                              controller.breakupItemLst.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      controller.breakupItemLst[
                                                          index],
                                                      style: mediumDefault
                                                          .copyWith(
                                                              color: ColorResources
                                                                  .borderColor),
                                                    ),
                                                    Text(
                                                      controller
                                                              .breakupItemPriceLst[
                                                          index],
                                                      style: mediumDefault
                                                          .copyWith(
                                                              color: ColorResources
                                                                  .borderColor),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height: Dimensions.space5),
                                                Container(
                                                  height: size.height * 0.0010,
                                                  width: double.infinity,
                                                  color: ColorResources
                                                      .borderColor
                                                      .withOpacity(0.3),
                                                ),
                                                const SizedBox(
                                                    height: Dimensions.space5),
                                              ],
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Text(
                                            LocalStrings.estimatedPrice,
                                            style: semiBoldDefault.copyWith(
                                                color: ColorResources
                                                    .buttonColorDark),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space5),
                                        Container(
                                          height: size.height * 0.0010,
                                          width: double.infinity,
                                          color: ColorResources.borderColor
                                              .withOpacity(0.3),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space20),
                                        Container(
                                          width: double.infinity,
                                          color: ColorResources.borderColor
                                              .withOpacity(0.1),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 10),
                                          child: Text(
                                            LocalStrings.ourPromise,
                                            style: mediumLarge.copyWith(),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space15),
                                        GridView.builder(
                                          itemCount:
                                              controller.promiseImageLst.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 7 / 3),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  controller
                                                      .promiseImageLst[index],
                                                  height: size.height * 0.050,
                                                ),
                                                const SizedBox(
                                                    height: Dimensions.space5),
                                                Text(
                                                  controller
                                                      .promiseNameLst[index],
                                                  style: mediumDefault.copyWith(
                                                      color: ColorResources
                                                          .conceptTextColor),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                            height: Dimensions.space15),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 30),
                                          color: ColorResources.activeCardColor
                                              .withOpacity(0.3),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                LocalStrings.certificate,
                                                style: semiBoldMediumLarge
                                                    .copyWith(
                                                        color: ColorResources
                                                            .conceptTextColor),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space15),
                                              RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: LocalStrings
                                                            .jewelleryCertified,
                                                        style: mediumLarge.copyWith(
                                                            color: ColorResources
                                                                .conceptTextColor),
                                                      ),
                                                      TextSpan(
                                                        text: LocalStrings.sgl,
                                                        style: semiBoldLarge.copyWith(
                                                            color: ColorResources
                                                                .buttonColorDark),
                                                      ),
                                                      TextSpan(
                                                        text: LocalStrings.and,
                                                        style: mediumLarge.copyWith(
                                                            color: ColorResources
                                                                .conceptTextColor),
                                                      ),
                                                      TextSpan(
                                                        text: LocalStrings.igl,
                                                        style: semiBoldLarge.copyWith(
                                                            color: ColorResources
                                                                .buttonColorDark),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: size.height * 0.090),
                              ],
                            ),
                          );
                  }),
            );
          }),
    );
  }
}

class ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const int numberOfPoints = 5;
    final double segmentHeight = size.height / (numberOfPoints * 2);

    // Start at the top-left corner
    path.moveTo(0, 0);

    // Draw the top horizontal line
    path.lineTo(size.width, 0);

    // Draw the right side zigzag
    for (int i = 0; i < numberOfPoints; i++) {
      double dx = i.isEven ? size.width - 10 : size.width + 10;
      path.lineTo(dx, segmentHeight * (2 * i + 1));
    }
    path.lineTo(size.width, size.height);

    // Draw the bottom horizontal line
    path.lineTo(0, size.height);

    // Draw the left side zigzag
    for (int i = numberOfPoints - 1; i >= 0; i--) {
      double dx = i.isEven ? 10 : -10;
      path.lineTo(dx, segmentHeight * (2 * i + 1));
    }
    path.lineTo(0, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
