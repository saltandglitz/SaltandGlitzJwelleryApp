import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/categories/categories_controller.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/collection/collection_controller.dart';
import '../../../data/controller/collection_filter/collection_filter_controller.dart';
import '../../components/app_bar_background.dart';
import '../../components/common_button.dart';

class CollectionFilterScreen extends StatefulWidget {
  const CollectionFilterScreen({super.key});

  @override
  State<CollectionFilterScreen> createState() => _CollectionFilterScreenState();
}

class _CollectionFilterScreenState extends State<CollectionFilterScreen> {
  final categoriesController =
  Get.put<CategoriesController>(CategoriesController());  final collectionController =
  Get.put<CollectionController>(CollectionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppAnalytics().actionTriggerLogs(
        eventName: LocalStrings.logCollectionFilterView, index: 7);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return GetBuilder(
        init: CollectionFilterController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorResources.scaffoldBackgroundColor,
            appBar: AppBarBackground(
              child: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title:  Text(LocalStrings.filters),
                titleTextStyle: regularLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorResources.conceptTextColor,
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  color: ColorResources.conceptTextColor,
                ),

                backgroundColor: ColorResources.whiteColor,
                // Set the background color of the AppBar
                elevation: 0, // Remove default shadow
              ),
            ),
            body: Row(
              children: [
                Container(
                  width: size.width * 0.43,
                  color: ColorResources.offerNineColor.withOpacity(0.1),
                  child: ListView.builder(
                    itemCount: controller.categories.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      var category = controller.categories[index];
                      var filters = controller.filters[category] ?? [];
                      var selectedCount = filters
                          .where((filter) =>
                          controller.selectedFilters.contains(filter))
                          .length;

                      return Obx(() =>
                          Column(
                            children: [
                              const SizedBox(height: Dimensions.space5),
                              ListTile(
                                dense: true,
                                minTileHeight: 10,
                                title: Text(
                                  controller.categories[index],
                                  style: semiBoldDefault.copyWith(
                                    color: controller.selectedCategory.value ==
                                        index
                                        ? ColorResources.cardTabColor
                                        : ColorResources.buttonColorDark
                                        .withOpacity(0.5),
                                    fontWeight:
                                    controller.selectedCategory.value ==
                                        index
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                                selected:
                                controller.selectedCategory.value == index,
                                trailing: selectedCount > 0
                                    ? Container(
                                  height: size.height * 0.027,
                                  width: size.width * 0.055,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.smallRadius),
                                    color: ColorResources.cardTabColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedCount.toString(),
                                      // You can customize the text here
                                      style: boldDefault.copyWith(
                                          color:
                                          ColorResources.whiteColor),
                                    ),
                                  ),
                                )
                                    : null,
                                // If no filter is selected, don't show the trailing widget
                                onTap: () {
                                  controller.updateCategory(index);
                                },
                              ),
                              if (index != controller.categories.length - 1)
                                Divider(
                                  color: ColorResources.buttonColorDark
                                      .withOpacity(0.1),
                                ),
                            ],
                          ));
                    },
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    var selectedCategoryName = controller
                        .categories[controller.selectedCategory.value];
                    var selectedCategoryFilters =
                        controller.filters[selectedCategoryName] ?? [];
                    return ListView.builder(
                      itemCount: selectedCategoryFilters.length,
                      itemBuilder: (context, index) {
                        var filter = selectedCategoryFilters[index];
                        return Obx(() =>
                            Container(
                              color: ColorResources.whiteColor,
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                minTileHeight: size.height * 0.060,
                                title: Text(
                                  filter,
                                  maxLines: 2,
                                  style: semiBoldSmall.copyWith(
                                      color: controller.selectedFilters
                                          .contains(filter)
                                          ? ColorResources.deliveryColorColor
                                          : ColorResources.conceptTextColor),
                                ),
                                leading: Icon(
                                  Icons.check_rounded,
                                  size: 20,
                                  color: controller.selectedFilters
                                      .contains(filter)
                                      ? ColorResources.deliveryColorColor
                                      : ColorResources.offerThirdTextColor,
                                ),
                                onTap: () {
                                  controller.toggleFilter(filter);
                                },
                              ),
                            ));
                      },
                    );
                  }),
                ),
              ],
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

                        /// Analytics set clear all filter products log
                        AppAnalytics().actionTriggerLogs(
                            eventName: LocalStrings.logCollectionClearAllFilter,
                            index: 7);
                      },
                      height: size.height * 0.050,
                      buttonName: LocalStrings.clearAll,
                      buttonColor: ColorResources.buttonColorDark,
                      textStyle: semiBoldDefault.copyWith(),
                      gradientFirstColor: ColorResources.offerThirdTextColor,
                      gradientSecondColor: ColorResources.offerThirdTextColor,
                    ),
                  ), // Common Place order button
                  const SizedBox(width: Dimensions.space15),
                  Expanded(
                    child: CommonButton(
                      onTap: () {
                        // Get.back();
                        /// Final data to send in api database like :  Discount Ranges: {15-20%, Below 10%}, Weight Ranges: {2-5 g}, Material: {Gemstone, Solitaire},
                        controller.logSelectedFilters();
                        //Todo : Filter products using filter api method
                        categoriesController.filterCategoriesApiMethod(
                            isFilterScreen: "YES",
                            priceLimitList: controller
                                .getFormattedFilters()[LocalStrings.price],
                            productTypeList:controller
                                .getFormattedFilters()[LocalStrings.productsType],
                            materialList:controller
                                .getFormattedFilters()[LocalStrings.material],
                            shopForList:controller
                                .getFormattedFilters()[LocalStrings.shopFor],
                            occasionByList:controller
                                .getFormattedFilters()[LocalStrings.occasion],
                            giftsList:controller
                                .getFormattedFilters()[LocalStrings.gifts],
                        );
                        Get.put<CollectionController>(
                            CollectionController());
                        collectionController.hideSearchField();
                        Get.back();
                      },
                      height: size.height * 0.050,
                      buttonName: LocalStrings.applyFilters,
                      textStyle: semiBoldDefault.copyWith(
                          color: ColorResources.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
