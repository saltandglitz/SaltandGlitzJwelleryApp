import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import '../../../core/utils/images.dart';
import '../../../local_storage/sqflite_local_storage.dart';

class DashboardController extends GetxController {
  var currentIndex = 0.obs;
  var currentSolitaireIndex = 0.obs;
  var currentGiftsIndex = 0.obs;
  TextEditingController email = TextEditingController();
  final CarouselController carouselController = CarouselController();
  final CarouselController carouselSolitaireController = CarouselController();
  final CarouselController carouselGiftsController = CarouselController();
  late AnimationController animationController;
  List<Map<String, dynamic>> products = [];
  bool isShowBottomSheet = false;
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());
  bool isMenuOpen = false;
  final List<String> giftsForText = [
    LocalStrings.giftsGraduate,
    LocalStrings.giftsHim,
    LocalStrings.giftsHer,
  ];
  final List<String> imageUrls = [
    MyImages.dashboardIntroFirstImage,
    MyImages.dashboardIntroSecondImage,
    MyImages.dashboardIntroThirdImage,
    // MyImages.dashboardIntroForeImage,
    MyImages.dashboardIntroFiveImage,
  ];
  final List<String> imageUrlsSolitaire = [
    MyImages.solitaireFirstImage,
    MyImages.solitaireSecondImage,
    MyImages.solitaireThirdImage,
    MyImages.solitaireForeImage,
  ];

  final List imageSolitaire = [
    MyImages.ringOneImage,
    MyImages.ringSecondImage,
    MyImages.ringThirdImage,
    MyImages.ringForImage,
    MyImages.ringFiveImage,
    MyImages.ringOneImage,
    MyImages.ringThirdImage,
    MyImages.ringSecondImage,
  ];
  final List imageSolitaireText = [
    LocalStrings.goldenRing,
    LocalStrings.diamondRingFirst,
    LocalStrings.diamondRingSecond,
    LocalStrings.stoneRing,
    LocalStrings.stoneDiamondRing,
    LocalStrings.goldenRing,
    LocalStrings.diamondRingSecond,
    LocalStrings.diamondRingFirst,
  ];
  final List solitairePriceText = [
    LocalStrings.priceProductItemFirst,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFive,
    LocalStrings.priceProductItemSeven,
    LocalStrings.priceProductItemNine,
    LocalStrings.priceProductItemEleven,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFirst,
  ];
  final List newArrivalPriceText = [
    LocalStrings.priceProductItemFirst,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFive,
    LocalStrings.priceProductItemSeven,
    LocalStrings.priceProductItemNine,
    LocalStrings.priceProductItemEleven,
    LocalStrings.priceProductItemThird,
    LocalStrings.priceProductItemFirst,
  ];

  final List<String> imageShopCategoryImage = [
    MyImages.rings,
    MyImages.pendants,
    MyImages.goldChains,
    MyImages.earrings,
    MyImages.nosePins,
    MyImages.watches,
  ];
  final List<String> imageShopCategoryText = [
    LocalStrings.rings,
    LocalStrings.pendants,
    LocalStrings.goldChains,
    LocalStrings.earrings,
    LocalStrings.nosePins,
    LocalStrings.watches,
  ];
  final List<String> imageGiftCategoryImage = [
    MyImages.giftsFirstImage,
    MyImages.giftsSecondImage,
    MyImages.giftsThirdImage,
  ];
  final List<String> imageGiftCategoryText = [
    LocalStrings.giftsGraduate,
    LocalStrings.giftsHim,
    LocalStrings.giftsHer,
  ];
  final List iconList = [
    Icons.local_shipping,
    Icons.square,
    Icons.square,
    Icons.gif_box_outlined,
  ];
  final List<String> servicesTitleText = [
    LocalStrings.shippingReturns,
    LocalStrings.yourService,
    LocalStrings.bookAppointment,
    LocalStrings.blueBox,
  ];
  final List<String> servicesSubTitleText = [
    LocalStrings.complementaryShipping,
    LocalStrings.ourClient,
    LocalStrings.inStoreVirtual,
    LocalStrings.purchaseComes,
  ];
  final List<String> servicesText = [
    LocalStrings.learnMore,
    LocalStrings.contactUs,
    LocalStrings.bookNow,
    LocalStrings.exploreAll,
  ];
  final List<String> clientCareList = [
    LocalStrings.contact,
    LocalStrings.trackOrder,
    LocalStrings.bookAnAppointment,
    LocalStrings.askedQuestions,
    LocalStrings.shippingsReturns,
    LocalStrings.productsCare,
    LocalStrings.giftCards,
    LocalStrings.accessibility,
  ];

  final List<String> ourCompanyList = [
    LocalStrings.saltAndGlitz,
    LocalStrings.sustainability,
    LocalStrings.supplyChains,
    LocalStrings.californiaPrivacy,
    LocalStrings.careers,
    LocalStrings.policies,
    LocalStrings.transparency,
    LocalStrings.sharePersonal,
    LocalStrings.targetedAdvertising,
  ];

  final List<String> relatedSaltAndGlitzSitesList = [
    LocalStrings.weddingsGift,
    LocalStrings.businessAccounts,
    LocalStrings.saltAndGlitzPress,
    LocalStrings.foundation,
    LocalStrings.alertline,
    LocalStrings.siteIndex,
  ];

  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;
  }

  void onPageChangedSolitaire(
      int index, CarouselPageChangedReason changeReason) {
    currentSolitaireIndex.value = index;
    update();
  }

  void onPageChangedGifts(int index, CarouselPageChangedReason changeReason) {
    currentGiftsIndex.value = index;
    update();
  }

  void goToPreviousSolitaire() {
    if (currentSolitaireIndex.value > 0) {
      carouselSolitaireController.previousPage();
    }
    update();
  }

  void goToNextSolitaire() {
    if (currentSolitaireIndex.value < 4) {
      carouselSolitaireController.nextPage();
    }
    update();
  }

  void goToPreviousGifts() {
    if (currentGiftsIndex.value > 0) {
      carouselGiftsController.previousPage();
    }
    update();
  }

  void goToNextGifts() {
    if (currentGiftsIndex.value < 3) {
      carouselGiftsController.nextPage();
    }
    update();
  }

  // Handle menu icon if direct any tab to clicked dashboard
  byDefaultMenu() {
    isMenuOpen = false;
    update();
  }

  categoriesDefaultCloseIcon() {
    isMenuOpen = true;
    update();
  }

  //Change menu icon animation using
  animatedMenuIconChange() {
    if (isMenuOpen) {
      animationController.reverse();
      Future.delayed(const Duration(milliseconds: 400), () {
        bottomBarController.changeIndex(0);
      });
    } else {
      animationController.forward();
      Future.delayed(const Duration(milliseconds: 400), () {
        bottomBarController.changeIndex(1);
      });
    }
    isMenuOpen = !isMenuOpen;
    update();
  }

  bottomSheetShowMethod() {
    if (isShowBottomSheet == false) {
      isShowBottomSheet = true;
    }
    update();
  }

  // Fetch data sqflite database to users recent view
  Future<void> fetchProducts() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      // Ensure the database is initialized
      await dbHelper.database;
      final productsData = await dbHelper.queryAllRows();
      products = productsData;
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      update();
    }
  }
}
