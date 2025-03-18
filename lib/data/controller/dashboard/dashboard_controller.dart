import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:saltandGlitz/data/controller/collection/collection_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/utils/images.dart';
import '../../../local_storage/sqflite_local_storage.dart';
import '../../model/search_product_view_model.dart';

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
  var isDialogVisible = false.obs;
  var searchQuery = ''.obs;
  final ScrollController scrollController = ScrollController();
  List<SearchProductsViewModel> searchProducts = [];

  // TextEditingController for the search field
  final TextEditingController searchTextController = TextEditingController();
  bool isShowBottomSheet = false;
  RxBool isSearchShimmer = false.obs;
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());
  bool isMenuOpen = false;
  RxBool isEnableNetwork = false.obs;

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

  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;
    if (changeReason == CarouselPageChangedReason.manual) {
      /// Analysis if users stay this product and show this products only this time workable this analysis
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logHomeBannerView,
          productImage: imageUrls[index],
          index: 0);
    }
    update();
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

  //Todo : Search Product
  Future searchProductApiMethod({String? query}) async {
    searchProducts.clear();
    try {
      isSearchShimmer.value = true;
      Map<String, dynamic> params = {
        'query': query,
      };

      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.searchProductApi,
          context: Get.context!,
          params: params,
          isLoading: false);
      await Future.delayed(const Duration(seconds: 1));
      if (response.statusCode == 200) {
        searchProducts = (response.data as List)
            .map((searchProducts) =>
                SearchProductsViewModel.fromJson(searchProducts))
            .toList();
        print('Search Product : ${response.data}');
        print('Search Product length : ${searchProducts.length}');
      } else {
        showSnackBar(context: Get.context!, message: 'Something went wrong');
      }
    } catch (e) {
      printActionError('Search Dashboard Error : $e');
    } finally {
      isSearchShimmer.value = false;
      update();
    }
  }

  // Hide dialog when scrolling
  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isDialogVisible.value) {
          isDialogVisible.value = false;
          searchTextController.clear();
          FocusManager.instance.primaryFocus!.unfocus();
        }
      }
    });
    update();
  }
  // Handle search field changes
  void onSearchChanged(String value) {
    searchQuery.value = value;
    if (value.isNotEmpty) {
      isDialogVisible.value = true;
      searchProductApiMethod(query: value);
    } else {
      isDialogVisible.value = false;
    }
    update();
  }

  //Todo : clear search value & keyboard closed and search item view closed method
  hideSearchMethod() {
    final collectionController =
        Get.put<CollectionController>(CollectionController());
    FocusManager.instance.primaryFocus!.unfocus();
    searchTextController.clear();
    isDialogVisible.value = false;
    //Todo : Collection Screen when clicked search icons show search text field
    if (collectionController.isShowSearchField.value == false) {
      collectionController.isShowSearchField.value = true;
    } else if (collectionController.isShowSearchField.value == true) {
      collectionController.isShowSearchField.value = false;
    }
    update();
  }

  //Todo  : Particular Products wishlist add
  Future wishlistAddApiMethod() async {
    try {} catch (e) {
      print("Products wishlist add error : $e");
    }
  }
}
