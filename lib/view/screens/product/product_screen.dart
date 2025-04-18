import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/data/controller/collection/collection_controller.dart';
import 'package:saltandGlitz/data/product/product_controller.dart';
import 'package:saltandGlitz/local_storage/pref_manager.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/model/get_rating_view_model.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';
import '../../components/common_button.dart';
import '../../components/common_textfield.dart';
import '../../components/network_connectivity_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final mainController = Get.put<MainController>(MainController());
  final productController = Get.put<ProductController>(ProductController());
  final collectionController =
      Get.put<CollectionController>(CollectionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();
    if (Get.arguments != null) {
      productController.productData = Get.arguments[0];
      productController.collectionIndex = Get.arguments[1];
      // print("Products Data :${productController.productData?.media?.length}");
      Future.delayed(const Duration(milliseconds: 100), () {
        productController.getRatingApiMethod(
            productId: productController.productData?.productId);
      });
    }
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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        productController.currentIndex.value = 0;
      },
      child: GestureDetector(
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
                        onTap: () {
                          Get.toNamed(RouteHelper.wishlistScreen);
                        },
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
                                AppAnalytics().actionTriggerWithProductsLogs(
                                    eventName:
                                        LocalStrings.logProductChatWithUs,
                                    productName: controller.productData?.title,
                                    productImage: controller
                                        .productData?.media?[0].productAsset,
                                    index: 6);
                                Get.toNamed(RouteHelper.loginScreen);
                              },
                        child: const Icon(Icons.person_outline_outlined,
                            color: ColorResources.iconColor),
                      ),
                      const SizedBox(width: Dimensions.space15),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.addCartScreen);
                        },
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
                              List<String>? getCartListProductId =
                                  PrefManager.getStringList('cartProductId');
                              if (getCartListProductId != null &&
                                      getCartListProductId.contains(
                                          controller.productData!.productId) ||
                                  controller.productData.isCart == true) {
                                Get.toNamed(RouteHelper.addCartScreen);
                              } else {
                                controller.addToCartApiMethod(
                                  productId: controller.productData!.productId,
                                  quantity: 1,
                                  carat: controller.jewelleryKt(),
                                  size: controller.byDefaultRingSize.value,
                                  color: controller.jewelleryColor(),
                                );
                              }
                            },
                            height: size.height * 0.050,
                            buttonColor: ColorResources.buttonColorDark,
                            gradientFirstColor:
                                ColorResources.offerThirdTextColor,
                            gradientSecondColor:
                                ColorResources.offerThirdTextColor,
                            child: Obx(
                              () {
                                return controller.isAddToCart.value == true
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: CircularProgressIndicator(
                                              color: ColorResources
                                                  .bottomSheetContainerColor),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_shopping_cart,
                                            size: 15,
                                            color:
                                                ColorResources.buttonColorDark,
                                          ),
                                          const SizedBox(
                                              width: Dimensions.space5),
                                          Text(
                                            LocalStrings.addToCart,
                                            style: semiBoldDefault.copyWith(
                                                color: ColorResources
                                                    .buttonColorDark),
                                          ),
                                        ],
                                      );
                              },
                            )),
                      ), // Common Place order button
                      const SizedBox(width: Dimensions.space15),
                      Expanded(
                        child: CommonButton(
                            onTap: () {
                              List<String>? getCartListProductId =
                                  PrefManager.getStringList('cartProductId');
                              print(
                                  "Get stored cart id : $getCartListProductId");
                              if (getCartListProductId != null &&
                                      getCartListProductId.contains(
                                          controller.productData!.productId) ||
                                  controller.productData.isCart == true) {
                                Get.toNamed(RouteHelper.addCartScreen);
                              } else {
                                controller.addToCartApiMethod(
                                  productId: controller.productData!.productId,
                                  quantity: 1,
                                  carat: controller.jewelleryKt(),
                                  size: controller.byDefaultRingSize.value,
                                  color: controller.jewelleryColor(),
                                  cartType: LocalStrings.buyNow,
                                );
                              }
                            },
                            height: size.height * 0.050,
                            child: Obx(
                              () {
                                return controller.isBuyNowCart.value == true
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: CircularProgressIndicator(
                                              color: ColorResources
                                                  .bottomSheetContainerColor),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.bag,
                                            size: 15,
                                            color: ColorResources.whiteColor,
                                          ),
                                          const SizedBox(
                                              width: Dimensions.space5),
                                          Text(
                                            LocalStrings.buyNow,
                                            style: semiBoldDefault.copyWith(
                                                color:
                                                    ColorResources.whiteColor),
                                          ),
                                        ],
                                      );
                              },
                            )),
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
                                    color: ColorResources.borderColor.withOpacity(0.1),
                                    child: CarouselSlider.builder(
                                      key: const PageStorageKey(
                                          'carousel_slider_key'),
                                      carouselController:
                                          controller.carouselController,
                                      itemCount: controller
                                              .productData?.media?.length ??
                                          0,
                                      options: CarouselOptions(
                                        onPageChanged: (index, reason) {
                                          controller.onPageChanged(
                                              index, reason);
                                          controller.currentIndex.value =
                                              index; // Update current index on page change
                                          controller.handleMediaPlayback(
                                              index); // Handle media playback when the page changes
                                        },
                                        enlargeCenterPage: true,
                                        aspectRatio: 1 / 1.30,
                                        viewportFraction: 1,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        final media = controller
                                            .productData?.media?[index];
                                        final mediaType = media?.type;

                                        if (mediaType == 'goldImage') {
                                          // Show image
                                          return CachedCommonImage(
                                            networkImageUrl:
                                                media?.productAsset ?? '',
                                            width: double.infinity,
                                          );
                                        } else if (mediaType == 'goldVideo') {
                                          // Show video player if it's the current index and the video is initialized
                                          return controller
                                                      .currentIndex.value ==
                                                  index
                                              ? controller
                                                          .videoController
                                                          ?.value
                                                          .isInitialized ==
                                                      true
                                                  ? _buildVideoPlayer(controller
                                                      .videoController)
                                                  : Shimmer.fromColors(
                                                      baseColor: ColorResources
                                                          .baseColor,
                                                      highlightColor:
                                                          ColorResources
                                                              .highlightColor,
                                                      child: Container(
                                                        height:
                                                            size.height * 0.40,
                                                        width: double.infinity,
                                                        color: ColorResources
                                                            .inactiveTabColor,
                                                      ),
                                                    )
                                              : Container(); // Empty container when not the selected video
                                        }

                                        return Container(); // Fallback for unsupported media types
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: Dimensions.space10),

                                  // Indicator Row showing either the circle for image or play icon for video
                                  Obx(
                                    () {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          controller
                                                  .productData?.media?.length ??
                                              0,
                                          (i) {
                                            final media = controller
                                                .productData?.media?[i];
                                            final isVideo =
                                                media?.type == 'goldVideo';

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 15),
                                              child: /* isVideo
                                                ? // If it's a video, show play icon when the current index is this video
                                            controller.currentIndex.value == i
                                                ? Icon(
                                              Icons.play_arrow,
                                              color: ColorResources.conceptTextColor,
                                              size: 18,
                                            )
                                                : Container()  // Empty container when video is not playing
                                                : */ // For image indicators
                                                  isVideo
                                                      ? Icon(
                                                          Icons.play_arrow,
                                                          color: controller
                                                                      .currentIndex
                                                                      .value ==
                                                                  i
                                                              ? ColorResources
                                                                  .conceptTextColor
                                                              : Colors.grey
                                                                  .shade300,
                                                          size: 18,
                                                        )
                                                      : CircleAvatar(
                                                          radius: 4,
                                                          backgroundColor: controller
                                                                      .currentIndex
                                                                      .value ==
                                                                  i
                                                              ? ColorResources
                                                                  .conceptTextColor
                                                              : Colors.grey
                                                                  .shade300,
                                                        ),
                                            );
                                          },
                                        ),
                                      );
                                    },
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
                                                  controller
                                                          .productData?.title ??
                                                      '',
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: semiBoldMediumLarge
                                                      .copyWith(),
                                                ),
                                              ),
                                              Container(
                                                height: size.height * 0.05,
                                                width: size.width * 0.099,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .smallRadius),
                                                  color: ColorResources
                                                      .borderColor
                                                      .withOpacity(0.1),
                                                ),
                                                child: LikeButton(
                                                  circleColor:
                                                      const CircleColor(
                                                    start: Color(0xff00ddff),
                                                    end: Color(0xff0099cc),
                                                  ),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor:
                                                        ColorResources
                                                            .notValidateColor,
                                                    dotSecondaryColor:
                                                        ColorResources
                                                            .notValidateColor,
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4, top: 2),
                                                      child: Icon(
                                                          controller.productData
                                                                      ?.isAlready ==
                                                                  true
                                                              ? Icons
                                                                  .favorite_rounded
                                                              : Icons
                                                                  .favorite_border,
                                                          color: controller
                                                                      .productData
                                                                      ?.isAlready ==
                                                                  true
                                                              ? ColorResources
                                                                  .notValidateColor
                                                              : ColorResources
                                                                  .inactiveTabColor,
                                                          size: 25),
                                                    );
                                                  },
                                                  onTap: (isLiked) async {
                                                    if (controller.productData
                                                            ?.isAlready ==
                                                        true) {
                                                      //Todo : Remove Wishlist particular products api method
                                                      collectionController
                                                          .removeWishlistApiMethod(
                                                              productId: controller
                                                                  .productData
                                                                  .productId);
                                                      controller.productData
                                                          .isAlready = false;
                                                      controller.update();
                                                    } else {
                                                      controller.productData
                                                          .isAlready = true;
                                                      controller.update();
                                                      //Todo : Wishlist particular products api method
                                                      collectionController.favoritesProducts(
                                                          userId: PrefManager.getString('userId') ??'',
                                                          productId: controller
                                                              .productData
                                                              .productId,
                                                          index: controller
                                                              .collectionIndex,
                                                          size: controller
                                                              .productData
                                                              .netWeight14KT
                                                              ?.toInt(),
                                                          carat:
                                                              productController
                                                                  .jewelleryKt(),
                                                          color: productController
                                                              .jewelleryColor());
                                                      print(
                                                          "Is wishlist already");
                                                    } // If user is logged in, proceed with like/unlike logic
                                                    return !isLiked; // toggle like/unlike
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          controller.getRatingViewModel != null
                                              ? Theme(
                                                  data: ThemeData(
                                                    splashColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: StarRating(
                                                    rating: controller
                                                                .getRatingViewModel !=
                                                            null
                                                        ? double.parse(controller
                                                            .getRatingViewModel!
                                                            .averageRating!)
                                                        : double.parse(
                                                            LocalStrings
                                                                .byDefaultRating),
                                                    size: 25,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    starCount: 5,
                                                    borderColor: ColorResources
                                                        .blackColor,
                                                    color: ColorResources
                                                        .updateCardColor,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          SizedBox(
                                              height: controller
                                                          .getRatingViewModel !=
                                                      null
                                                  ? Dimensions.space10
                                                  : 0),
                                          Text(
                                              "₹${controller.productData?.total14KT.round()}",
                                              maxLines: 2,
                                              softWrap: true,
                                              style: semiBoldMediumLarge
                                                  .copyWith()),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: LocalStrings
                                                      .priceInclusive,
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
                                                              eventName:
                                                                  LocalStrings
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
                                                      productName: LocalStrings
                                                          .goldenRing,
                                                      productImage: controller
                                                          .imageUrls[0],
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
                                                  itemCount: controller
                                                      .colorLst.length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
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
                                                          height: size.height *
                                                              0.020,
                                                          width: size.width *
                                                              0.050,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: controller
                                                                    .colorLst[
                                                                index],
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
                                                  itemBuilder:
                                                      (context, index) {
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
                                                          height: size.height *
                                                              0.040,
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
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .smallRadius),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              controller
                                                                  .ctLst[index],
                                                              style: mediumSmall.copyWith(
                                                                  color: controller
                                                                              .ktCurrentIndex
                                                                              .value ==
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
                                          //Ring & Bracelet size selection
                                          Row(
                                            children: [
                                              Text(
                                                LocalStrings.sizeWithoutDots,
                                                style: mediumDefault.copyWith(),
                                              ),
                                              const Spacer(),
                                              Obx(() {
                                                return Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          Dimensions
                                                              .smallRadius,
                                                        ),
                                                      ),
                                                      color: ColorResources
                                                          .borderColor
                                                          .withOpacity(0.2),
                                                      shape:
                                                          BoxShape.rectangle),
                                                  child: Theme(
                                                    data: ThemeData(
                                                      splashColor:
                                                          Colors.transparent,
                                                      // Used to drop down selection splash color remover
                                                      highlightColor: Colors
                                                          .transparent, // Used to drop down selection splash color remover
                                                    ),
                                                    child: DropdownButton<int>(
                                                      elevation: 0,
                                                      underline:
                                                          const SizedBox(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .smallRadius),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      style: boldMediumLarge.copyWith(
                                                          color: ColorResources
                                                              .buttonColorDark),
                                                      value: controller
                                                          .byDefaultRingSize
                                                          .value,
                                                      // Default value is 6
                                                      items: controller.ringSize
                                                          .map(
                                                        (value) {
                                                          return DropdownMenuItem<
                                                              int>(
                                                            value: value,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          3),
                                                              child: Center(
                                                                child: Text(
                                                                  '$value',
                                                                  style: boldMediumLarge
                                                                      .copyWith(
                                                                          color:
                                                                              ColorResources.buttonColorDark),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                      onChanged: (value) {
                                                        print(
                                                            "Ring Size00: $value");
                                                        // Update the ring size value when changed
                                                        controller
                                                            .ringSizeOnChangValue(
                                                                value);
                                                      },
                                                      iconEnabledColor:
                                                          Colors.black,
                                                      // Dropdown icon color
                                                      iconDisabledColor: Colors
                                                          .grey, // Disabled state color
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //     height: Dimensions.space5),
                                          // Text(
                                          //   LocalStrings.sizeInches,
                                          //   style: boldLarge.copyWith(),
                                          // ),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          GestureDetector(
                                            onTap: () {
                                              /// Product name now static but when integration dynamic data set product name dynamic
                                              AppAnalytics()
                                                  .actionTriggerWithProductsLogs(
                                                      eventName: LocalStrings
                                                          .logProductDeliveryCancellationClick,
                                                      productName: LocalStrings
                                                          .goldenRing,
                                                      productImage: controller
                                                          .imageUrls[0],
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Text(
                                                    LocalStrings
                                                        .deliveryCancellation,
                                                    style: mediumSmall.copyWith(
                                                        decoration:
                                                            TextDecoration
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .categoriesRadius),
                                                    border: Border.all(
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            MyImages
                                                                .weightImage,
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
                                                          height: Dimensions
                                                              .space10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            LocalStrings.gross,
                                                            style: mediumSmall
                                                                .copyWith(),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${controller.productData?.grossWt} gram",
                                                              softWrap: true,
                                                              style: mediumSmall
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            LocalStrings.net,
                                                            style: mediumSmall
                                                                .copyWith(),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${controller.productData?.netWeight14KT} gram",
                                                              softWrap: true,
                                                              style: mediumSmall
                                                                  .copyWith(),
                                                            ),
                                                          ),
                                                        ],
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .categoriesRadius),
                                                    border: Border.all(
                                                        color: ColorResources
                                                            .buttonColorDark,
                                                        width: 2),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              shape: BoxShape
                                                                  .circle,
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
                                                          height: Dimensions
                                                              .space15),
                                                      Text(
                                                        "${controller.ktCurrentIndex.value == 0 ? '14' : '18'}${LocalStrings.ktGold}",
                                                        style: mediumSmall
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
                                                        width:
                                                            Dimensions.space7),
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
                                                      style: mediumLarge
                                                          .copyWith(),
                                                    ),
                                                    Text(
                                                      LocalStrings
                                                          .diamondSecond,
                                                      style: mediumLarge
                                                          .copyWith(),
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
                                                            width: size.width *0.27,
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
                                                          const SizedBox(height:Dimensions.space10),
                                                          Container(
                                                            height:size.height *0.0010,
                                                            width: size.width *0.25,
                                                            color: ColorResources.borderColor.withOpacity(0.2),
                                                          ),
                                                          const SizedBox(height: Dimensions.space10),
                                                          SizedBox(
                                                            width: size.width *0.25,
                                                            child: Text(
                                                              controller.diamondWeightTableValueLst[index],
                                                              softWrap: true,
                                                              maxLines: 2,
                                                              style: mediumLarge.copyWith(color: ColorResources.borderColor),
                                                            ),
                                                          ),
                                                          const SizedBox(height: Dimensions.space10),
                                                          Container(
                                                            height:
                                                                size.height *
                                                                    0.0010,
                                                            width: size.width *
                                                                0.25,
                                                            color: ColorResources
                                                                .borderColor
                                                                .withOpacity(
                                                                    0.2),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  LocalStrings
                                                      .priceBreakupUpper,
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
                                            itemCount: controller
                                                .breakupItemLst.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7),
                                            itemBuilder: (context, index) {
                                              List breakupItemPriceLst = [
                                                controller.ktCurrentIndex
                                                            .value ==
                                                        0
                                                    ? controller
                                                        .productData?.price14KT
                                                    : controller
                                                        .productData?.price18KT,
                                                controller
                                                    .productData?.diamondprice,
                                                controller.ktCurrentIndex
                                                            .value ==
                                                        0
                                                    ? controller.productData
                                                        ?.makingCharge14KT
                                                    : controller.productData
                                                        ?.makingCharge18KT,
                                                controller.ktCurrentIndex
                                                            .value ==
                                                        0
                                                    ? controller
                                                        .productData?.gst14KT
                                                    : controller
                                                        .productData?.gst18KT,
                                                controller.ktCurrentIndex
                                                            .value ==
                                                        0
                                                    ? controller
                                                        .productData?.total14KT
                                                    : controller
                                                        .productData?.total18KT,
                                              ];
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .breakupItemLst[
                                                            index],
                                                        style: mediumDefault.copyWith(
                                                            color: ColorResources
                                                                .borderColor),
                                                      ),
                                                      Text(
                                                        "Rs.${breakupItemPriceLst[index]}",
                                                        style: mediumDefault.copyWith(
                                                            color: ColorResources
                                                                .borderColor),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space5),
                                                  Container(
                                                    height:
                                                        size.height * 0.0010,
                                                    width: double.infinity,
                                                    color: ColorResources
                                                        .borderColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space5),
                                                ],
                                              );
                                            },
                                          ),
                                          /*Padding(
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
                                              height: Dimensions.space5),*/
                                          /*Container(
                                            height: size.height * 0.0010,
                                            width: double.infinity,
                                            color: ColorResources.borderColor
                                                .withOpacity(0.3),
                                          ),*/
                                          SizedBox(
                                            width: double.infinity,
                                            child: Card(
                                                color:
                                                    ColorResources.whiteColor,
                                                shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .smallRadius),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        LocalStrings.review,
                                                        style: boldMediumLarge
                                                            .copyWith(),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space5),
                                                      Container(
                                                        height:
                                                            size.height * 0.095,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .shimmerEffectBaseColor
                                                              .withOpacity(0.3),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .smallRadius),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            StarRating(
                                                              rating: 2.1,
                                                              size: 40,
                                                              starCount: 1,
                                                              allowHalfRating:
                                                                  true,
                                                              borderColor:
                                                                  ColorResources
                                                                      .blackColor,
                                                              color: controller
                                                                          .getRatingViewModel
                                                                          ?.averageRating !=
                                                                      null
                                                                  ? ColorResources
                                                                      .updateCardColor
                                                                  : ColorResources
                                                                      .inactiveTabColor,
                                                            ),
                                                            /* controller.getRatingViewModel
                                                                    ?.averageRating !=
                                                                    null
                                                                    ? double.parse(controller
                                                                    .getRatingViewModel!
                                                                    .averageRating!)
                                                                    : double.parse(LocalStrings
                                                                    .byDefaultRating)*/
                                                            const SizedBox(
                                                                width: Dimensions
                                                                    .space7),
                                                            Text(
                                                              controller.getRatingViewModel
                                                                          ?.averageRating !=
                                                                      null
                                                                  ? controller
                                                                      .getRatingViewModel!
                                                                      .averageRating!
                                                                  : LocalStrings
                                                                      .byDefaultRating,
                                                              style: boldOverLarge
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontOverSmallLarge),
                                                            ),
                                                            const SizedBox(
                                                                width: Dimensions
                                                                    .space25),
                                                            Container(
                                                              height:
                                                                  size.height *
                                                                      0.075,
                                                              width: 2,
                                                              color: ColorResources
                                                                  .borderColor
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                            const SizedBox(
                                                                width: Dimensions
                                                                    .space25),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    controller.getRatingViewModel?.approvedRating !=
                                                                            null
                                                                        ? "${controller.getRatingViewModel!.approvedRating?.length}"
                                                                        : LocalStrings
                                                                            .byDefaultRating,
                                                                    style: boldMediumLarge
                                                                        .copyWith()),
                                                                Text(
                                                                    LocalStrings
                                                                        .review,
                                                                    style: mediumMediumLarge
                                                                        .copyWith()),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space15),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .shimmerEffectBaseColor
                                                              .withOpacity(0.3),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .smallRadius),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Column(
                                                            children: [
                                                              ListView.builder(
                                                                itemCount: 5,
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            10),
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final ratingCountMap =
                                                                      calculateRatingCount(controller
                                                                          .getRatingViewModel
                                                                          ?.approvedRating);
                                                                  final totalCount =
                                                                      getTotalRatings(
                                                                          ratingCountMap);

                                                                  int star =
                                                                      5 - index;
                                                                  int count =
                                                                      ratingCountMap[
                                                                              star] ??
                                                                          0;
                                                                  double
                                                                      percentage =
                                                                      totalCount >
                                                                              0
                                                                          ? count /
                                                                              totalCount
                                                                          : 0.0;

                                                                  return Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "$star",
                                                                            style:
                                                                                boldMediumLarge.copyWith(),
                                                                          ),
                                                                          const Icon(
                                                                              Icons.star,
                                                                              size: 20,
                                                                              color: ColorResources.blackColor),
                                                                          Expanded(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                              child: LinearProgressIndicator(
                                                                                value: percentage,
                                                                                color: ColorResources.blackColor,
                                                                                backgroundColor: Colors.grey[300],
                                                                                minHeight: 9,
                                                                                borderRadius: BorderRadius.circular(Dimensions.smallRadius),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "$count",
                                                                            style:
                                                                                boldMediumLarge.copyWith(),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              Dimensions.space10),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: Dimensions
                                                              .space15),
                                                      Container(
                                                        height:
                                                            size.height * 0.10,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorResources
                                                              .shimmerEffectBaseColor
                                                              .withOpacity(0.3),
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .smallRadius),
                                                        ),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  LocalStrings
                                                                      .clickReview,
                                                                  style: mediumMediumLarge
                                                                      .copyWith()),
                                                              const SizedBox(
                                                                  height:
                                                                      Dimensions
                                                                          .space5),
                                                              Theme(
                                                                data: ThemeData(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                ),
                                                                child:
                                                                    StarRating(
                                                                        rating: controller.userRatingValue != null && controller.userRatingValue!.isNotEmpty
                                                                            ? double.parse(controller
                                                                                .userRatingValue!)
                                                                            : double.parse(LocalStrings
                                                                                .byDefaultRating),
                                                                        size:
                                                                            35,
                                                                        starCount:
                                                                            5,
                                                                        borderColor:
                                                                            ColorResources
                                                                                .blackColor,
                                                                        color: ColorResources
                                                                            .updateCardColor,
                                                                        onRatingChanged:
                                                                            (rating) {
                                                                          if (controller.userRatingValue != null &&
                                                                              controller.userRatingValue!.isNotEmpty) {
                                                                            controller.ratingValue.value =
                                                                                double.parse(controller.userRatingValue!);
                                                                          }

                                                                          /// Show rating dialog box
                                                                          ratingFeedBackDialog(
                                                                              context,
                                                                              productImage: controller.productData?.media?[0].productAsset,
                                                                              productName: controller.productData?.title ?? '',
                                                                              controller: controller,
                                                                              productId: controller.productData?.productId);
                                                                        }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                              height:
                                                  controller.getRatingViewModel !=
                                                              null &&
                                                          controller
                                                              .getRatingViewModel!
                                                              .approvedRating!
                                                              .isNotEmpty
                                                      ? Dimensions.space10
                                                      : 0),
                                          (controller.getRatingViewModel !=
                                                      null &&
                                                  controller
                                                      .getRatingViewModel!
                                                      .approvedRating!
                                                      .isNotEmpty)
                                              ? Container(
                                                  height: size.height * 0.19,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: ColorResources
                                                        .shimmerEffectBaseColor
                                                        .withOpacity(0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .smallRadius),
                                                  ),
                                                  child: ListView.builder(
                                                    itemCount: controller
                                                        .getRatingViewModel
                                                        ?.approvedRating
                                                        ?.length,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: SizedBox(
                                                          width:
                                                              size.width * 0.48,
                                                          child: Card(
                                                            margin:
                                                                EdgeInsets.zero,
                                                            shape: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        Dimensions
                                                                            .smallRadius),
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .transparent)),
                                                            color:
                                                                ColorResources
                                                                    .whiteColor,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          5),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color: ColorResources
                                                                              .activeCardColor
                                                                              .withOpacity(0.3),
                                                                        ),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Text(
                                                                            controller.getRatingViewModel!.approvedRating![index].userId?.firstName?.substring(0, 1) ??
                                                                                '',
                                                                            style:
                                                                                boldExtraLarge.copyWith()),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              Dimensions.space5),
                                                                      Expanded(
                                                                        child: Text(
                                                                            "${controller.getRatingViewModel!.approvedRating![index].userId?.firstName} ${controller.getRatingViewModel!.approvedRating![index].userId?.lastName}",
                                                                            maxLines:
                                                                                2,
                                                                            softWrap:
                                                                                true,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: semiBoldLarge.copyWith()),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height: Dimensions
                                                                          .space3),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      StarRating(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        rating: double.parse(controller
                                                                            .getRatingViewModel!
                                                                            .approvedRating![index]
                                                                            .userRating!),
                                                                        // Use the .value to access the observable
                                                                        size:
                                                                            25,
                                                                        starCount:
                                                                            5,
                                                                        borderColor:
                                                                            ColorResources.blackColor,
                                                                        color: ColorResources
                                                                            .updateCardColor,
                                                                      ),
                                                                      ClipRRect(
                                                                          borderRadius: BorderRadius.circular(Dimensions
                                                                              .defaultRadius),
                                                                          child:
                                                                              Card(
                                                                            margin:
                                                                                EdgeInsets.zero,
                                                                            elevation:
                                                                                5.0,
                                                                            shape:
                                                                                OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius), borderSide: const BorderSide(color: ColorResources.shimmerEffectBaseColor)),
                                                                            child:
                                                                                CachedCommonImage(
                                                                              height: size.height * 0.050,
                                                                              width: size.height * 0.050,
                                                                              networkImageUrl: controller.getRatingViewModel!.approvedRating![index].productImage,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height: Dimensions
                                                                          .space5),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child: Text(
                                                                          "${controller.getRatingViewModel!.approvedRating![index].userReview}",
                                                                          maxLines:
                                                                              1,
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style:
                                                                              mediumDefault.copyWith()),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : const SizedBox(),
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
                                            itemCount: controller
                                                .promiseImageLst.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 10,
                                                    childAspectRatio: 7 / 4),
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
                                                      height:
                                                          Dimensions.space5),
                                                  Text(
                                                    controller
                                                        .promiseNameLst[index],
                                                    textAlign: TextAlign.center,
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
                                          Align(
                                            alignment: Alignment.center,
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: LocalStrings.learnAbout,
                                                style: mediumLarge.copyWith(
                                                    color: ColorResources
                                                        .conceptTextColor),
                                              ),
                                              TextSpan(
                                                text:
                                                    LocalStrings.termsPolicies,
                                                style: boldLarge.copyWith(
                                                    color: ColorResources
                                                        .termsColor),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {},
                                              ),
                                            ])),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space15),
                                          SizedBox(
                                            height: size.height * 0.19,
                                            child: ListView.builder(
                                              itemCount: controller
                                                  .promisePurityImageLst.length,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      controller
                                                              .promisePurityImageLst[
                                                          index],
                                                      height:
                                                          size.height * 0.13,
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            Dimensions.space5),
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                                .promisePurityNameLst[
                                                            index],
                                                        softWrap: true,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        style: mediumDefault.copyWith(
                                                            color: ColorResources
                                                                .conceptTextColor),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space10),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 30),
                                            color: ColorResources
                                                .activeCardColor
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
                                                          text:
                                                              LocalStrings.sgl,
                                                          style: semiBoldLarge.copyWith(
                                                              color: ColorResources
                                                                  .buttonColorDark),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              LocalStrings.and,
                                                          style: mediumLarge.copyWith(
                                                              color: ColorResources
                                                                  .conceptTextColor),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              LocalStrings.igl,
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
      ),
    );
  }

  Widget _buildVideoPlayer(VideoPlayerController? controller) {
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
          child:
              CircularProgressIndicator()); // Show a loading indicator until the video is initialized
    }
    return VideoPlayer(
        controller); // Return the video player widget once it's initialized
  }

  /// Rating FeedBack Dialog
  void ratingFeedBackDialog(BuildContext context,
      {String? productImage,
      String? productName,
      ProductController? controller,
      String? productId}) {
    Get.dialog(barrierDismissible: false, StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: Material(
              color: ColorResources.whiteColor,
              borderRadius: BorderRadius.circular(8),
              elevation: 5.0,
              child: GetBuilder<ProductController>(
                init: ProductController(),
                builder: (controller) {
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                LocalStrings.howItem,
                                style: semiBoldOverLarge.copyWith(),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.feedBack.clear();
                                  },
                                  child: const Icon(Icons.close_rounded,
                                      size: 25)),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Row(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 5.0,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.defaultRadius),
                                      borderSide: const BorderSide(
                                          color: ColorResources
                                              .shimmerEffectBaseColor)),
                                  child: CachedCommonImage(
                                    height: 60,
                                    width: 60,
                                    networkImageUrl: productImage,
                                  ),
                                )),
                            const SizedBox(width: Dimensions.space15),
                            Expanded(
                              child: Text(
                                productName ?? '',
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: semiBoldMediumLarge.copyWith(),
                              ),
                            ),
                          ]),
                          const SizedBox(height: Dimensions.space30),
                          // Wrap only the widget dependent on the rating value
                          Obx(() {
                            return Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                              ),
                              child: StarRating(
                                rating: controller.ratingValue.value,
                                // Use the .value to access the observable
                                size: 35,
                                starCount: 5,
                                borderColor: ColorResources.blackColor,
                                color: ColorResources.updateCardColor,
                                onRatingChanged: (rating) {
                                  controller.ratingUsers(
                                      rating); // Update the rating when it changes
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: Dimensions.space30),
                          RichText(
                              text: TextSpan(
                            children: [
                              TextSpan(
                                text: LocalStrings.feedback,
                                style: semiBoldMediumLarge.copyWith(
                                    color: ColorResources.blackColor),
                              ),
                              TextSpan(
                                text: LocalStrings.feedbackStar,
                                style: semiBoldMediumLarge.copyWith(
                                    color: ColorResources.notValidateColor),
                              ),
                            ],
                          )),
                          const SizedBox(height: Dimensions.space5),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.080,
                            child: CommonTextField(
                              controller: controller.feedBack,
                              hintText: LocalStrings.feedback,
                              hintTexStyle: mediumDefault,
                              borderColor: ColorResources.deliveryColorColor,
                              fillColor: ColorResources.deliveryColorColor
                                  .withOpacity(0.1),
                              maxLines: 5,
                              textColor: ColorResources.blackColor,
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Container(
                            height: controller.pickedImage.value != null
                                ? MediaQuery.of(context).size.height * 0.16
                                : MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                                border: Border.all(
                                    color: ColorResources.borderColor,
                                    width: 1)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.imagePickOptionsDialogBox();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.defaultRadius),
                                          color: ColorResources
                                              .deliveryColorColor
                                              .withOpacity(0.1)),
                                      child: Center(
                                        child: Text(
                                          LocalStrings.addFiles,
                                          style: semiBoldExtraLarge.copyWith(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  controller.pickedImage.value != null
                                      ? const SizedBox()
                                      : Text(
                                          LocalStrings.acceptsImageFormat,
                                          style: semiBoldExtraLarge.copyWith(
                                              color: ColorResources
                                                  .inactiveTabColor),
                                        ),
                                  const SizedBox(height: Dimensions.space5),
                                  controller.pickedImage.value != null
                                      ? Stack(
                                          alignment: Alignment.topRight,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Card(
                                              margin: EdgeInsets.zero,
                                              elevation: 5.0,
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .defaultRadius),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .defaultRadius),
                                                  child: Image.file(
                                                    controller
                                                        .pickedImage.value!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: -7,
                                              right: -7,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.clearImage();
                                                },
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorResources
                                                            .notValidateColor),
                                                    child: const Icon(
                                                      Icons.close_rounded,
                                                      size: 22,
                                                      color: ColorResources
                                                          .whiteColor,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Obx(
                            () {
                              return CommonButton(
                                  width: double.infinity,
                                  onTap: () {
                                    String? userId =
                                        PrefManager.getString('userId');

                                    /// All validate field after submit params api if user not login then show message.
                                    controller.isValidateRating(
                                        userId: userId,
                                        productId: productId,
                                        userRating:
                                            "${controller.ratingValue.value}",
                                        userReview:
                                            controller.feedBack.text.trim());
                                  },
                                  child: controller.isRating.value == true
                                      ? const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(
                                                color: ColorResources
                                                    .bottomSheetContainerColor),
                                          ),
                                        )
                                      : Text(
                                          controller.userRatingValue != null &&
                                                  controller.userRatingValue!
                                                      .isNotEmpty
                                              ? LocalStrings.update
                                              : LocalStrings.next,
                                          style: semiBoldDefault.copyWith(
                                              color: ColorResources.whiteColor),
                                        ));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    )).then(
      (value) {
        /// When dialog closed automatic clear image path
        controller!.clearImage();
        if (controller.userRatingValue == null &&
            controller.userRatingValue!.isEmpty) {
          controller.clearRating();
        } else {
          controller.ratingValue.value =
              double.parse(controller.userRatingValue!);
        }
        controller.feedBack.clear();
      },
    );
  }

  Map<int, int> calculateRatingCount(List<ApprovedRating>? ratings) {
    Map<int, int> countMap = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};

    if (ratings == null) return countMap;

    for (var rating in ratings) {
      if (rating.userRating != null) {
        int value = double.tryParse(rating.userRating!)?.round() ?? 0;
        if (countMap.containsKey(value)) {
          countMap[value] = countMap[value]! + 1;
        }
      }
    }

    return countMap;
  }

  int getTotalRatings(Map<int, int> countMap) {
    return countMap.values.fold(0, (a, b) => a + b);
  }

  /// submit rating dialog
/*void submitRatingDialog(BuildContext context,
      {String? productImage,
      String? productName,
      ProductController? controller}) {
    Get.dialog(barrierDismissible: false,
        StatefulBuilder(builder: (context, setState) {
      return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: Material(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(8),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 20, left: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back, size: 25)),
                        const SizedBox(width: Dimensions.space7),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            border: Border.all(
                                color: ColorResources.buttonColorDark),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.defaultRadius),
                            child: CachedCommonImage(
                              networkImageUrl: productImage,
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space15),
                        Expanded(
                          child: Text(
                            productName ?? '',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: semiBoldMediumLarge.copyWith(),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.close_rounded, size: 25)),
                      ]),
                      const SizedBox(height: Dimensions.space50),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocalStrings.name,
                              style: semiBoldMediumLarge.copyWith(
                                  color: ColorResources.blackColor),
                            ),
                            TextSpan(
                              text: LocalStrings.feedbackStar,
                              style: semiBoldMediumLarge.copyWith(
                                  color: ColorResources.notValidateColor),
                            ),
                          ],
                        )),
                      ),
                      const SizedBox(height: Dimensions.space5),
                      CommonTextField(
                        controller: controller!.name,
                        hintText: LocalStrings.name,
                        hintTexStyle: mediumDefault,
                        borderColor: ColorResources.deliveryColorColor,
                        fillColor:
                            ColorResources.deliveryColorColor.withOpacity(0.1),
                        textColor: ColorResources.blackColor,
                      ),
                      const SizedBox(height: Dimensions.space10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocalStrings.email,
                              style: semiBoldMediumLarge.copyWith(
                                  color: ColorResources.blackColor),
                            ),
                            TextSpan(
                              text: LocalStrings.feedbackStar,
                              style: semiBoldMediumLarge.copyWith(
                                  color: ColorResources.notValidateColor),
                            ),
                          ],
                        )),
                      ),
                      const SizedBox(height: Dimensions.space5),
                      CommonTextField(
                        controller: controller.email,
                        hintText: LocalStrings.email,
                        hintTexStyle: mediumDefault,
                        borderColor: ColorResources.deliveryColorColor,
                        fillColor:
                            ColorResources.deliveryColorColor.withOpacity(0.1),
                        textColor: ColorResources.blackColor,
                      ),
                      const SizedBox(height: Dimensions.space163),
                      CommonButton(
                        onTap: () {},
                        width: double.infinity,
                        buttonName: LocalStrings.submit,
                      ),
                    ],
                  ),
                ),
              )));
    }));
  }*/
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
