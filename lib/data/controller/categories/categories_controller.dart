import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/data/controller/collection/collection_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../api_repository/api_function.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/app_const.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../local_storage/pref_manager.dart';
import '../../model/categories_filter_view_model.dart';
import '../../model/get_categories_view_model.dart';

class CategoriesController extends GetxController {
  // late TabController _tabController;
  var expandedIndex = (-1).obs;
  var browsedIndex = (-1).obs;
  var menExpandedIndex = (-1).obs;
  var menBrowsedExpandedIndex = (-1).obs;
  var currentWomenIndex = 0.obs;
  var currentMenIndex = 0.obs;
  RxBool isShimmering = true.obs; // RxBool to manage shimmer state
  // Observable variable to keep track of the selected tab
  var selectedTab = 0.obs;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: LocalStrings.women),
    const Tab(text: LocalStrings.men),
  ];

  List womenTopCategoriesImage = [
    MyImages.ringsCategories,
    MyImages.earingsCategories,
    MyImages.braceletsCategories,
    MyImages.solitaireCategories,
    MyImages.necklacesCategories,
    MyImages.mangalsutraCategories,
  ];

  // Men categories
  List menTopCategoriesImage = [
    MyImages.studsMenImage,
    MyImages.ringsMenImage,
    MyImages.pendantsMenImage,
    MyImages.braceletsMenImage,
    MyImages.kadaMenImage,
    MyImages.allDesignsMenImage,
  ];
  List womenTopCategoriesName = [
    LocalStrings.rings,
    LocalStrings.earings,
    LocalStrings.bracelets,
    LocalStrings.solitaire,
    LocalStrings.necklaces,
    LocalStrings.mangalsutra,
  ];
  List menTopCategoriesName = [
    LocalStrings.studs,
    LocalStrings.braceletsText,
    LocalStrings.kada,
    LocalStrings.allDesigns,
    LocalStrings.shopPrice,
    LocalStrings.giftHim
  ];
  List mostBrowsedImage = [
    MyImages.moreJewelleryImage,
    MyImages.shopGiftsImage
  ];
  List mostBrowsedNamed = [LocalStrings.moreJewellery, LocalStrings.shopGifts];
  List mostMenBrowsedNamed = [LocalStrings.shopPrice, LocalStrings.giftHim];
  List silverJewelleryImage = [
    MyImages.jewelleryWeddingFirstImage,
    MyImages.jewelleryWeddingSecondImage,
    MyImages.jewelleryWeddingThirdImage
  ];

  List shopStyleImageLst = [
    MyImages.allRingsImage,
    MyImages.engagementRingImage,
    MyImages.solitaireImage,
    MyImages.dailywearImage,
    MyImages.platinumRingImage,
    MyImages.bandsImage,
    MyImages.cocktailImage,
    MyImages.coupleRingImage,
  ];
  List shopStyleNameLst = [
    LocalStrings.allRings,
    LocalStrings.engagement,
    LocalStrings.solitaire,
    LocalStrings.dailywear,
    LocalStrings.platinumRings,
    LocalStrings.bands,
    LocalStrings.cocktail,
    LocalStrings.coupleRings,
  ];

  List shopPriceNameLst = [
    LocalStrings.itemFirstPrice,
    LocalStrings.itemSecondPrice,
    LocalStrings.itemThirdPrice,
    LocalStrings.itemForPrice,
    LocalStrings.itemFivePrice,
    LocalStrings.itemSixPrice,
    LocalStrings.itemSevenPrice,
    LocalStrings.itemEightPrice,
  ];

  List moreJewelleryImageLst = [
    MyImages.pendantsImage,
    MyImages.chainsImage,
    MyImages.nosePinsImage
  ];
  List moreJewelleryNameLst = [
    LocalStrings.pendants,
    LocalStrings.chain,
    LocalStrings.nosePins
  ];
  List menShopPriceNameLst = [
    LocalStrings.aboveMenFirstPrice,
    LocalStrings.aboveMenSecondPrice,
    LocalStrings.aboveMenThirdPrice
  ];
  List shopGiftsImageLst = [
    MyImages.anniversaryGiftsImage,
    MyImages.birthdayGiftsImage,
    MyImages.bestSellingGiftsImage
  ];
  List menGiftsImageLst = [
    MyImages.menAnniversaryGiftImage,
    MyImages.menBirthdayGiftImage,
    MyImages.menMilestoneGiftImage
  ];
  List shopMenGiftsImageLst = [
    MyImages.menPandantsImage,
    MyImages.menRingsImage,
    MyImages.menRingsSecondImage
  ];
  List shopGiftsNameLst = [
    LocalStrings.anniversaryGifts,
    LocalStrings.birthdayGifts,
    LocalStrings.bestSelling
  ];
  List menGiftsNameLst = [
    LocalStrings.anniversaryGifts,
    LocalStrings.birthdayGifts,
    LocalStrings.milestoneGifts
  ];
  List alsoLikeBrowsedNameLst = [
    LocalStrings.charms,
    LocalStrings.noseRings,
    LocalStrings.platinum,
    LocalStrings.watchCharms,
    LocalStrings.kt,
    LocalStrings.allCollection
  ];
  List menShopByNameLst = [
    LocalStrings.menPlatinum,
    LocalStrings.menGold,
    LocalStrings.menDiamond
  ];

  List needHelpImageLst = [
    MyImages.postCardImage,
    MyImages.planPurchaseImage,
  ];
  List needHelpHeadingLst = [
    LocalStrings.saltAndGlitzPostcards,
    LocalStrings.pop,
  ];
  List needHelpTitleLst = [
    LocalStrings.embedVideo,
    LocalStrings.planYour,
  ];
  List needHelpSubtitleLst = [
    LocalStrings.knowMore,
    LocalStrings.learnMore,
  ];
  RxBool isEnableNetwork = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Initially show shimmer effect for 2 seconds
    stopShimmerEffect();
  }

  enableNetworkHideLoader() {
    if (isEnableNetwork.value == false) {
      isEnableNetwork.value = true;
    }
    update();
  }

  disableNetworkLoaderByDefault() {
    if (isEnableNetwork.value == true) {
      isEnableNetwork.value = false;
    }
    update();
  }

  // Function to stop shimmer after 3 seconds
  void stopShimmerEffect() {
    Future.delayed(const Duration(seconds: 3), () {
      isShimmering.value = false;
      update();
    });
  }

  void setExpandedIndex(int index) {
    expandedIndex.value = index;
    update();
  }

  void setMenExpandedIndex(int index) {
    menExpandedIndex.value = index;
    update();
  }

