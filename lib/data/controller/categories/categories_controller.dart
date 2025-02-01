import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/utils/images.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';

class CategoriesController extends GetxController {
  // late TabController _tabController;
  var expandedIndex = (-1).obs;
  var browsedIndex = (-1).obs;
  var menExpandedIndex = (-1).obs;
  var menBrowsedExpandedIndex = (-1).obs;
  var currentIndex = 0.obs;

  // Observable variable to keep track of the selected tab
  var selectedTab = 0.obs;
  final List<Tab> myTabs = <Tab>[
    const Tab(text: LocalStrings.women),
    const Tab(text: LocalStrings.men),
  ];

  List womenTopCategoriesImage = [
    MyImages.ringsCategories,
    MyImages.earringsCategories,
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
    LocalStrings.earrings,
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
    LocalStrings.giftHim,
  ];
  List mostBrowsedImage = [
    MyImages.moreJewelleryImage,
    MyImages.shopGiftsImage,
  ];
  List mostBrowsedNamed = [LocalStrings.moreJewellery, LocalStrings.shopGifts];
  List mostMenBrowsedNamed = [LocalStrings.shopPrice, LocalStrings.giftHim];
  List silverJewelleryImage = [
    MyImages.jewelleryWeddingFirstImage,
    MyImages.jewelleryWeddingSecondImage,
    MyImages.jewelleryWeddingThirdImage,
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
  ];

  List moreJewelleryImageLst = [
    MyImages.pendantsImage,
    MyImages.chainsImage,
    MyImages.nosePinsImage,
  ];
  List moreJewelleryNameLst = [
    LocalStrings.pendants,
    LocalStrings.chain,
    LocalStrings.nosePins,
  ];
  List menShopPriceNameLst = [
    LocalStrings.aboveMenFirstPrice,
    LocalStrings.aboveMenSecondPrice,
    LocalStrings.aboveMenThirdPrice,
  ];
  List shopGiftsImageLst = [
    MyImages.anniversaryGiftsImage,
    MyImages.birthdayGiftsImage,
    MyImages.bestSellingGiftsImage,
  ];
  List menGiftsImageLst = [
    MyImages.menAnniversaryGiftImage,
    MyImages.menBirthdayGiftImage,
    MyImages.menMilestoneGiftImage,
  ];
  List shopMenGiftsImageLst = [
    MyImages.menPendantsImage,
    MyImages.menRingsImage,
    MyImages.menRingsSecondImage,
  ];
  List shopGiftsNameLst = [
    LocalStrings.anniversaryGifts,
    LocalStrings.birthdayGifts,
    LocalStrings.bestSelling,
  ];
  List menGiftsNameLst = [
    LocalStrings.anniversaryGifts,
    LocalStrings.birthdayGifts,
    LocalStrings.milestoneGifts,
  ];
  List alsoLikeBrowsedNameLst = [
    LocalStrings.charms,
    LocalStrings.noseRings,
    LocalStrings.platinum,
    LocalStrings.watchCharms,
    LocalStrings.kt,
    LocalStrings.allCollection,
  ];
  List menShopByNameLst = [
    LocalStrings.menPlatinum,
    LocalStrings.menGold,
    LocalStrings.menDiamond,
  ];
  List needHelpImageLst = [
    MyImages.postCardImage,
    // MyImages.clTvImage,
    MyImages.planPurchaseImage,
    // MyImages.goldExchangeImage,
    // MyImages.digitalGoldImage,
  ];
  List needHelpHeadingLst = [
    LocalStrings.saltAndPostcards,
    // LocalStrings.clTv,
    LocalStrings.pop,
    // LocalStrings.goldExchange,
    // LocalStrings.gold,
  ];
  List needHelpTitleLst = [
    LocalStrings.embedVideo,
    // LocalStrings.watchBuy,
    LocalStrings.planYour,
    // LocalStrings.yourPrecious,
    // LocalStrings.buySell,
  ];
  List needHelpSubtitleLst = [
    LocalStrings.knowMore,
    // LocalStrings.playNow,
    LocalStrings.learnMore,
    // LocalStrings.knowMore,
    // LocalStrings.learnMore,
  ];

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

  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;
  }
}
