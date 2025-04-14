import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/data/controller/wishlist/wishlist_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import 'package:video_player/video_player.dart';

import '../../analytics/app_analytics.dart';
import '../../core/route/route.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/images.dart';
import '../../core/utils/local_strings.dart';
import '../../local_storage/pref_manager.dart';
import '../controller/add_to_cart/add_to_cart_controller.dart';
import '../controller/collection/collection_controller.dart';
import '../model/categories_filter_view_model.dart';

class ProductController extends GetxController {
  var currentIndex = 0.obs;
  var colorCurrentIndex = (2).obs;
  var ktCurrentIndex = (0).obs;
  bool isFavorites = false;
  RxBool isAddToCart = false.obs;
  RxBool isBuyNowCart = false.obs;
  RxInt byDefaultRingSize = 6.obs;
  final CarouselController carouselController =
      CarouselController(); // Add CarouselController
  VideoPlayerController? videoController;

  //Todo : var productData var set because multi pal screen open this screen so set common to fetch all data and show product
  var productData;
  TextEditingController search = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String productImage = '';
  List<int> ringSize = [
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];
  List<String> imageUrls = [];
  List<Color> colorLst = [
    ColorResources.offerNineColor,
    ColorResources.borderColor.withOpacity(0.2),
    ColorResources.updateCardColor,
  ];
  List ctLst = [
    LocalStrings.ktFirst,
    LocalStrings.ktSecond,
  ];
  List goldTypeMessageLst = [
    LocalStrings.roseGold,
    LocalStrings.whiteGold,
    LocalStrings.yellowGold,
  ];
  List ktTypeMessageLst = [
    LocalStrings.ktFirst,
    LocalStrings.ktSecond,
  ];
  List diamondWeightTableLst = [
    LocalStrings.sizeText,
    LocalStrings.colorText,
    LocalStrings.clarity,
    LocalStrings.shape,
    LocalStrings.noDiamonds,
    LocalStrings.total,
  ];
  List diamondWeightTableValueLst = [
    LocalStrings.sizeGold,
    LocalStrings.gh,
    LocalStrings.vs,
    LocalStrings.round,
    LocalStrings.diamondSize,
    LocalStrings.wrightSize,
  ];
  List breakupItemLst = [
    LocalStrings.goldText,
    LocalStrings.diamond,
    LocalStrings.makingCharg,
    LocalStrings.gst,
    LocalStrings.totalText,
  ];
  List promiseImageLst = [
    MyImages.buyBackImage,
    MyImages.exchangeImage,
    MyImages.returnImage,
    MyImages.freeShipingImage,
    MyImages.hallmarkImage,
    MyImages.certifiedImage,
  ];
  List promiseNameLst = [
    LocalStrings.buyBack,
    LocalStrings.exchange,
    LocalStrings.returns,
    LocalStrings.shippingInsuranceFree,
    LocalStrings.hallmarked,
    LocalStrings.certified,
  ];
  RxBool isEnableNetwork = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   /// Previous screen to get image data
  //   productImage=MyImages.menAnniversaryGiftImage;
  //   /// Stored get image
  //   imageUrls=[
  //     productImage,
  //     productImage,
  //     productImage,
  //     productImage
  //   ];
  // }
  ringSizeOnChangValue(value) {
    byDefaultRingSize.value = value!.toInt();
    print("Ring Size:${byDefaultRingSize.value}");
    update();
  }

  // Method to handle video playback
  void handleMediaPlayback(int index) async {
    final media = productData?.media?[index].productAsset?.trim();

    // Dispose previous controller if exists
    if (videoController != null) {
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }

    if (media != null && productData?.media?[index].type == 'goldVideo') {
      videoController = VideoPlayerController.networkUrl(Uri.parse(media));

      try {
        await videoController!.initialize();
        videoController!.setLooping(true);
        await videoController!.play(); // Auto play on slide change
        update();
      } catch (error) {
        print("Error initializing video: $error");
      }
    } else {
      update(); // Just update for image or non-video
    }
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

  void onPageChanged(int index, CarouselPageChangedReason changeReason) {
    currentIndex.value = index;

    /// Particular Product angle view analysis log
    if (changeReason == CarouselPageChangedReason.manual) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductAngleView,
          productImage: productData?.media?[index].productAsset,
          productName: productData?.title,
          index: 6);
    }
  }

  void goToPage(int index) {
    carouselController.animateToPage(index); // Add method to change page
  }

  void isFavoritesMethod() {
    isFavorites = !isFavorites;
    if (isFavorites == false) {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductUnFavoriteClick,
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    } else {
      /// Product name now static but when integration dynamic data set product name dynamic
      AppAnalytics().actionTriggerWithProductsLogs(
          eventName: LocalStrings.logProductFavoriteClick,
          productName: LocalStrings.goldenRing,
          productImage: imageUrls[0],
          index: 6);
    }
    update();
  }

  void colorSelectionJewellery(int index) {
    colorCurrentIndex.value = index;
    if (colorCurrentIndex.value == 1) {
      /// Product name now static but when integration dynamic data set product name dynamic
      // AppAnalytics().actionTriggerWithProductsLogs(
      //     eventName:
      //         "${LocalStrings.logProductSliver}_${LocalStrings.logProductProductTypeSelection}",
      //     productName: LocalStrings.goldenRing,
      //     productImage: imageUrls[0],
      //     index: 6);
    } else if (colorCurrentIndex.value == 2) {
      /// Product name now static but when integration dynamic data set product name dynamic
      // AppAnalytics().actionTriggerWithProductsLogs(
      //     eventName:
      //         "${LocalStrings.logProductGold}_${LocalStrings.logProductProductTypeSelection}",
      //     productName: LocalStrings.goldenRing,
      //     productImage: imageUrls[0],
      //     index: 6);
    }
    update();
  }