// Method to show by default items
  byDefaultOpenTab() {
    selectedTab.value = 1;
  }

  // Method to update the selected tab
  void selectTab(int index) {
    selectedTab.value = index;
    update();
  }

  void setMostBrowsedIndex(int index) {
    browsedIndex.value = index;
    update();
  }

  void setMenBrowsedIndex(int index) {
    menBrowsedExpandedIndex.value = index;
    update();
  }

  void onPageChangedWomenProducts(
      int index, CarouselPageChangedReason changeReason) {
    currentWomenIndex.value = index;
    if (changeReason == CarouselPageChangedReason.manual) {
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logCategoriesWomenSilverJewelleryView,
          productImage: silverJewelleryImage[index],
          index: 1);
    }
  }

  void onPageChangedMenProducts(
      int index, CarouselPageChangedReason changeReason) {
    currentMenIndex.value = index;
    if (changeReason == CarouselPageChangedReason.manual) {
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logCategoriesMenSilverJewelleryView,
          productImage: silverJewelleryImage[index],
          index: 1);
    }
  }

  //Todo : Get Female categories data api method
  Future getFemaleCategories() async {
    try {
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.womenCategoriesApi,
          context: Get.context!,
          isGet: true,
          isLoading: false);
      if (response.statusCode == 200) {
        getCategoryData.clear();
        getCategoryMostBrowsedData.clear();
        getCategoryBannerData.clear();
        log("Get Categories : ${response.data['categories']}");
        //Todo : add all jewellery style categories data
        getCategoryData = (response.data['categories'] as List)
            .map((categoryJson) => Categories.fromJson(categoryJson))
            .toList();
        //Todo : add all mostBrowsed categories data
        getCategoryMostBrowsedData = (response.data['mergedProducts'] as List)
            .map((categoryJson) => MergedProducts.fromJson(categoryJson))
            .toList();

        //Todo : add all jewellery banners categories data
        getCategoryBannerData = (response.data['banners'] as List)
            .map((banners) => Banners.fromJson(banners))
            .toList();
        print("GETDATA: $getCategoryBannerData");
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Get Categories Error : $e");
    } finally {
      update();
    }
  }

  //Todo : Get Male categories data api method
  Future getMaleCategories() async {
    try {
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.menCategoriesApi,
          context: Get.context!,
          isGet: true,
          isLoading: false);
      if (response.statusCode == 200) {
        getCategoryMaleData.clear();
        getCategoryMostBrowsedMaleData.clear();
        getCategoryBannerMaleData.clear();
        //Todo : Male add all jewellery style categories data
        getCategoryMaleData = (response.data['categories'] as List)
            .map((categoryJson) => Categories.fromJson(categoryJson))
            .toList();
        //Todo : Male add all mostBrowsed categories data
        getCategoryMostBrowsedMaleData =
            (response.data['mergedProducts'] as List)
                .map((categoryJson) => MergedProducts.fromJson(categoryJson))
                .toList();

        //Todo : Male add all jewellery banners categories data
        getCategoryBannerMaleData = (response.data['banners'] as List)
            .map((banners) => Banners.fromJson(banners))
            .toList();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Get Categories Error : $e");
    } finally {
      update();
    }
  }

  //Todo : Filter categories & price wise product api method
  Future filterCategoriesApiMethod(
      {String? occasionBy,
      String? priceLimit,
      String? priceOrder,
      String? isFilterScreen,
      String? wrappedBy,
      String? giftFor,
      String? title,
      String? materialBy,
      List<String>? priceLimitList,
      List<String>? productTypeList,
      List<String>? materialList,
      List<String>? shopForList,
      List<String>? occasionByList,
      List<String>? giftsList}) async {
    filterProductData.clear();
    final collectionController =
        Get.put<CollectionController>(CollectionController());
    try {
      collectionController.isShowCategories.value = false;
      //Todo : IsFilterScreen == "YES" fill this time all {} params list format push in api
      // If IsFilterScreen == "YES" parameter particular key value not available value take automatic null
      Map<String, dynamic> params = isFilterScreen == "YES"
          ? {
              "priceLimit": priceLimitList,
              "title": productTypeList,
              "materialBy": materialList,
              "typeBy": shopForList,
              "occasionBy": occasionByList,
              "giftFor": giftsList,
              "userId": PrefManager.getString('userId') ?? '',
            }
          : {
              'occasionBy': occasionBy ?? '',
              'priceLimit': priceLimit ?? '',
              //Todo : Low to high / High to low
              'priceOrder':
                  priceOrder == "lowToHigh" || priceOrder == "highToLow"
                      ? priceOrder
                      : '',
              'userId': PrefManager.getString('userId') ?? '',
              //Todo : Latest / Featured
              'sortBy': priceOrder == "newestFirst" ||
                      priceOrder == LocalStrings.featured
                  ? priceOrder
                  : '',
              'wrappedBy': wrappedBy ?? '',
              'giftFor': giftFor ?? '',
              'title': title ?? '',
              'materialBy': materialBy ?? '',
            };
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.filterProductApi,
        context: Get.context,
        params: params,
        isLoading: false,
      );
      if (response.statusCode == 200) {
        filterProductData = (response.data['updatedProducts'] as List)
            .map((filterProduct) => UpdatedProducts.fromJson(filterProduct))
            .toList();
        update();
      } else {
        showSnackBar(
            context: Get.context!, message: "${response.data['message']}");
      }
    } catch (e) {
      print("Categories Filter : $e");
    } finally {
      collectionController.isShowCategories.value = true;
      update();
    }
  }
}
