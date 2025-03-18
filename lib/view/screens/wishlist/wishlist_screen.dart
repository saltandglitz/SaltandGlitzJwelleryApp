import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/data/controller/add_to_cart/add_to_cart_controller.dart';
import 'package:saltandGlitz/data/controller/collection/collection_controller.dart';
import 'package:saltandGlitz/data/controller/wishlist/wishlist_controller.dart';
import 'package:saltandGlitz/data/product/product_controller.dart';
import 'package:saltandGlitz/local_storage/pref_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';
import '../../components/network_connectivity_view.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final mainController = Get.put<MainController>(MainController());
  final wishlistController = Get.put<WishlistController>(WishlistController());
  final collectionController =
      Get.put<CollectionController>(CollectionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Get user id :${PrefManager.getString('userId')}");
    mainController.checkToAssignNetworkConnections();
    getWishlistApi();
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logWishList, index: 3);
  }

//Todo: Get Wishlist api method
  getWishlistApi() async {
    await wishlistController.getWishlistDataApiMethod();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder(
      init: WishlistController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorResources.scaffoldBackgroundColor,
          appBar: AppBarBackground(
            child: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: const Text(LocalStrings.wishlist),
              titleTextStyle: regularLarge.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorResources.conceptTextColor,
              ),
              leading: IconButton(
                onPressed: () {
                  mainController.checkToAssignNetworkConnections();
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              ),

              backgroundColor: ColorResources.whiteColor,
              // Set the background color of the AppBar
              elevation: 0, // Remove default shadow
            ),
          ),
          body: GetBuilder(
              init: WishlistController(),
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
                                Get.put<WishlistController>(
                                    WishlistController());
                                controller.disableNetworkLoaderByDefault();
                              },
                            );
                            controller.update();
                          }
                        },
                        isLoading: controller.isEnableNetwork,
                      )
                    : controller.isWishlistProduct.value == true
                        ? wishlistProductsShimmerEffect()
                        : controller.wishlistProducts.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(MyImages.noWishlistItemImage,
                                        height: size.height * 0.25,
                                        width: 200,
                                        fit: BoxFit.fill),
                                    const SizedBox(height: Dimensions.space20),
                                    Center(
                                      child: Text(
                                        LocalStrings.wishlistEmpty,
                                        textAlign: TextAlign.center,
                                        style: semiBoldLarge.copyWith(
                                            color: ColorResources
                                                .conceptTextColor),
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space70),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.wishlistProducts.length,
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    margin: const EdgeInsets.only(bottom: 17),
                                    decoration: BoxDecoration(
                                      color: ColorResources.cardBgColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.offersCardRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorResources.borderColor
                                              .withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: size.height * 0.15,
                                          width: size.width * 0.30,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorResources
                                                    .offerSixColor),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.offersCardRadius),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.offersCardRadius),
                                            child: CachedCommonImage(
                                              width: double.infinity,
                                              networkImageUrl: controller
                                                  .wishlistProducts[index]
                                                  .productId!
                                                  .image01,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Dimensions.space20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      controller
                                                              .wishlistProducts[
                                                                  index]
                                                              .productId!
                                                              .title ??
                                                          '',
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: mediumDefault
                                                          .copyWith(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space2),
                                              Text(
                                                "₹${controller.wishlistProducts[index].productId!.total14KT?.round()}",
                                                style: boldSmall.copyWith(
                                                    color: ColorResources
                                                        .conceptTextColor),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space40),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      /// Move to cart product clicked analysis
                                                      AppAnalytics().actionTriggerWithProductsLogs(
                                                          eventName: LocalStrings
                                                              .logWishListMoveCartProduct,
                                                          productName: controller
                                                              .wishlistProducts[
                                                                  index]
                                                              .productId!
                                                              .title,
                                                          productImage: controller
                                                              .wishlistProducts[
                                                                  index]
                                                              .productId!
                                                              .image01,
                                                          index: 3);

                                                      //Todo : Seen move to cart dialog box
                                                      _showCustomIntegerPicker(
                                                          context,
                                                          controller,
                                                          index);
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.045,
                                                      width: size.width * 0.30,
                                                      decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .moveCartColor,
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .defaultRadius),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          LocalStrings.moveCart,
                                                          style: boldSmall.copyWith(
                                                              color: ColorResources
                                                                  .whiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      /// Share product clicked analysis
                                                      AppAnalytics().actionTriggerWithProductsLogs(
                                                          eventName: LocalStrings
                                                              .logWishListShareProduct,
                                                          productName: controller
                                                              .wishlistProducts[
                                                                  index]
                                                              .productId!
                                                              .title,
                                                          productImage: controller
                                                              .wishlistProducts[
                                                                  index]
                                                              .productId!
                                                              .image01,
                                                          index: 3);
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.040,
                                                      width: size.width * 0.090,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .defaultRadius),
                                                        border: Border.all(
                                                            color: ColorResources
                                                                .conceptTextColor,
                                                            width: 1.5),
                                                      ),
                                                      child: const Center(
                                                        child: Icon(Icons
                                                            .share_rounded),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var productId = controller
                                                .wishlistProducts[index]
                                                .productId!
                                                .productId;

                                            /// Remove product clicked analysis
                                            AppAnalytics()
                                                .actionTriggerWithProductsLogs(
                                                    eventName: LocalStrings
                                                        .logWishListRemoveProduct,
                                                    productName: controller
                                                        .wishlistProducts[index]
                                                        .productId!
                                                        .title,
                                                    productImage: controller
                                                        .wishlistProducts[index]
                                                        .productId!
                                                        .image01,
                                                    index: 3);
                                            //Todo : Locally remove to wishlist screen
                                            controller
                                                .removeLocallyWishlist(index);
                                            //Todo : Background workable remove api method
                                            collectionController
                                                .removeWishlistApiMethod(
                                                    productId: productId);
                                            //Todo : Collection & Wishlist screen wishlist match productId and remove locally
                                            controller.updateProductStatus(
                                                productId!, false);
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorResources
                                                    .conceptTextColor),
                                            child: const Icon(
                                              Icons.close,
                                              size: 15,
                                              color: ColorResources.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
              }),
        );
      },
    );
  }

  wishlistProductsShimmerEffect() {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: const EdgeInsets.only(bottom: 17),
          decoration: BoxDecoration(
            color: ColorResources.cardBgColor,
            borderRadius: BorderRadius.circular(Dimensions.offersCardRadius),
            boxShadow: [
              BoxShadow(
                color: ColorResources.borderColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: ColorResources.baseColor,
                highlightColor: ColorResources.highlightColor,
                child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.offerSixColor,
                    ),
                    borderRadius:
                        BorderRadius.circular(Dimensions.offersCardRadius),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.offersCardRadius),
                    child: Container(
                      color: ColorResources
                          .highlightColor, // Color to simulate a loading state.
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.space20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Row(
                      children: [
                        Shimmer.fromColors(
                            baseColor: ColorResources.baseColor,
                            highlightColor: ColorResources.highlightColor,
                            child: Container(
                                height: 10,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.minimumRadius),
                                  color: ColorResources.highlightColor,
                                ))),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space2),
                    Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.minimumRadius),
                            color: ColorResources.highlightColor,
                          ),
                        )),
                    const SizedBox(height: Dimensions.space45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: ColorResources.baseColor,
                          highlightColor: ColorResources.highlightColor,
                          child: Container(
                            height: size.height * 0.045,
                            width: size.width * 0.30,
                            decoration: BoxDecoration(
                              color: ColorResources.moveCartColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.defaultRadius),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Shimmer.fromColors(
                          baseColor: ColorResources.baseColor,
                          highlightColor: ColorResources.highlightColor,
                          child: Container(
                            height: size.height * 0.040,
                            width: size.width * 0.090,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.defaultRadius),
                              border: Border.all(
                                  color: ColorResources.conceptTextColor,
                                  width: 1.5),
                            ),
                            child: const Center(
                              child: Icon(Icons.share_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.highlightColor),
                child: Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: ColorResources.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//Todo : Move carat dialog show
  void moveCartDialog() {
    Get.dialog(StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: Material(
              color: ColorResources.whiteColor,
              borderRadius: BorderRadius.circular(8.0),
              elevation: 5.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocalStrings.size,
                    style: mediumSmall.copyWith(
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}

// Method to show the custom integer picker
void _showCustomIntegerPicker(
    BuildContext context, WishlistController controller, int index) {
  final productController = Get.put<ProductController>(ProductController());
  final collectionController =
      Get.put<CollectionController>(CollectionController());
  showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      message: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250, // You can adjust this based on the number of items
          child: CupertinoPicker(
            itemExtent: 40, // Adjust item height
            scrollController: FixedExtentScrollController(
              initialItem: controller.selectedNumber.value -
                  6, // Initialize based on selected number
            ),
            onSelectedItemChanged: (index) {
              // Update the selected number when an item is picked
              controller.updateSelectedNumber(6 + index);
            },
            children: List<Widget>.generate(productController.ringSize.length,
                (index) {
              return Center(
                child: Text(
                  '${controller.selectedNumber.value + index}',
                  // Generate numbers from 6 to 15
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }),
          ),
        ),
      ),
      actions: <Widget>[
        Obx(
          () {
            return CupertinoActionSheetAction(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: LocalStrings.size,
                    style: semiBoldLarge.copyWith(
                        color: ColorResources.blackColor)),
                TextSpan(
                    text: ' ${controller.selectedNumber.value}',
                    style:
                        boldLarge.copyWith(color: ColorResources.blackColor)),
              ])),
              onPressed: () {},
            );
          },
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Get.back();
          },
          child: Text(LocalStrings.cancel.toUpperCase(),
              style: semiBoldLarge.copyWith()),
        ),
        Obx(
          () {
            return CupertinoActionSheetAction(
              child: productController.isAddToCart.value == true
                  ? const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(
                        color: ColorResources.blackColor,
                      ),
                    )
                  : Text(LocalStrings.moveCart,
                      style: semiBoldLarge.copyWith()),
              onPressed: () {
                var productId =
                    controller.wishlistProducts[index].productId!.productId;
                //Todo : Add cart api method calling
                productController.addToCartApiMethod(
                  userId: PrefManager.getString("userId"),
                  productId: productId,
                  size: controller.selectedNumber.value,
                  type: LocalStrings.moveCart,
                  indexWishlist: index,
                );
              },
            );
          },
        ),
      ],
    ),
  ).then(
    (value) => controller.selectedNumber = 6.obs,
  );
}
