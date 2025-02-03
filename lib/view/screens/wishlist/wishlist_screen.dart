import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/wishlist/wishlist_controller.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logWishList, index: 3);
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
                    : ListView.builder(
                        itemCount: controller.productsImage.length,
                        physics: const BouncingScrollPhysics(),
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.15,
                                  width: size.width * 0.30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorResources.offerSixColor),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.offersCardRadius),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.offersCardRadius),
                                    child: CachedCommonImage(
                                      width: double.infinity,
                                      networkImageUrl:
                                          controller.productsImage[index],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.productsName[index],
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: mediumDefault.copyWith(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Dimensions.space2),
                                      Text(
                                        controller.productsPriceLst[index],
                                        style: boldSmall.copyWith(
                                            color: ColorResources
                                                .conceptTextColor),
                                      ),
                                      const SizedBox(
                                          height: Dimensions.space40),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                           onTap: () {
                                             /// Move to cart product clicked analysis
                                             AppAnalytics()
                                                 .actionTriggerWithProductsLogs(
                                                 eventName: LocalStrings
                                                     .logWishListMoveCartProduct,
                                                 productName: controller
                                                     .productsName[index],
                                                 productImage: controller
                                                     .productsImage[index],
                                                 index: 3);
                                           },
                                            child: Container(
                                              height: size.height * 0.045,
                                              width: size.width * 0.30,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.moveCartColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.defaultRadius),
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
                                             AppAnalytics()
                                                 .actionTriggerWithProductsLogs(
                                                 eventName: LocalStrings
                                                     .logWishListShareProduct,
                                                 productName: controller
                                                     .productsImage[index],
                                                 productImage: controller
                                                     .productsName[index],
                                                 index: 3);
                                           },
                                            child: Container(
                                              height: size.height * 0.040,
                                              width: size.width * 0.090,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.defaultRadius),
                                                border: Border.all(
                                                    color: ColorResources
                                                        .conceptTextColor,
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
                                GestureDetector(
                                  onTap: () {
                                    /// Remove product clicked analysis
                                    AppAnalytics().actionTriggerWithProductsLogs(
                                        eventName:
                                        LocalStrings.logWishListRemoveProduct,
                                        productName:
                                        controller.productsName[index],
                                        productImage:
                                        controller.productsImage[index],
                                        index: 3);
                                    controller.removeLocally(index);
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorResources.conceptTextColor),
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
}
