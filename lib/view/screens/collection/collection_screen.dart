import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../../../data/controller/collection/collection_controller.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';
import '../../components/network_connectivity_view.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final mainController = Get.put<MainController>(MainController());
  final collectionController =
      Get.put<CollectionController>(CollectionController());
  final categoriesController =
      Get.put<CategoriesController>(CategoriesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logCollectionView, index: 5);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      appBar: AppBarBackground(
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                color: ColorResources.conceptTextColor),
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.wishlistScreen);
                },
                icon: const Icon(Icons.favorite_rounded),
                color: ColorResources.conceptTextColor),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.addCartScreen);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    color: ColorResources.conceptTextColor),
                // Container(
                //   height: 15,
                //   width: 15,
                //   decoration: new BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   constraints: BoxConstraints(
                //     minWidth: 17,
                //     minHeight: 17,
                //   ),
                //   child: new Text(
                //     '1',
                //     style: new TextStyle(
                //       color: Colors.white,
                //       fontSize: 8,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // )
              ],
            ),
          ],
          backgroundColor: ColorResources.whiteColor,
          // Set the background color of the AppBar
          elevation: 0, // Remove default shadow
        ),
      ),
      bottomSheet: Container(
        height: size.height * 0.080,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: ColorResources.conceptTextColor,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Sort data bottomSheet
                bottomSheetSortData();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.sort,
                    color: ColorResources.whiteColor,
                    size: 15,
                  ),
                  Text(
                    LocalStrings.sort,
                    style:
                        boldDefault.copyWith(color: ColorResources.whiteColor),
                  ),
                ],
              ),
            ),
            const Spacer(),
            VerticalDivider(
              color: ColorResources.whiteColor.withOpacity(0.4),
              indent: 15,
              endIndent: 15,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.collectionFilterScreen);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_alt_outlined,
                    color: ColorResources.whiteColor,
                    size: 15,
                  ),
                  Text(
                    LocalStrings.filter,
                    style:
                        boldDefault.copyWith(color: ColorResources.whiteColor),
                  ),
                  const SizedBox(width: Dimensions.space15),
                  Container(
                    height: size.height * 0.027,
                    width: size.width * 0.055,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.smallRadius),
                        color: ColorResources.cardTabColor),
                    child: Center(
                      child: Text(
                        LocalStrings.quantityFirst,
                        style: boldDefault.copyWith(
                            color: ColorResources.whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: GetBuilder(
          init: MainController(),
          builder: (mainController) {
            return GestureDetector(
              onTap: mainController.isNetworkConnection?.value == false
                  ? null
                  : () {
                      AppAnalytics().actionTriggerLogs(
                          eventName: LocalStrings.logCollectionInquiryCall,
                          index: 5);
                    },
              child: Container(
                height: size.height * 0.070,
                margin: const EdgeInsets.only(bottom: 70, left: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.borderColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: mainController.isNetworkConnection?.value == false
                      ? ColorResources.conceptTextColor.withOpacity(0.3)
                      : ColorResources.conceptTextColor,
                ),
                child: const Center(
                    child: Icon(
                  Icons.call,
                  color: ColorResources.whiteColor,
                )),
              ),
            );
          }),
      body: GetBuilder(
          init: MainController(),
          builder: (mainController) {
            return mainController.isNetworkConnection?.value == false
                ? NetworkConnectivityView(
                    onTap: () async {
                      RxBool? isEnableNetwork = await mainController
                          .checkToAssignNetworkConnections();

                      if (isEnableNetwork!.value == true) {
                        collectionController.enableNetworkHideLoader();
                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            Get.put<CategoriesController>(
                                CategoriesController());
                            collectionController
                                .disableNetworkLoaderByDefault();
                          },
                        );
                        collectionController.update();
                      }
                    },
                    isLoading: collectionController.isEnableNetwork,
                  )
                : Column(
                    children: [
                      CachedCommonImage(
                        height: size.height * 0.12,
                        width: double.infinity,
                        networkImageUrl: MyImages.rings,
                      ),
                      GetBuilder(
                        init: CollectionController(),
                        builder: (controller) {
                          // Calculate dynamic item width based on screen size
                          final double itemWidth =
                              (size.width - Dimensions.space30) /
                                  2; // Adjust for spacing
                          return Expanded(
                            child: ListView.builder(
                              itemCount: (filterProductData.length / 2).ceil(),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final firstIndex = index * 2;
                                final secondIndex = firstIndex + 1;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: itemWidth,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 3, bottom: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  // First index used stored data sqflite
                                                  controller.addProduct(
                                                    controller
                                                            .collectionDataImageLst[
                                                        firstIndex],
                                                    controller
                                                            .collectionDataNameLst[
                                                        firstIndex],
                                                    controller
                                                            .collectionCutOffPrice[
                                                        firstIndex],
                                                    controller
                                                            .collectionTotalPrice[
                                                        firstIndex],
                                                  );
                                                  Get.toNamed(
                                                      RouteHelper.productScreen,
                                                      arguments: [
                                                        controller
                                                                .collectionDataImageLst[
                                                            firstIndex]
                                                      ]);

                                                  /// Product screen seen product analysis log
                                                  AppAnalytics()
                                                      .actionTriggerWithProductsLogs(
                                                    eventName: LocalStrings
                                                        .logProductDetailView,
                                                    productName: controller
                                                            .collectionDataNameLst[
                                                        index],
                                                    productImage: controller
                                                            .collectionDataImageLst[
                                                        index],
                                                    index: 6,
                                                  );
                                                },
                                                child:
                                                    collectionItems(firstIndex),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (secondIndex <
                                            controller
                                                .collectionDataImageLst.length)
                                          Expanded(
                                            child: SizedBox(
                                              width: itemWidth,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3, bottom: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Second index used stored data sqflite
                                                    controller.addProduct(
                                                      controller
                                                              .collectionDataImageLst[
                                                          secondIndex],
                                                      controller
                                                              .collectionDataNameLst[
                                                          secondIndex],
                                                      controller
                                                              .collectionCutOffPrice[
                                                          secondIndex],
                                                      controller
                                                              .collectionTotalPrice[
                                                          secondIndex],
                                                    );
                                                    Get.toNamed(RouteHelper
                                                        .productScreen);
                                                  },
                                                  child: collectionItems(
                                                      secondIndex),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (secondIndex >=
                                            controller
                                                .collectionDataImageLst.length)
                                          // Placeholder to maintain spacing if only one item is present
                                          Flexible(
                                            child: SizedBox(width: itemWidth),
                                          ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.085,
                      ),
                    ],
                  );
          }),
    );
  }

  Widget collectionItems(int index) {
    final size = MediaQuery.of(context).size;

    return GetBuilder(
      init: CollectionController(),
      builder: (controller) {
        final isFavorite = controller.isFavorite(index);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.25,
                  color: ColorResources.borderColor.withOpacity(0.050),
                  child: Center(
                    child: CachedCommonImage(
                      networkImageUrl:
                          filterProductData[index].media![0].productAsset!,
                      height: size.height * 0.17,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      controller.collectionPostUpdateLst[index] ==
                              LocalStrings.blankText
                          ? const SizedBox()
                          : Container(
                              height: size.height * 0.033,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: ColorResources.updateCardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.defaultRadius),
                              ),
                              child: Center(
                                child: Text(
                                  controller.collectionPostUpdateLst[index],
                                  style: semiBoldExtraSmall.copyWith(
                                      color: ColorResources.conceptTextColor),
                                ),
                              ),
                            ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          controller.toggleFavorite(index);
                        },
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: ColorResources.conceptTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: size.height * 0.033,
                    width: size.width * 0.12,
                    margin: const EdgeInsets.only(left: 15, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.bottomSheetRadius),
                      border:
                          Border.all(color: ColorResources.conceptTextColor),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${filterProductData[index].rating}",
                            style: semiBoldSmall.copyWith(
                                color: ColorResources.conceptTextColor),
                          ),
                          const SizedBox(width: Dimensions.space3),
                          const Icon(
                            Icons.star,
                            color: ColorResources.updateCardColor,
                            size: 13,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹${controller.collectionCutOffPrice[index]}",
                        style: semiBoldDefault.copyWith(
                            color: ColorResources.conceptTextColor),
                      ),
                      const SizedBox(width: Dimensions.space7),
                      Text(
                        "₹${controller.collectionTotalPrice[index]}",
                        style: semiBoldSmall.copyWith(
                            color: ColorResources.borderColor,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  Text(
                    controller.collectionDataNameLst[index],
                    maxLines: 2,
                    style: semiBoldSmall.copyWith(
                        color: ColorResources.offerColor),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Sort jewellery data
  bottomSheetSortData() {
    return showModalBottomSheet(
      backgroundColor: ColorResources.cardBgColor,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.bottomSheetRadius),
            topLeft: Radius.circular(Dimensions.bottomSheetRadius)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorResources.cardBgColor,
            borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: ColorResources.offerThirdTextColor.withOpacity(0.1),
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Container(
                      height: 5,
                      width: 40,
                      color: ColorResources.whiteColor,
                    ),
                    const SizedBox(height: Dimensions.space25),
                    Text(
                      LocalStrings.sortBy,
                      style: boldMediumLarge.copyWith(
                          color: ColorResources.conceptTextColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space20),
              GetBuilder(
                init: CollectionController(),
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.sortProductsLst.length,
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            controller.sortCurrentIndex(index);
                          },
                          child: Text(
                            controller.sortProductsLst[index],
                            style: boldDefault.copyWith(
                              color: controller.currentIndex.value == index
                                  ? ColorResources.sortSelectedColor
                                  : ColorResources.conceptTextColor,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
