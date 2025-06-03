import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/data/controller/dashboard/dashboard_controller.dart';
import 'package:saltandGlitz/data/product/product_controller.dart';
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
    final categoryName = ModalRoute.of(context)?.settings.arguments as String?;
    final categoryFemale =
        ModalRoute.of(context)?.settings.arguments as String?;
    final categoryMale = ModalRoute.of(context)?.settings.arguments as String?;
    print("Category Name: $categoryName");
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
                          color: ColorResources.iconColor);
                },
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.wishlistScreen)!.then(
                      (value) {
                        //Todo : Wishlist screen locally remove to products move back update list
                        collectionController.update();
                      },
                    );
                  },
                  icon: const Icon(Icons.favorite_rounded),
                  color: ColorResources.iconColor),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.addCartScreen);
                      },
                      icon: const Icon(Icons.shopping_cart),
                      color: ColorResources.iconColor),
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
          height: size.height * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                ColorResources.buttonColor,
                ColorResources.buttonSecondColor,
              ],
            ),
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
                    // const SizedBox(width: Dimensions.space15),
                    // Container(
                    //   height: size.height * 0.027,
                    //   width: size.width * 0.055,
                    //   decoration: BoxDecoration(
                    //       borderRadius:
                    //           BorderRadius.circular(Dimensions.smallRadius),
                    //       color: ColorResources.cardTabColor),
                    //   child: Center(
                    //     child: Text(
                    //       LocalStrings.quantityFirst,
                    //       style: boldDefault.copyWith(
                    //           color: ColorResources.whiteColor),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        /* floatingActionButton: GetBuilder(
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
                        ? ColorResources.buttonColor.withOpacity(0.3)
                        : ColorResources.buttonColor,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.call,
                    color: ColorResources.whiteColor,
                  )),
                ),
              );
            }),*/
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
                            (size.width - Dimensions.space30) / 2;
                        return GestureDetector(
                          onTap: () {
                            dashboardController.hideSearchMethod();
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: size.height * 0.12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorResources.lightGreenColour
                                          .withOpacity(0.25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${categoryName ?? categoryFemale ?? categoryMale ?? "All"} Designs",
                                                style: semiBoldMediumLarge
                                                    .copyWith(
                                                        color: ColorResources
                                                            .buttonColor),
                                              ),
                                              const SizedBox(
                                                  width: Dimensions.space10),
                                              Text(
                                                "${filterProductData.length} Designs",
                                                style: semiBoldDefault.copyWith(
                                                  color: ColorResources
                                                      .buttonColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space5),
                                          Text(
                                            "HOME > JEWELLERY > ${categoryName ?? categoryFemale ?? categoryMale ?? "All"}"
                                                .toUpperCase(),
                                            style: mediumExtraSmall.copyWith(
                                                color:
                                                    ColorResources.buttonColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space10),
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
                                                itemBuilder: (context, index) {
                                                  final firstIndex = index * 2;
                                                  final secondIndex =
                                                      firstIndex + 1;
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: itemWidth,
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
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              3,
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
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .padding
                                                                  .top *
                                                              5),
                                                  child: Text(
                                                    LocalStrings
                                                        .collectionEmpty,
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                    style:
                                                        semiBoldLarge.copyWith(
                                                      color: ColorResources
                                                          .buttonColor,
                                                    ),
                                                  ),
                                                )
                                              : Expanded(
                                                  child: ListView.builder(
                                                    controller:
                                                        dashboardController
                                                            .listViewController,
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
                                                                child: SizedBox(
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
                                                                            onTap:
                                                                                () {
                                                                              // First index used stored data sqflite
                                                                              controller.addProduct(
                                                                                filterProductData[firstIndex].media![0].productAsset ?? '',
                                                                                filterProductData[firstIndex].title ?? '',
                                                                                "${filterProductData[firstIndex].price14KT}",
                                                                                "${filterProductData[firstIndex].productId}",
                                                                              );

                                                                              //Todo : Id product detail using remove wishlist this time then using update screen
                                                                              Get.toNamed(
                                                                                RouteHelper.productScreen,
                                                                                arguments: [
                                                                                  filterProductData[firstIndex],
                                                                                  firstIndex
                                                                                ],
                                                                              )!
                                                                                  .then(
                                                                                (value) {
                                                                                  controller.update();
                                                                                },
                                                                              );

                                                                              /// Product screen seen product analysis log
                                                                              AppAnalytics().actionTriggerWithProductsLogs(
                                                                                eventName: LocalStrings.logProductDetailView,
                                                                                productName: filterProductData[firstIndex].title ?? '',
                                                                                productImage: filterProductData[firstIndex].media![0].productAsset!,
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
                                                                          controller
                                                                              .addProduct(
                                                                            filterProductData[secondIndex].media![0].productAsset ??
                                                                                '',
                                                                            filterProductData[secondIndex].title ??
                                                                                '',
                                                                            "${filterProductData[firstIndex].price14KT}",
                                                                            "${filterProductData[firstIndex].productId}",
                                                                          );
                                                                          //Todo : Id product detail using remove wishlist this time then using update screen
                                                                          Get.toNamed(
                                                                            RouteHelper.productScreen,
                                                                            arguments: [
                                                                              filterProductData[secondIndex],
                                                                              secondIndex
                                                                            ],
                                                                          )!
                                                                              .then(
                                                                            (value) {
                                                                              controller.update();
                                                                            },
                                                                          );
                                                                        },
                                                                        child: collectionItems(
                                                                            secondIndex),
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
                                () => dashboardController.isDialogVisible.value
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.090),
                                        child: Container(
                                          height: dashboardController
                                                      .searchProducts.length <
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
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ColorResources.whiteColor,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: ColorResources
                                                    .inactiveTabColor,
                                                offset: Offset(0, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.defaultRadius),
                                          ),
                                          child:
                                              dashboardController
                                                          .isSearchShimmer
                                                          .value ==
                                                      true
                                                  ? GridView.builder(
                                                      itemCount: 9,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 11.0,
                                                        mainAxisSpacing: 15.0,
                                                      ),
                                                      itemBuilder:
                                                          (context, index) {
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
                                                                offset: Offset(
                                                                    0, 1),
                                                                blurRadius: 2,
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
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius.circular(
                                                                        Dimensions
                                                                            .defaultRadius),
                                                                    topRight: Radius.circular(
                                                                        Dimensions
                                                                            .defaultRadius),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: 90,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorResources
                                                                          .whiteColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3),
                                                                    ),
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
                                                                  height:
                                                                      size.height *
                                                                          0.015,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorResources
                                                                        .whiteColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style: semiBoldLarge
                                                                .copyWith(
                                                              color: ColorResources
                                                                  .buttonColor,
                                                            ),
                                                          ),
                                                        )
                                                      : GridView.builder(
                                                          itemCount:
                                                              dashboardController
                                                                  .searchProducts
                                                                  .length,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 10),
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                11.0,
                                                            mainAxisSpacing:
                                                                15.0,
                                                          ),
                                                          itemBuilder:
                                                              (context, index) {
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
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(
                                                                      RouteHelper
                                                                          .collectionScreen);
                                                                  categoriesController.filterCategoriesApiMethod(
                                                                      occasionBy: dashboardController
                                                                          .searchProducts[
                                                                              index]
                                                                          .subCategory,
                                                                      priceLimit:
                                                                          '');
                                                                  dashboardController
                                                                      .hideSearchMethod();
                                                                  //Todo : Search box hide
                                                                  dashboardController
                                                                      .isDialogVisible
                                                                      .value = false;
                                                                },
                                                                child: Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(Dimensions.defaultRadius),
                                                                        topRight:
                                                                            Radius.circular(Dimensions.defaultRadius),
                                                                      ),
                                                                      child:
                                                                          CachedCommonImage(
                                                                        networkImageUrl: dashboardController
                                                                            .searchProducts[index]
                                                                            .image01,
                                                                        // categoryList[index]
                                                                        //         .images,
                                                                        width: double
                                                                            .infinity,
                                                                        height: size.height *
                                                                            0.11,
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                2),
                                                                        child:
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
                                                                            color:
                                                                                ColorResources.buttonColor,
                                                                          ),
                                                                        ),
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
                      },
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget collectionItems(int index) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GetBuilder(
        init: CollectionController(),
        builder: (controller) {
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
                    decoration: BoxDecoration(
                      color: ColorResources.borderColor.withOpacity(0.050),
                      borderRadius: BorderRadius.circular(12), // added radius
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(12), // apply radius to image
                      child: CachedCommonImage(
                        networkImageUrl:
                            filterProductData[index].media![0].productAsset!,
                        height: size.height * 0.17,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        // Todo : Declared latest or not
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
                        //           color: ColorResources.buttonColor),
                        //     ),
                        //   ),
                        // ),
                        const Spacer(),
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.099,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.smallRadius),
                            color: Colors.transparent,
                          ),
                          child: LikeButton(
                            circleColor: const CircleColor(
                              start: Color(0xff00ddff),
                              end: Color(0xff0099cc),
                            ),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: ColorResources.notValidateColor,
                              dotSecondaryColor:
                                  ColorResources.notValidateColor,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                filterProductData[index].isAlready == true
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color:
                                    filterProductData[index].isAlready == true
                                        ? ColorResources.notValidateColor
                                        : ColorResources.inactiveTabColor,
                              );
                            },
                            onTap: (isLiked) async {
                              if (filterProductData[index].isAlready == true) {
                                //Todo : Remove Wishlist particular products api method
                                controller.removeWishlistApiMethod(
                                  productId: filterProductData[index].productId,
                                );
                                filterProductData[index].isAlready = false;
                                controller.update();
                              } else {
                                final productController =
                                    Get.put<ProductController>(
                                        ProductController());
                                filterProductData[index].isAlready = true;
                                controller.update();
                                //Todo : Wishlist particular products api method
                                controller.favoritesProducts(
                                  userId: PrefManager.getString('userId') ?? '',
                                  productId: filterProductData[index].productId,
                                  index: index,
                                  size: filterProductData[index]
                                      .netWeight14KT
                                      ?.toInt(),
                                  carat: productController.jewelleryKt(),
                                  color: productController.jewelleryColor(),
                                );
                              }
                              return !isLiked; // toggle like/unlike
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height * 0.025,
                      width: size.width * 0.12,
                      margin: const EdgeInsets.only(left: 15, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.bottomSheetRadius),
                        border: Border.all(color: ColorResources.buttonColor),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${filterProductData[index].avgRating ?? 0.toInt()}",
                              style: semiBoldSmall.copyWith(
                                  color: ColorResources.buttonColor),
                            ),
                            const SizedBox(width: Dimensions.space3),
                            Icon(
                              Icons.star,
                              color: filterProductData[index].avgRating ==
                                          null ||
                                      filterProductData[index].avgRating == 0.0
                                  ? ColorResources.borderColor
                                  : ColorResources.updateCardColor,
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
                          "₹${filterProductData[index].total14KT?.round()}",
                          style: semiBoldDefault.copyWith(
                              color: ColorResources.buttonColor),
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
                      filterProductData[index].title ?? '',
                      maxLines: 2,
                      style: semiBoldSmall.copyWith(
                          color: ColorResources.buttonColor),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
                      //           color: ColorResources.buttonColor),
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
                      //     color: ColorResources.buttonColor,
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
                      border: Border.all(color: ColorResources.buttonColor),
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
                                    Dimensions.smallRadius),
                              ),
                            ),
                          ),
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.smallRadius),
                          ),
                        ),
                      ),
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
                  const SizedBox(height: Dimensions.space7),
                  Shimmer.fromColors(
                    baseColor: ColorResources.baseColor,
                    highlightColor: ColorResources.highlightColor,
                    child: Container(
                      height: 10,
                      width: size.width * 0.15,
                      decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.smallRadius),
                      ),
                    ),
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
          topLeft: Radius.circular(Dimensions.bottomSheetRadius),
        ),
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
                          color: ColorResources.buttonColor),
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
                              CollectionController(),
                            );
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
                                            : ColorResources.buttonColor),
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
