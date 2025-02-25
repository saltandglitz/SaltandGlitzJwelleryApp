import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import 'package:shimmer/shimmer.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../../../data/controller/collection/collection_controller.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../main_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/cached_image.dart';
import '../../components/common_textfield.dart';
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
  final dashboardController =
      Get.put<DashboardController>(DashboardController());

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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        collectionController.hideSearchField();
      },
      child: Scaffold(
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
              Obx(
                () {
                  return collectionController.isShowSearchField.value == true
                      ? SizedBox(
                          height: 40,
                          width: 250,
                          child: CommonTextField(
                            controller:
                                dashboardController.searchTextController,
                            hintText: LocalStrings.search,
                            fillColor: ColorResources.whiteColor,
                            textAlignVertical: TextAlignVertical.center,
                            contentPadding: const EdgeInsets.only(left: 10),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: ColorResources.iconColor,
                            ),
                            onChange: (value) {
                              if (dashboardController
                                  .searchTextController.text.isEmpty) {
                                dashboardController.hideSearchMethod();
                              }
                              dashboardController.onSearchChanged(value);
                              // controller.onSearchChanged(value);
                            },
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            dashboardController.hideSearchMethod();
                          },
                          icon: const Icon(Icons.search_rounded),
                          color: ColorResources.conceptTextColor);
                },
              ),
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
                      style: boldDefault.copyWith(
                          color: ColorResources.whiteColor),
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
                      style: boldDefault.copyWith(
                          color: ColorResources.whiteColor),
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
        body: PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            collectionController.currentIndex.value = (-1);
          },
          child: GetBuilder(
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
                    : GetBuilder(
                        init: CollectionController(),
                        builder: (controller) {
                          // Calculate dynamic item width based on screen size
                          final double itemWidth =
                              (size.width - Dimensions.space30) /
                                  2; // Adjust for spacing
                          return GestureDetector(
                            onTap: () {
                              dashboardController.hideSearchMethod();
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    CachedCommonImage(
                                      height: size.height * 0.12,
                                      width: double.infinity,
                                      networkImageUrl: MyImages.rings,
                                    ),
                                    Obx(
                                      () {
                                        return controller
                                                    .isShowCategories.value ==
                                                false
                                            ? Expanded(
                                                child: ListView.builder(
                                                  itemCount: (controller
                                                              .collectionDataImageLst
                                                              .length /
                                                          2)
                                                      .ceil(),
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final firstIndex =
                                                        index * 2;
                                                    final secondIndex =
                                                        firstIndex + 1;
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: SizedBox(
                                                                width:
                                                                    itemWidth,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              3,
                                                                          bottom:
                                                                              10),
                                                                  child: collectionItemsShimmerEffect(
                                                                      firstIndex),
                                                                ),
                                                              ),
                                                            ),
                                                            if (secondIndex <
                                                                controller
                                                                    .collectionDataImageLst
                                                                    .length)
                                                              Expanded(
                                                                child: SizedBox(
                                                                  width:
                                                                      itemWidth,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 3,
                                                                        bottom:
                                                                            10),
                                                                    child: collectionItemsShimmerEffect(
                                                                        secondIndex),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (secondIndex >=
                                                                controller
                                                                    .collectionDataImageLst
                                                                    .length)
                                                              // Placeholder to maintain spacing if only one item is present
                                                              Flexible(
                                                                child: SizedBox(
                                                                    width:
                                                                        itemWidth),
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              )
                                            : filterProductData.isEmpty
                                                ? Padding(
                                                  padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top * 5),
                                                  child: Text(
                                                    LocalStrings
                                                        .collectionEmpty,
                                                    textAlign:
                                                        TextAlign.center,
                                                    softWrap: true,
                                                    style: semiBoldLarge
                                                        .copyWith(
                                                      color: ColorResources
                                                          .conceptTextColor,
                                                    ),
                                                  ),
                                                )
                                                : Expanded(
                                                    child: ListView.builder(
                                                      controller:
                                                          dashboardController
                                                              .scrollController,
                                                      itemCount:
                                                          (filterProductData
                                                                      .length /
                                                                  2)
                                                              .ceil(),
                                                      physics:
                                                          const ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final firstIndex =
                                                            index * 2;
                                                        final secondIndex =
                                                            firstIndex + 1;
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        itemWidth,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              3,
                                                                          bottom:
                                                                              10),
                                                                      child: filterProductData
                                                                              .isEmpty
                                                                          ? collectionItemsShimmerEffect(
                                                                              firstIndex)
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                // First index used stored data sqflite
                                                                                // controller
                                                                                //     .addProduct(
                                                                                //   controller
                                                                                //       .collectionDataImageLst[firstIndex],
                                                                                //   controller
                                                                                //       .collectionDataNameLst[firstIndex],
                                                                                //   controller
                                                                                //       .collectionCutOffPrice[firstIndex],
                                                                                //   controller
                                                                                //       .collectionTotalPrice[firstIndex],
                                                                                // );
                                                                                // Get.toNamed(
                                                                                //     RouteHelper.productScreen,
                                                                                //     arguments: [
                                                                                //       controller.collectionDataImageLst[firstIndex]
                                                                                //     ]);

                                                                                /// Product screen seen product analysis log
                                                                                AppAnalytics().actionTriggerWithProductsLogs(
                                                                                  eventName: LocalStrings.logProductDetailView,
                                                                                  productName: filterProductData[firstIndex].title ?? '',
                                                                                  productImage: filterProductData[firstIndex].media![0].productAsset!,
                                                                                  index: 6,
                                                                                );
                                                                              },
                                                                              child: collectionItems(firstIndex),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (secondIndex <
                                                                    filterProductData
                                                                        .length)
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          itemWidth,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                3,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // Second index used stored data sqflite
                                                                            // controller
                                                                            //     .addProduct(
                                                                            //   controller
                                                                            //           .collectionDataImageLst[
                                                                            //       secondIndex],
                                                                            //   controller
                                                                            //           .collectionDataNameLst[
                                                                            //       secondIndex],
                                                                            //   controller
                                                                            //           .collectionCutOffPrice[
                                                                            //       secondIndex],
                                                                            //   controller
                                                                            //           .collectionTotalPrice[
                                                                            //       secondIndex],
                                                                            // );
                                                                            // Get.toNamed(
                                                                            //     RouteHelper
                                                                            //         .productScreen);
                                                                          },
                                                                          child:
                                                                              collectionItems(secondIndex),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (secondIndex >=
                                                                    filterProductData
                                                                        .length)
                                                                  // Placeholder to maintain spacing if only one item is present
                                                                  Flexible(
                                                                    child: SizedBox(
                                                                        width:
                                                                            itemWidth),
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
                                ),
                                //Todo : Overlay search Box
                                Obx(
                                  () =>
                                      dashboardController.isDialogVisible.value
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.090),
                                              child: Container(
                                                height: dashboardController
                                                            .searchProducts
                                                            .length <
                                                        3
                                                    ? size.height * 0.17
                                                    : (dashboardController
                                                                    .searchProducts
                                                                    .length >
                                                                3 &&
                                                            dashboardController
                                                                    .searchProducts
                                                                    .length <
                                                                6)
                                                        ? size.height * 0.33
                                                        : size.height * 0.40,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorResources.whiteColor,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: ColorResources
                                                          .inactiveTabColor,
                                                      offset: Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .defaultRadius),
                                                ),
                                                child:
                                                    dashboardController
                                                                .isSearchShimmer
                                                                .value ==
                                                            true
                                                        ? GridView.builder(
                                                            itemCount: 9,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            gridDelegate:
                                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              crossAxisSpacing:
                                                                  11.0,
                                                              mainAxisSpacing:
                                                                  15.0,
                                                            ),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ColorResources
                                                                      .shimmerEffectBaseColor,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .defaultRadius),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: ColorResources
                                                                          .inactiveTabColor,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                      blurRadius:
                                                                          2,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Shimmer
                                                                        .fromColors(
                                                                      baseColor:
                                                                          ColorResources
                                                                              .baseColor,
                                                                      highlightColor:
                                                                          ColorResources
                                                                              .highlightColor,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: const BorderRadius
                                                                            .only(
                                                                            topLeft:
                                                                                Radius.circular(Dimensions.defaultRadius),
                                                                            topRight: Radius.circular(Dimensions.defaultRadius)),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              90,
                                                                          decoration: BoxDecoration(
                                                                              color: ColorResources.whiteColor,
                                                                              borderRadius: BorderRadius.circular(3)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Shimmer
                                                                        .fromColors(
                                                                      baseColor:
                                                                          ColorResources
                                                                              .baseColor,
                                                                      highlightColor:
                                                                          ColorResources
                                                                              .highlightColor,
                                                                      child:
                                                                          Container(
                                                                        height: size.height *
                                                                            0.015,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorResources.whiteColor,
                                                                            borderRadius: BorderRadius.circular(3)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : dashboardController
                                                                .searchProducts
                                                                .isEmpty
                                                            ? Center(
                                                                child: Text(
                                                                  LocalStrings
                                                                      .searchNotAvailable,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      false,
                                                                  style: semiBoldLarge
                                                                      .copyWith(
                                                                    color: ColorResources
                                                                        .conceptTextColor,
                                                                  ),
                                                                ),
                                                              )
                                                            : GridView.builder(
                                                                itemCount:
                                                                    dashboardController
                                                                        .searchProducts
                                                                        .length,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                gridDelegate:
                                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      3,
                                                                  crossAxisSpacing:
                                                                      11.0,
                                                                  mainAxisSpacing:
                                                                      15.0,
                                                                ),
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorResources
                                                                          .shimmerEffectBaseColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              Dimensions.defaultRadius),
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              ColorResources.inactiveTabColor,
                                                                          offset: Offset(
                                                                              0,
                                                                              1),
                                                                          blurRadius:
                                                                              2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.toNamed(
                                                                            RouteHelper.collectionScreen);
                                                                        categoriesController.filterCategoriesApiMethod(
                                                                            occasionBy:
                                                                                dashboardController.searchProducts[index].subCategory,
                                                                            priceLimit: '');
                                                                        dashboardController
                                                                            .hideSearchMethod();
                                                                        //Todo : Search box hide
                                                                        dashboardController
                                                                            .isDialogVisible
                                                                            .value = false;
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                const BorderRadius.only(topLeft: Radius.circular(Dimensions.defaultRadius), topRight: Radius.circular(Dimensions.defaultRadius)),
                                                                            child:
                                                                                CachedCommonImage(
                                                                              networkImageUrl: dashboardController.searchProducts[index].image01,
                                                                              // categoryList[index]
                                                                              //         .images,
                                                                              width: double.infinity,
                                                                              height: 90,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            dashboardController.searchProducts[index].title ??
                                                                                '',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            softWrap:
                                                                                false,
                                                                            style:
                                                                                semiBoldLarge.copyWith(
                                                                              color: ColorResources.conceptTextColor,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                // Center(
                                                //   child: Text(
                                                //     'Search Results',
                                                //     style: TextStyle(
                                                //         color: Colors.black, fontSize: 18),
                                                //   ),
                                                // ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                        });
              }),
        ),
      ),
    );
  }

  Widget collectionItems(int index) {
    final size = MediaQuery.of(context).size;

    return GetBuilder(
      init: CollectionController(),
      builder: (controller) {
        // final isFavorite = controller.isFavorite(index);
// Check if the index is within the valid range
        if (index >= filterProductData.length) {
          return const SizedBox(); // Or some other fallback widget
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.25,
                  width: double.infinity,
                  color: ColorResources.borderColor.withOpacity(0.050),
                  child: CachedCommonImage(
                    networkImageUrl:
                        filterProductData[index].media![0].productAsset!,
                    height: size.height * 0.17,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      //Todo : Declared latest or not
                      // controller.collectionPostUpdateLst[index] ==
                      //     LocalStrings.blankText
                      //     ? const SizedBox()
                      //     : Container(
                      //   height: size.height * 0.033,
                      //   padding:
                      //   const EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: BoxDecoration(
                      //     color: ColorResources.updateCardColor,
                      //     borderRadius: BorderRadius.circular(
                      //         Dimensions.defaultRadius),
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       controller.collectionPostUpdateLst[index],
                      //       style: semiBoldExtraSmall.copyWith(
                      //           color: ColorResources.conceptTextColor),
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.toggleFavorite(index);
                      //   },
                      //   child: Icon(
                      //     isFavorite
                      //         ? Icons.favorite_rounded
                      //         : Icons.favorite_border_rounded,
                      //     color: ColorResources.conceptTextColor,
                      //   ),
                      // ),
                      LikeButton(
                        circleColor: const CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: ColorResources.notValidateColor,
                          dotSecondaryColor: ColorResources.notValidateColor,
                        ),
                        likeBuilder: (bool isLiked) {
                          // filterProductData[index].isWishlisted = isLiked;
                          return Icon(
                            isLiked
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            color: isLiked
                                ? ColorResources.notValidateColor
                                : ColorResources.inactiveTabColor,
                            // size: buttonSize,
                          );
                        },
                        onTap: (isLiked) async {
                          print(
                              "Wishlist like: $isLiked");     print(
                              "Wishlist product id: ${filterProductData[index].productId}");
                          print(
                              "Wishlist product : ${PrefManager.getString('user_id')}");
                          //Todo : Wishlist particular products api method
                          controller.favoritesProducts(
                              userId: PrefManager.getString('user_id'),
                              productId: filterProductData[index].productId);
                          // If user is logged in, proceed with like/unlike logic
                          return !isLiked; // toggle like/unlike
                        },
                      ),
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
                        "₹${filterProductData[index].total14KT}",
                        style: semiBoldDefault.copyWith(
                            color: ColorResources.conceptTextColor),
                      ),
                      const SizedBox(width: Dimensions.space7),
                      // Text(
                      //   "₹${filterProductData[index].price14KT}",
                      //   style: semiBoldSmall.copyWith(
                      //       color: ColorResources.borderColor,
                      //       decoration: TextDecoration.lineThrough),
                      // ),
                    ],
                  ),
                  Text(
                    filterProductData[index].subCategory ?? '',
                    // filterProductData[index].title??'',
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

  Widget collectionItemsShimmerEffect(int index) {
    final size = MediaQuery.of(context).size;

    return GetBuilder(
      init: CollectionController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: Container(
                    height: size.height * 0.25,
                    width: double.infinity,
                    color: ColorResources.borderColor.withOpacity(0.050),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      //Todo : Declared latest or not
                      // controller.collectionPostUpdateLst[index] ==
                      //     LocalStrings.blankText
                      //     ? const SizedBox()
                      //     : Container(
                      //   height: size.height * 0.033,
                      //   padding:
                      //   const EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: BoxDecoration(
                      //     color: ColorResources.updateCardColor,
                      //     borderRadius: BorderRadius.circular(
                      //         Dimensions.defaultRadius),
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       controller.collectionPostUpdateLst[index],
                      //       style: semiBoldExtraSmall.copyWith(
                      //           color: ColorResources.conceptTextColor),
                      //     ),
                      //   ),
                      // ),
                      const Spacer(),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.toggleFavorite(index);
                      //   },
                      //   child: Icon(
                      //     isFavorite
                      //         ? Icons.favorite_rounded
                      //         : Icons.favorite_border_rounded,
                      //     color: ColorResources.conceptTextColor,
                      //   ),
                      // ),
                      Shimmer.fromColors(
                        baseColor: ColorResources.baseColor,
                        highlightColor: ColorResources.highlightColor,
                        child: LikeButton(
                          likeBuilder: (bool isLiked) {
                            return const Icon(
                              Icons.favorite_rounded,
                              color: ColorResources.inactiveTabColor,
                              // size: buttonSize,
                            );
                          },
                        ),
                      ),
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
                          Shimmer.fromColors(
                              baseColor: ColorResources.baseColor,
                              highlightColor: ColorResources.highlightColor,
                              child: Container(
                                height: size.height * 0.010,
                                width: size.width * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorResources.whiteColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.smallRadius)),
                              )),
                          const SizedBox(width: Dimensions.space3),
                          const Icon(
                            Icons.star,
                            color: ColorResources.inactiveTabColor,
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
                      Shimmer.fromColors(
                          baseColor: ColorResources.baseColor,
                          highlightColor: ColorResources.highlightColor,
                          child: Container(
                            height: 9,
                            width: size.width * 0.20,
                            decoration: BoxDecoration(
                                color: ColorResources.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.smallRadius)),
                          )),
                      const SizedBox(width: Dimensions.space7),
                      // Shimmer.fromColors(
                      //     baseColor: ColorResources.baseColor,
                      //     highlightColor: ColorResources.highlightColor,
                      //     child: Container(
                      //       height: 9,
                      //       width: 60,
                      //       decoration: BoxDecoration(
                      //           color: ColorResources.whiteColor,
                      //           borderRadius: BorderRadius.circular(
                      //               Dimensions.smallRadius)),
                      //     )),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.space7,
                  ),
                  Shimmer.fromColors(
                      baseColor: ColorResources.baseColor,
                      highlightColor: ColorResources.highlightColor,
                      child: Container(
                        height: 10,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            color: ColorResources.whiteColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.smallRadius)),
                      )),
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
                            String sortProducts = '';
                            controller.sortCurrentIndex(index);
                            if (controller.sortProductsLst[index] ==
                                LocalStrings.latest) {
                              sortProducts = "newestFirst";
                            } else if (controller.sortProductsLst[index] ==
                                LocalStrings.featured) {
                              sortProducts = LocalStrings.featured;
                            } else if (controller.sortProductsLst[index] ==
                                LocalStrings.priceLow) {
                              sortProducts = "lowToHigh";
                            } else if (controller.sortProductsLst[index] ==
                                LocalStrings.priceHigh) {
                              sortProducts = "highToLow";
                            }
                            // controller.sortCurrentIndex(index);
                            categoriesController.filterCategoriesApiMethod(
                                priceOrder: sortProducts);
                            Get.put<CollectionController>(
                                CollectionController());
                            controller.hideSearchField();
                            Get.back();
                          },
                          child: Obx(
                            () {
                              return Text(
                                controller.sortProductsLst[index],
                                style: boldDefault.copyWith(
                                    color:
                                        controller.currentIndex.value == index
                                            ? ColorResources.sortSelectedColor
                                            : ColorResources.conceptTextColor),
                              );
                            },
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