//Todo : Jewellery color selection method
  String jewelleryColor() {
    if (colorCurrentIndex.value == 0) {
      return "Rose Gold";
    } else if (colorCurrentIndex.value == 1) {
      return "Silver Gold";
    } else {
      return "Yellow Gold";
    }
  }

  //Todo L Jewellery karat selection method
  String jewelleryKt() {
    if (ktCurrentIndex.value == 0) {
      return "14KT";
    } else {
      return "18KT";
    }
  }

  void ktSelectionJewellery(int index) {
    ktCurrentIndex.value = index;

    /// Product name now static but when integration dynamic data set product name dynamic
    AppAnalytics().actionTriggerWithProductsLogs(
        eventName:
            "${ctLst[index] == '18Kt' ? 'Eighteen_Kt' : 'Fourteen_Kt'}_${LocalStrings.logProductProductTypeSelection}",
        productName: productData?.title,
        productImage: productData?.media?[index].productAsset,
        index: 6);
    update();
  }

  var originalPrice = 75386.obs;
  var discountedPrice = 57386.obs;
  var discountCode = 'JB10';

  void applyDiscount() {
    originalPrice.value = discountedPrice.value;
  }

  //Todo: Add to cart api method
  Future addToCartApiMethod(
      {String? userId,
      String? productId,
      int? quantity,
      int? size,
      String? carat,
      String? color,
      String? type,
      int? indexWishlist,
      String? cartType}) async {
    try {
      final collectionController =
          Get.put<CollectionController>(CollectionController());
      final wishlistController =
          Get.put<WishlistController>(WishlistController());
      if (cartType == LocalStrings.buyNow) {
        isBuyNowCart.value = true;
      } else {
        isAddToCart.value = true;
      }
      String currentUserId = PrefManager.getString('userId') ?? '';

      Map<String, dynamic> params =
          currentUserId == null || currentUserId.trim().isEmpty
              ? {
                  "product": productId ?? "",
                  "quantity": quantity ?? 1,
                  "size": size ?? 6,
                  "caratBy": carat ?? jewelleryKt(),
                  "colorBy": color ?? jewelleryColor()
                }
              : {
                  "user": currentUserId ?? "",
                  "product": productId ?? "",
                  "quantity": quantity ?? 1,
                  "size": size ?? 6,
                  "caratBy": carat ?? jewelleryKt(),
                  "colorBy": color ?? jewelleryColor()
                };
      print("Get UserId : $currentUserId");
      print("Add to cart params : $params");
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.addToCartApi,
          context: Get.context,
          params: params,
          isLoading: false);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (currentUserId == null || currentUserId.trim().isEmpty) {
          PrefManager.setString(
              'userId', "${response.data['newCart']['userId']}" ?? '');
        }
        if (type == LocalStrings.moveCart) {
          //Todo : Remove to the wishlist
          collectionController.removeWishlistApiMethod(productId: productId);
          Get.back();

          //Todo : Locally cart item remove
          wishlistController.removeLocallyWishlist(indexWishlist!);
          Get.put<AddToCartController>(AddToCartController());
          Get.toNamed(RouteHelper.addCartScreen);
        }
        PrefManager.addCartProductToList('cartProductId', '$productId',
            "${size ?? 6}", carat ?? jewelleryKt(), color ?? jewelleryColor());
        List<String>? cartData = PrefManager.getStringList('cartProductId');
        print("Stored Data cart : ${cartData?.toList()}");
        print("Get user id : ${PrefManager.getString('userId')}");
        showToast(
            message: '${response.data['message']}', context: Get.context!);
      } else {
        showSnackBar(
            context: Get.context!, message: '${response.data['message']}');
      }
    } catch (e) {
      print("Add to cart time issue : $e");
    } finally {
      isAddToCart.value = false;
      if (cartType == LocalStrings.buyNow) {
        isBuyNowCart.value = false;
      } else {
        isBuyNowCart.value = false;
      }
      update();
    }
  }

  @override
  void dispose() {
    videoController?.dispose(); // Dispose if it's not null
    super.dispose();
  }
}
