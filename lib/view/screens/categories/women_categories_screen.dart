import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import 'package:shimmer/shimmer.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/categories/categories_controller.dart';
import '../../../main_controller.dart';
import '../../components/cached_image.dart';
import '../../components/network_connectivity_view.dart';

class WomenCategoriesScreen extends StatefulWidget {
  const WomenCategoriesScreen({super.key});

  @override
  State<WomenCategoriesScreen> createState() => _WomenCategoriesScreenState();
}

class _WomenCategoriesScreenState extends State<WomenCategoriesScreen> {
  final mainController = Get.put<MainController>(MainController());
  final categoryController =
      Get.put<CategoriesController>(CategoriesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.scaffoldBackgroundColor,
      body: GetBuilder(
        init: MainController(),
        builder: (mainController) {
          return mainController.isNetworkConnection?.value == false
              ? NetworkConnectivityView(
                  onTap: () async {
                    RxBool? isEnableNetwork =
                        await mainController.checkToAssignNetworkConnections();

                    if (isEnableNetwork!.value == true) {
                      categoryController.selectTab(1);
                      categoryController.enableNetworkHideLoader();
                      Future.delayed(
                        const Duration(seconds: 3),
                        () {
                          Get.put<CategoriesController>(CategoriesController());
                          categoryController.disableNetworkLoaderByDefault();
                        },
                      );
                      categoryController.update();
                    }
                  },
                  isLoading: categoryController.isEnableNetwork,
                )
              : SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          LocalStrings.topCategories,
                          style: semiBoldLarge.copyWith(
                            color:
                                ColorResources.buttonColorDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      GetBuilder(
                        init: CategoriesController(),
                        builder: (controller) {
                          // Calculate dynamic item width based on screen size
                          final double itemWidth =
                              (size.width - Dimensions.space30) /
                                  2; // Adjust for spacing

                          return ListView.builder(
                            itemCount: getCategoryData.isEmpty
                                ? (6 / 2).ceil()
                                : (getCategoryData.length / 2).ceil(),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, rowIndex) {
                              final firstIndex = rowIndex * 2;
                              final secondIndex = firstIndex + 1;
                              return getCategoryData.isEmpty
                                  ? Row(
                                      children: [
                                        // First item
                                        SizedBox(
                                          width: itemWidth,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: buildCategoryItemShimmer(
                                                controller, firstIndex, size),
                                          ),
                                        ),

                                        SizedBox(
                                          width: itemWidth,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: buildCategoryItemShimmer(
                                                controller, secondIndex, size),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            // First item
                                            SizedBox(
                                              width: itemWidth,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: buildCategoryItem(
                                                    controller,
                                                    firstIndex,
                                                    size),
                                              ),
                                            ),
                                            if (secondIndex <
                                                getCategoryData.length)
                                              SizedBox(
                                                width: itemWidth,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: buildCategoryItem(
                                                      controller,
                                                      secondIndex,
                                                      size),
                                                ),
                                              ),
                                            if (secondIndex >=
                                                getCategoryData.length)
                                              // Placeholder to maintain spacing if only one item is present
                                              Flexible(
                                                child:
                                                    SizedBox(width: itemWidth),
                                              ),
                                          ],
                                        ),
                                        //Todo : If selected index value & expandedIndex value match this time show subitem view.
                                        if (controller.expandedIndex.value ==
                                                firstIndex ||
                                            controller.expandedIndex.value ==
                                                secondIndex)
                                          buildExpandedContent(
                                              controller,
                                              controller.expandedIndex.value,
                                              size),
                                      ],
                                    );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          LocalStrings.mostBrowsed,
                          style: semiBoldLarge.copyWith(
                            color:
                                ColorResources.buttonColorDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      GetBuilder(
                        init: CategoriesController(),
                        builder: (controller) {
                          // Calculate dynamic item width based on screen size
                          final double itemWidth =
                              (size.width - Dimensions.space30) /
                                  2; // Adjust for spacing
                          return ListView.builder(
                            itemCount: getCategoryMostBrowsedData.isEmpty
                                ? (2 / 2).ceil()
                                : (getCategoryMostBrowsedData.length / 2)
                                    .ceil(),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, rowIndex) {
                              final firstIndex = rowIndex * 2;
                              final secondIndex = firstIndex + 1;

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      // First item
                                      Flexible(
                                        child: SizedBox(
                                          width: itemWidth,
                                          child: getCategoryMostBrowsedData
                                                  .isEmpty
                                              ? mostBrowsedItemShimmer(
                                                  controller, firstIndex, size)
                                              : mostBrowsedItem(
                                                  controller, firstIndex, size),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space10),
                                      if (secondIndex <
                                          getCategoryMostBrowsedData.length)

                                        // First item
                                        Flexible(
                                          child: SizedBox(
                                            width: itemWidth,
                                            child: getCategoryMostBrowsedData
                                                    .isEmpty
                                                ? mostBrowsedItemShimmer(
                                                    controller,
                                                    secondIndex,
                                                    size)
                                                : mostBrowsedItem(controller,
                                                    secondIndex, size),
                                          ),
                                        ),
                                      if (secondIndex >=
                                          getCategoryMostBrowsedData.length)
                                        // Placeholder to maintain spacing if only one item is present
                                        Flexible(
                                          child: SizedBox(width: itemWidth),
                                        ),
                                    ],
                                  ),
                                  if (controller.browsedIndex.value ==
                                          firstIndex ||
                                      controller.browsedIndex.value ==
                                          secondIndex)
                                    mostBrowsedExpandedContent(
                                        controller,
                                        controller.browsedIndex.value,
                                        size,
                                        controller.browsedIndex.value ==
                                                secondIndex
                                            ? LocalStrings.shopGifts
                                            : ''),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space5),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          LocalStrings.silverJewellery,
                          style: semiBoldLarge.copyWith(
                            color:
                                ColorResources.buttonColorDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      GetBuilder(
                        init: CategoriesController(),
                        builder: (controller) {
                          return Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              getCategoryBannerData.isEmpty
                                  ? CarouselSlider.builder(
                                      key: const PageStorageKey(
                                          'carousel_slider_key'),
                                      // Add PageStorageKey
                                      itemCount: 3,
                                      options: CarouselOptions(
                                        onPageChanged: controller
                                            .onPageChangedWomenProducts,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 4 / 1.4,
                                        viewportFraction: 1,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return Shimmer.fromColors(
                                          baseColor: ColorResources.baseColor,
                                          highlightColor:
                                              ColorResources.highlightColor,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.bottomSheetRadius),
                                            child: Container(
                                                color: ColorResources
                                                    .highlightColor),
                                          ),
                                        );
                                      },
                                    )
                                  : CarouselSlider.builder(
                                      key: const PageStorageKey(
                                          'carousel_slider_key'),
                                      // Add PageStorageKey
                                      itemCount: getCategoryBannerData.length,
                                      options: CarouselOptions(
                                        onPageChanged: controller
                                            .onPageChangedWomenProducts,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 4 / 1.4,
                                        viewportFraction: 1,
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.bottomSheetRadius),
                                          child: CachedCommonImage(
                                            networkImageUrl:
                                                getCategoryBannerData[index]
                                                    .bannerImage,
                                            width: double.infinity,
                                          ),
                                        );
                                      },
                                    ),
                              getCategoryBannerData.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        3,
                                        (i) => const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 15),
                                          child: CircleAvatar(
                                            radius: 5,
                                            backgroundColor: ColorResources
                                                .inactiveCardColor,
                                            child: CircleAvatar(
                                              radius: 4,
                                              backgroundColor: ColorResources
                                                  .inactiveCardColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          getCategoryBannerData.length,
                                          (i) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 15),
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor: ColorResources
                                                  .inactiveCardColor,
                                              child: CircleAvatar(
                                                radius: 4,
                                                backgroundColor: controller
                                                            .currentWomenIndex
                                                            .value ==
                                                        i
                                                    ? ColorResources
                                                        .buttonGradientColor
                                                    : ColorResources
                                                        .inactiveCardColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          LocalStrings.needHelp,
                          style: semiBoldLarge.copyWith(
                            color:
                                ColorResources.buttonColorDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                      GetBuilder(
                        init: CategoriesController(),
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.needHelpImageLst.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    AppAnalytics().actionTriggerLogs(
                                        eventName: LocalStrings
                                            .logCategoriesWomenPostCardsView,
                                        index: 10);
                                  } else if (index == 1) {
                                    AppAnalytics().actionTriggerLogs(
                                        eventName: LocalStrings
                                            .logCategoriesWomenClTvView,
                                        index: 11);
                                  } else if (index == 2) {
                                    AppAnalytics().actionTriggerLogs(
                                        eventName: LocalStrings
                                            .logCategoriesWomenPopView,
                                        index: 12);
                                  } else if (index == 3) {
                                    AppAnalytics().actionTriggerLogs(
                                        eventName: LocalStrings
                                            .logCategoriesWomenGoldExchangeView,
                                        index: 13);
                                  } else if (index == 4) {
                                    AppAnalytics().actionTriggerLogs(
                                        eventName: LocalStrings
                                            .logCategoriesWomenDigitalGoldView,
                                        index: 14);
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.11,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  margin: EdgeInsets.only(
                                      bottom: index == 4 ? 10 : 35),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.bottomSheetRadius),
                                    gradient: index == 1
                                        ? LinearGradient(
                                            colors: [
                                              ColorResources.helpNeedFirstColor
                                                  .withOpacity(0.1),
                                              ColorResources.helpNeedFirstColor
                                                  .withOpacity(0.4),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: const [0.1, 0.5],
                                          )
                                        : LinearGradient(
                                            colors: [
                                              ColorResources.offerFirstColor
                                                  .withOpacity(0.5),
                                              ColorResources.offerFirstColor,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: const [0.1, 0.5],
                                          ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: size.height * 0.080,
                                        width: size.width * 0.17,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ColorResources.whiteColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.offersCardRadius),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.offersCardRadius),
                                          child: Image.asset(controller
                                              .needHelpImageLst[index]),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.space15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .needHelpHeadingLst[index],
                                            style: semiBoldDefault.copyWith(
                                                color: ColorResources
                                                    .conceptTextColor),
                                          ),
                                          const SizedBox(
                                              height: Dimensions.space5),
                                          Text(
                                            controller.needHelpTitleLst[index],
                                            style: semiBoldSmall.copyWith(
                                              color: ColorResources
                                                  .conceptTextColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                          Text(
                                            controller
                                                .needHelpSubtitleLst[index],
                                            style: semiBoldSmall.copyWith(
                                                color:
                                                    ColorResources.offerColor),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: size.height * 0.50,
                                        width: size.width * 0.090,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorResources.borderColor
                                                  .withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: ColorResources.whiteColor,
                                        ),
                                        child: const Icon(
                                            Icons.arrow_forward_rounded,
                                            color: ColorResources
                                                .conceptTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  //Todo: Top categories items
  Widget buildCategoryItem(
      CategoriesController controller, int index, Size size) {
    bool isSelected = controller.expandedIndex.value == index;

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.setExpandedIndex(-1);
        } else {
          controller.setExpandedIndex(index);

          AppAnalytics().actionTriggerWithProductsLogs(
              eventName:
                  "${getCategoryData[index].category}_${LocalStrings.logCategoriesWomenShopStyleView}",
              productName: getCategoryData[index].category,
              productImage: getCategoryData[index].categoryImage,
              index: 1);
        }
        // By default open 0 index tab swift conditioned so 0=1 & 1=0 tab
        controller.selectTab(1);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(bottom: 17),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorResources.conceptTextColor.withOpacity(0.01)
              : ColorResources.cardBgColor,
          borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
          border: Border.all(
              color: isSelected
                  ? ColorResources.conceptTextColor
                  : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: ColorResources.borderColor.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: size.height * 0.080,
                  width: size.width * 0.17,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.offersCardRadius),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorResources.shimmerEffectBaseColor,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.offersCardRadius),
                    child: CachedCommonImage(
                      width: double.infinity,
                      networkImageUrl: getCategoryData[index].categoryImage,
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.space10),
                Expanded(
                  child: Text(getCategoryData[index].category ?? '',
                      softWrap: true,
                      maxLines: 2,
                      style: semiBoldDefault.copyWith(
                          color: ColorResources.conceptTextColor)),
                ),
                Image.asset(
                    controller.expandedIndex.value == index
                        ? MyImages.downgradeArrowImage
                        : MyImages.forwordArrowImage,
                    height: 20,
                    width: 20,
                    color: ColorResources.conceptTextColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

//Todo : Shimmer Effect show top categories
  Widget buildCategoryItemShimmer(
      CategoriesController controller, int index, Size size) {
    bool isSelected = controller.expandedIndex.value == index;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorResources.conceptTextColor.withOpacity(0.01)
            : ColorResources.cardBgColor,
        borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
        border: Border.all(
            color: isSelected
                ? ColorResources.conceptTextColor
                : Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: ColorResources.borderColor.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: ColorResources.baseColor,
                highlightColor: ColorResources.highlightColor,
                child: Container(
                  height: size.height * 0.080,
                  width: size.width * 0.17,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.offersCardRadius),
                      color: ColorResources.whiteColor),
                ),
              ),
              const SizedBox(width: Dimensions.space10),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: Container(
                    height: size.height * 0.015,
                    decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: ColorResources.baseColor,
                highlightColor: ColorResources.highlightColor,
                child: Image.asset(MyImages.forwordArrowImage,
                    height: 20,
                    width: 20,
                    color: ColorResources.conceptTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Most Browsed
  Widget mostBrowsedItem(
      CategoriesController controller, int index, Size size) {
    bool isSelected = controller.browsedIndex.value == index;

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.setMostBrowsedIndex(-1);
        } else {
          controller.setMostBrowsedIndex(index);
          AppAnalytics().actionTriggerWithProductsLogs(
              eventName:
                  "${getCategoryMostBrowsedData[index].category}_${LocalStrings.logCategoriesWomenMostBrowsedView}",
              productName: getCategoryMostBrowsedData[index].category,
              productImage: getCategoryMostBrowsedData[index].categoryImage,
              index: 1);
        }
      },
      child: Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(bottom: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.categoriesRadius),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.height * 0.14,
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.offerSixColor),
                borderRadius:
                    BorderRadius.circular(Dimensions.categoriesRadius),
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.categoriesRadius),
                child: CachedCommonImage(
                  width: double.infinity,
                  networkImageUrl:
                      getCategoryMostBrowsedData[index].categoryImage,
                ),
              ),
            ),
            Container(
              height: size.height * 0.040,
              decoration: const BoxDecoration(
                color: ColorResources.offerSixColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.categoriesRadius),
                    bottomRight: Radius.circular(Dimensions.categoriesRadius)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: Dimensions.space10),
                  Text(getCategoryMostBrowsedData[index].category ?? '',
                      style: semiBoldDefault.copyWith(
                          color: ColorResources.conceptTextColor)),
                  const SizedBox(width: Dimensions.space10),
                  Image.asset(
                      controller.browsedIndex.value == index
                          ? MyImages.downgradeArrowImage
                          : MyImages.forwordArrowImage,
                      height: 20,
                      width: 20,
                      color: ColorResources.conceptTextColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Most Browsed Shimmer
  Widget mostBrowsedItemShimmer(
      CategoriesController controller, int index, Size size) {
    bool isSelected = controller.browsedIndex.value == index;

    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.categoriesRadius),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Shimmer.fromColors(
            baseColor: ColorResources.baseColor,
            highlightColor: ColorResources.highlightColor,
            child: Container(
              height: size.height * 0.14,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: ColorResources.offerSixColor),
                color: ColorResources.highlightColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.categoriesRadius),
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.categoriesRadius),
              ),
            ),
          ),
          Container(
            height: size.height * 0.040,
            decoration: const BoxDecoration(
              color: ColorResources.offerSixColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.categoriesRadius),
                  bottomRight: Radius.circular(Dimensions.categoriesRadius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: Dimensions.space10),
                Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: Container(
                    height: size.height * 0.015,
                    width: size.width * 0.200,
                    decoration: BoxDecoration(
                        color: ColorResources.whiteColor,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: ColorResources.baseColor,
                  highlightColor: ColorResources.highlightColor,
                  child: Image.asset(MyImages.forwordArrowImage,
                      height: 20,
                      width: 20,
                      color: ColorResources.conceptTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpandedContent(
      CategoriesController controller, int index, Size size) {
    bool isLeftChevron = index % 2 == 0;
    return GetBuilder(
        init: CategoriesController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0, top: 10),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 25, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorResources.conceptTextColor.withOpacity(0.01),
                    borderRadius:
                        BorderRadius.circular(Dimensions.bottomSheetRadius),
                    border: Border.all(
                        color: ColorResources.conceptTextColor,
                        width: 1), // Set border color and thickness
                  ),
                  child: Column(
                    children: [
                      // Button style show tab bar animation type so 0 index ontap send 1 index so swap set condition 0 =1 index and 1=0 index
                      Container(
                        height: size.height * 0.050,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
                        decoration: BoxDecoration(
                          color: ColorResources.whiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectTab(1);
                                  AppAnalytics().actionTriggerWithProductsLogs(
                                      eventName: LocalStrings
                                          .logCategoriesWomenShopStyleView,
                                      index: 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    color: controller.selectedTab.value == 0
                                        ? ColorResources.whiteColor
                                        : ColorResources.cardTabColor,
                                  ),
                                  child: Center(
                                    child: Text(LocalStrings.shopStyle,
                                        style: semiBoldDefault.copyWith(
                                            color:
                                                controller.selectedTab.value ==
                                                        0
                                                    ? ColorResources
                                                        .buttonColorDark
                                                        .withOpacity(0.7)
                                                    : ColorResources.whiteColor,
                                            fontWeight:
                                                controller.selectedTab.value ==
                                                        1
                                                    ? FontWeight.w400
                                                    : FontWeight.w600)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.space20),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectTab(0);
                                  AppAnalytics().actionTriggerWithProductsLogs(
                                      eventName: LocalStrings
                                          .logCategoriesWomenShopByPriceView,
                                      index: 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    color: controller.selectedTab.value == 1
                                        ? ColorResources.whiteColor
                                        : ColorResources.cardTabColor,
                                  ),
                                  child: Center(
                                    child: Text(LocalStrings.shopByPrice,
                                        style: semiBoldDefault.copyWith(
                                            color:
                                                controller.selectedTab.value ==
                                                        1
                                                    ? ColorResources
                                                        .buttonColorDark
                                                        .withOpacity(0.7)
                                                    : ColorResources.whiteColor,
                                            fontWeight:
                                                controller.selectedTab.value ==
                                                        1
                                                    ? FontWeight.w400
                                                    : FontWeight.w600)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space20),
                      if (controller.selectedTab.value == 1) ...[
                        // Content for Tab Shop By Style
                        GridView.builder(
                          itemCount: getCategoryData[index].subCategory!.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 7 / 13,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.filterCategoriesApiMethod(
                                    occasionBy: getCategoryData[
                                            controller.expandedIndex.value]
                                        .subCategory![index]
                                        .subCategory,
                                    priceLimit: '');
                                Get.toNamed(RouteHelper.collectionScreen);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.10,
                                    decoration: BoxDecoration(
                                      color: ColorResources.whiteColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.categoriesRadius),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.categoriesRadius),
                                      child: CachedCommonImage(
                                        width: double.infinity,
                                        networkImageUrl: getCategoryData[
                                                controller.expandedIndex.value]
                                            .subCategory![index]
                                            .image01,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.space5),
                                  Expanded(
                                    child: Text(
                                        getCategoryData[controller
                                                    .expandedIndex.value]
                                                .subCategory![index]
                                                .title ??
                                            '',
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: semiBoldDefault.copyWith(
                                            color: ColorResources
                                                .conceptTextColor)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ] else ...[
                        // Content for Tab shop by price
                        GridView.builder(
                          itemCount: controller.shopPriceNameLst.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 7 / 5,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: size.height * 0.065,
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                    color: ColorResources.whiteColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.defaultRadius),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorResources.borderColor
                                            .withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                        controller.shopPriceNameLst[index],
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: mediumDefault.copyWith(
                                            color: ColorResources
                                                .conceptTextColor)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  top: -19,
                  // Adjust this value to position the chevron correctly
                  left: isLeftChevron ? 20 : null,
                  // Position chevron based on its direction
                  right: isLeftChevron ? null : 20,
                  child: CustomPaint(
                    size: const Size(20, 20),
                    painter: ChevronPainter(isLeftChevron),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Widget mostBrowsedExpandedContent(CategoriesController controller, int index,
    Size size, String typeDataShow) {
  bool isLeftChevron = index % 2 == 0;
  printAction(
      "Check list : ${getCategoryMostBrowsedData[index].subCategory?.length}");
  return GetBuilder(
      init: CategoriesController(),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 25, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorResources.conceptTextColor.withOpacity(0.01),
                  borderRadius:
                      BorderRadius.circular(Dimensions.bottomSheetRadius),
                  border: Border.all(
                      color: ColorResources.conceptTextColor,
                      width: 1), // Set border color and thickness
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.22,
                      child: ListView.builder(
                        itemCount: getCategoryMostBrowsedData[index]
                            .subCategory
                            ?.length,
                        padding: const EdgeInsets.only(right: 10),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, indexSubCategories) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.filterCategoriesApiMethod(
                                      occasionBy:
                                          getCategoryMostBrowsedData[index]
                                              .subCategory?[indexSubCategories]
                                              .subCategory,
                                      priceLimit: '');
                                  Get.toNamed(RouteHelper.collectionScreen);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.fullRadius),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: ColorResources.borderColor,
                                        offset: Offset(0, 1),
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: size.height * 0.22,
                                        width: size.width * 0.40,
                                        padding:  EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.fullRadius),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.fullRadius),
                                          child: CachedCommonImage(
                                            width: double.infinity,
                                            networkImageUrl:
                                                getCategoryMostBrowsedData[index]
                                                    .subCategory?[
                                                        indexSubCategories]
                                                    .image01,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        child: Container(
                                          height: size.height * 0.050,
                                          width: size.width * 0.27,
                                          decoration: BoxDecoration(
                                            color: ColorResources.whiteColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.offersCardRadius),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorResources.borderColor
                                                    .withOpacity(0.1),
                                                spreadRadius: 3,
                                                blurRadius: 2,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                                getCategoryMostBrowsedData[index]
                                                        .subCategory?[
                                                            indexSubCategories]
                                                        .title ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                                maxLines: 2,
                                                style: semiBoldDefault.copyWith(
                                                    color: ColorResources
                                                        .conceptTextColor)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // const SizedBox(height: Dimensions.space20),
                    // Text(LocalStrings.youMay,
                    //     textAlign: TextAlign.center,
                    //     softWrap: true,
                    //     maxLines: 2,
                    //     style: semiBoldDefault.copyWith(
                    //         color: ColorResources.buttonColorDark
                    //             .withOpacity(0.7))),
                    // const SizedBox(height: Dimensions.space15),
                    // GridView.builder(
                    //   itemCount: controller.alsoLikeBrowsedNameLst.length,
                    //   shrinkWrap: true,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 3,
                    //           childAspectRatio: 7 / 5,
                    //           crossAxisSpacing: 10),
                    //   itemBuilder: (context, index) {
                    //     return Column(
                    //       children: [
                    //         Container(
                    //           height: size.height * 0.065,
                    //           width: size.width * 0.25,
                    //           decoration: BoxDecoration(
                    //             color: ColorResources.whiteColor,
                    //             borderRadius: BorderRadius.circular(
                    //                 Dimensions.defaultRadius),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: ColorResources.borderColor
                    //                     .withOpacity(0.1),
                    //                 spreadRadius: 3,
                    //                 blurRadius: 2,
                    //                 offset: const Offset(0, 2),
                    //               ),
                    //             ],
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //                 controller.alsoLikeBrowsedNameLst[index],
                    //                 textAlign: TextAlign.center,
                    //                 softWrap: true,
                    //                 maxLines: 2,
                    //                 style: mediumDefault.copyWith(
                    //                     color:
                    //                         ColorResources.conceptTextColor)),
                    //           ),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              Positioned(
                top: -19,
                // Adjust this value to position the chevron correctly
                left: isLeftChevron ? 20 : null,
                // Position chevron based on its direction
                right: isLeftChevron ? null : 20,
                child: CustomPaint(
                  size: const Size(20, 20),
                  painter: ChevronPainter(isLeftChevron),
                ),
              ),
            ],
          ),
        );
      });
}

class ChevronPainter extends CustomPainter {
  final bool isLeftChevron;

  ChevronPainter(this.isLeftChevron);

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = Colors.transparent // Chevron fill color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = ColorResources.conceptTextColor // Border color for sides
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final borderPath = Path();
    final bottomBorderPaint = Paint()
      ..color = ColorResources.whiteColor // Bottom border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    if (isLeftChevron) {
      path.moveTo(0, size.height); // Bottom-left corner
      path.lineTo(size.width, size.height); // Bottom-right corner
      path.lineTo(size.width / 2, 0); // Top-center
    } else {
      path.moveTo(size.width, size.height); // Bottom-right corner
      path.lineTo(0, size.height); // Bottom-left corner
      path.lineTo(size.width / 2, 0); // Top-center
    }
    path.close();

    // Draw the chevron fill
    canvas.drawPath(path, fillPaint);

    // Draw border color on all sides except the bottom
    final borderPathSides = Path();
    if (isLeftChevron) {
      borderPathSides.moveTo(0, size.height); // Bottom-left corner
      borderPathSides.lineTo(size.width, size.height); // Bottom-right corner

      borderPathSides.moveTo(0, size.height); // Bottom-left corner to top-left
      borderPathSides.lineTo(size.width / 2, 0); // Top-center

      borderPathSides.moveTo(
          size.width, size.height); // Bottom-right corner to top-right
      borderPathSides.lineTo(size.width / 2, 0); // Top-center
    } else {
      borderPathSides.moveTo(size.width, size.height); // Bottom-right corner
      borderPathSides.lineTo(0, size.height); // Bottom-left corner

      borderPathSides.moveTo(
          size.width, size.height); // Bottom-right corner to top-right
      borderPathSides.lineTo(size.width / 2, 0); // Top-center

      borderPathSides.moveTo(0, size.height); // Bottom-left corner to top-left
      borderPathSides.lineTo(size.width / 2, 0); // Top-center
    }

    // Draw border on all sides except the bottom
    canvas.drawPath(borderPathSides, borderPaint);

    // Draw white border on the bottom side
    final borderPathBottom = Path();
    if (isLeftChevron) {
      borderPathBottom.moveTo(0, size.height); // Bottom-left corner
      borderPathBottom.lineTo(size.width, size.height); // Bottom-right corner
    } else {
      borderPathBottom.moveTo(size.width, size.height); // Bottom-right corner
      borderPathBottom.lineTo(0, size.height); // Bottom-left corner
    }

    canvas.drawPath(borderPathBottom, bottomBorderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
