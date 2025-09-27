import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/data/controller/wishlist/wishlist_controller.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';
import 'package:video_player/video_player.dart';

import '../../analytics/app_analytics.dart';
import '../../core/route/route.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/images.dart';
import '../../core/utils/local_strings.dart';
import '../../core/utils/style.dart';
import '../../core/utils/validation.dart';
import '../../local_storage/pref_manager.dart';
import '../controller/add_to_cart/add_to_cart_controller.dart';
import '../controller/collection/collection_controller.dart';
import '../model/get_rating_view_model.dart';

class ProductController extends GetxController {
  var currentIndex = 0.obs;
  var colorCurrentIndex = (2).obs;
  RxInt ktCurrentIndex = 0.obs; // 0 for 14KT, 1 for 18KT
  bool isFavorites = false;
  RxBool isAddToCart = false.obs;
  RxBool isBuyNowCart = false.obs;
  RxInt byDefaultRingSize = 6.obs;
  TextEditingController feedBack = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  RxDouble ratingValue = 0.0.obs;
  var pickedImage = Rx<File?>(null);
  final slider.CarouselSliderController carouselController =
      slider.CarouselSliderController(); // Add CarouselController
  VideoPlayerController? videoController;
  GetRatingViewModel? getRatingViewModel;
  String? userRatingValue;

  //Todo : var productData var set because multi pal screen open this screen so set common to fetch all data and show product
  var productData;
  int? collectionIndex;
  File? imageFile;
  RxBool isRating = false.obs;
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
  ];
  List<String> imageUrls = [];
  List<String> ratingList = [
    LocalStrings.fiveRating,
    LocalStrings.foreRating,
    LocalStrings.thirdRating,
    LocalStrings.secondRating,
    LocalStrings.firstRating,
  ];
  List<Color> colorLst = [
    ColorResources.roseGoldColour,
    ColorResources.silverColour,
    ColorResources.goldColour,
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
    LocalStrings.unitWeight,
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
    MyImages.clAdvantageSpritePurityCheckImage,
    MyImages.clAdvantageSpriteRupeesImage,
    MyImages.clAdvantageSpriteImage,
    MyImages.clAdvantageSpriteDateImage,
  ];
  List promisePurityImageLst = [
    MyImages.certifiedLogoImage,
    MyImages.vvsGradeDiamondImage,
    MyImages.pdpDeliveryTahSpriteImage,
  ];
  List promiseNameLst = [
    LocalStrings.certifiedPercent,
    LocalStrings.returns,
    LocalStrings.exchange,
    LocalStrings.warranty,
  ];
  List promisePurityNameLst = [
    LocalStrings.certifiedRecognised,
    LocalStrings.blankText,
    LocalStrings.certifiedSalt,
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

  // Helper method to dynamically get diamond price from productData
  dynamic getDiamondPrice(dynamic product) {
    if (product == null) return null;

    // Try camelCase first
    try {
      if (product.diamondPrice != null) {
        return product.diamondPrice;
      }
    } catch (e) {
      // Continue to next attempt
    }

    // Try lowercase
    try {
      if (product.diamondprice != null) {
        return product.diamondprice;
      }
    } catch (e) {
      // Continue to next attempt
    }

    // Try dynamic access as Map
    try {
      if (product is Map) {
        return product['diamondPrice'] ?? product['diamondprice'];
      }
    } catch (e) {
      // Continue to next attempt
    }

    return null;
  }

  // Helper method to dynamically access any field with both camelCase and lowercase variants
  dynamic getDynamicField(
      dynamic product, String camelCaseField, String lowerCaseField) {
    if (product == null) return null;

    // Try camelCase first
    try {
      final camelValue = _getFieldValue(product, camelCaseField);
      if (camelValue != null) {
        return camelValue;
      }
    } catch (e) {
      // Continue to next attempt
    }

    // Try lowercase
    try {
      final lowerValue = _getFieldValue(product, lowerCaseField);
      if (lowerValue != null) {
        return lowerValue;
      }
    } catch (e) {
      // Continue to next attempt
    }

    // Try dynamic access as Map
    try {
      if (product is Map) {
        return product[camelCaseField] ?? product[lowerCaseField];
      }
    } catch (e) {
      // Continue to next attempt
    }

    return null;
  }

  // Private helper to get field value using reflection-like access
  dynamic _getFieldValue(dynamic object, String fieldName) {
    try {
      switch (fieldName) {
        case 'diamondPrice':
          return object.diamondPrice;
        case 'diamondprice':
          return object.diamondprice;
        case 'makingCharge14KT':
          return object.makingCharge14KT;
        case 'makingcharge14kt':
          return object.makingcharge14kt;
        case 'makingCharge18KT':
          return object.makingCharge18KT;
        case 'makingcharge18kt':
          return object.makingcharge18kt;
        case 'diamondQt':
          return object.diamondQt;
        case 'diamondqt':
          return object.diamondqt;
        case 'diamondWt':
          return object.diamondWt;
        case 'diamondwt':
          return object.diamondwt;
        case 'netWeight14KT':
          return object.netWeight14KT;
        case 'netweight14kt':
          return object.netweight14kt;
        case 'netWeight18KT':
          return object.netWeight18KT;
        case 'netweight18kt':
          return object.netweight18kt;
        case 'grossWt':
          return object.grossWt;
        case 'grosswt':
          return object.grosswt;
        case 'gst14KT':
          return object.gst14KT;
        case 'gst14kt':
          return object.gst14kt;
        case 'gst18KT':
          return object.gst18KT;
        case 'gst18kt':
          return object.gst18kt;
        case 'total14KT':
          return object.total14KT;
        case 'total14kt':
          return object.total14kt;
        case 'total18KT':
          return object.total18KT;
        case 'total18kt':
          return object.total18kt;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Specific helper methods for commonly used fields
  dynamic getDiamondQt(dynamic product) {
    return getDynamicField(product, 'diamondQt', 'diamondqt');
  }

  dynamic getDiamondWt(dynamic product) {
    return getDynamicField(product, 'diamondWt', 'diamondwt');
  }

  dynamic getNetWeight14KT(dynamic product) {
    return getDynamicField(product, 'netWeight14KT', 'netweight14kt');
  }

  dynamic getNetWeight18KT(dynamic product) {
    return getDynamicField(product, 'netWeight18KT', 'netweight18kt');
  }

  dynamic getGrossWt(dynamic product) {
    return getDynamicField(product, 'grossWt', 'grosswt');
  }

  dynamic getGst14KT(dynamic product) {
    return getDynamicField(product, 'gst14KT', 'gst14kt');
  }

  dynamic getGst18KT(dynamic product) {
    return getDynamicField(product, 'gst18KT', 'gst18kt');
  }

  dynamic getTotal14KT(dynamic product) {
    return getDynamicField(product, 'total14KT', 'total14kt');
  }

  dynamic getTotal18KT(dynamic product) {
    return getDynamicField(product, 'total18KT', 'total18kt');
  }

  dynamic getMakingCharge14KT(dynamic product) {
    return getDynamicField(product, 'makingCharge14KT', 'makingcharge14kt');
  }

  dynamic getMakingCharge18KT(dynamic product) {
    return getDynamicField(product, 'makingCharge18KT', 'makingcharge18kt');
  }

  double calculateAdjustedPrice() {
    final size = byDefaultRingSize.value;
    final is18KT = ktCurrentIndex.value == 1;
    final product = productData;

    if (product == null) return 0;

    // Base price from API
    double basePrice =
        is18KT ? (getTotal18KT(product) ?? 0) : (getTotal14KT(product) ?? 0);

    // Return base price for sizes 6–10
    if (size <= 10) {
      return basePrice;
    }

    // Apply custom price logic for sizes > 10
    int steps = size - 10; // number of increments after size 10
    int a = 127; // first increment
    int d = 3; // common difference

    // Use arithmetic progression sum formula
    int increment = (steps * (2 * a + (steps - 1) * d)) ~/ 2;

    return basePrice + increment;
  }

  void resetRingSize() {
    byDefaultRingSize.value = 6;
  }

  void ringSizeOnChangValue(int? value) {
    if (value != null) {
      byDefaultRingSize.value = value;
    }
  }

  void resetKaratSelection() {
    ktCurrentIndex.value = 0; // 0 = 14KT, 1 = 18KT
  }

  // ringSizeOnChangValue(value) {
  //   byDefaultRingSize.value = value!.toInt();
  //   print("Ring Size:${byDefaultRingSize.value}");
  //   update();
  // }

  void resetRatingData() {
    getRatingViewModel = null;
    update();
  }

  /// Rating users
  ratingUsers(double newRating) {
    ratingValue.value = newRating;
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
        videoController?.setVolume(0.0);
        update();
      } catch (error) {
        print("Error initializing video: $error");
      }
    } else {
      update(); // Just update for image or non-video
    }
  }

  /// Image picker through gallery image pick
  Future<void> imagePickGalleryMethod() async {
    final pick = ImagePicker();
    final pickFile = await pick.pickImage(source: ImageSource.gallery);
// Check if no file was picked
    if (pickFile == null) {
      showSnackBar(
        context: Get.context!,
        title: 'No Image Selected', // Customize the title as needed
        message: LocalStrings.noSelectedImage,
        icon: Icons
            .image_not_supported, // You can use an icon that represents no image
        iconColor: Colors.orange, // Orange color for the icon
      );

      return;
    }

    imageFile = File(pickFile.path);
    if (_isValidImage(imageFile!)) {
      pickedImage.value = imageFile;
      update();
    } else {
      showSnackBar(
        context: Get.context!,
        title: 'Invalid File', // Customize the title as needed
        message: LocalStrings.invalidFile,
        icon: Icons.error, // You can use an error icon to indicate a problem
        iconColor: Colors.red, // Red color for the icon, indicating an error
      );

      update();
    }
    update();
  }

  /// Image picker through camera image pick
  Future<void> imagePickCameraMethod() async {
    final pick = ImagePicker();
    final pickFile = await pick.pickImage(source: ImageSource.camera);
    // Check if no file was picked
    if (pickFile == null) {
      showSnackBar(
        context: Get.context!,
        title: 'No Image Selected', // Customize the title as needed
        message: LocalStrings.noSelectedImage,
        icon: Icons.image, // You can use an image icon or any other icon
        iconColor:
            Colors.orange, // Orange color for the icon (to indicate a warning)
      );

      return;
    }
    imageFile = File(pickFile.path);
    print("Pick file : $imageFile");
    // Validate image
    if (_isValidImage(imageFile!)) {
      pickedImage.value = imageFile;
      print("Pick file 111: ${pickedImage.value}");
      update();
    } else {
      showSnackBar(
        context: Get.context!,
        title: 'Invalid File', // Customize the title as needed
        message: LocalStrings.invalidFile,
        icon: Icons
            .error, // You can use an error icon to indicate the invalid file
        iconColor: Colors.red, // Red color for the icon to indicate an error
      );

      update();
    }
    update();
  }

  /// Clear Image
  clearImage() {
    pickedImage.value = null;
    update();
  }

  /// Clear start rating
  clearRating() {
    ratingValue.value = 0.0;
    update();
  }

  /// Image pick ask options dialog gallery & camera.
  imagePickOptionsDialogBox() {
    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 25),
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: Material(
                color: ColorResources.whiteColor,
                borderRadius: BorderRadius.circular(8),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocalStrings.selectImage,
                          style: semiBoldExtraLarge.copyWith(),
                        ),
                        const SizedBox(height: Dimensions.space40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(width: Dimensions.space30),
                            GestureDetector(
                              onTap: () {
                                /// Camera pick image method
                                imagePickCameraMethod();
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Get.back();
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.camera,
                                      size: 30,
                                      color: ColorResources.buttonColor),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    LocalStrings.camera,
                                    style: mediumLarge.copyWith(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.space35),
                            GestureDetector(
                              onTap: () {
                                /// Gallery pick image method
                                imagePickGalleryMethod();
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Get.back();
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  const Icon(Icons.photo,
                                      size: 35,
                                      color: ColorResources.buttonColor),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    LocalStrings.gallery,
                                    style: mediumLarge.copyWith(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.space30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  enableNetworkHideLoader() {
    if (isEnableNetwork.value == false) {
      isEnableNetwork.value = true;
    }
    update();
  }

  bool _isValidImage(File file) {
    final allowExtensions = ['gif', 'jpg', 'jpeg', 'png'];
    final fileExtension = file.path.split('.').last.toLowerCase();
    final fileSize = file.lengthSync();
    bool isValidSize = fileSize <= 5 * 1024 * 1024;
    return allowExtensions.contains(fileExtension) && isValidSize;
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
    carouselController.animateToPage(index,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear); // Add method to change page
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

  /// Add rating users
  Future<void> addRatingUsers(
      {String? userId,
      String? productId,
      String? userRating,
      String? userReview}) async {
    try {
      isRating.value = true;
      FormData formData;
      Map<String, dynamic> params = {
        "userId": userId ?? '',
        "productId": productId ?? "",
        "userRating": userRating ?? "",
        "userReview": userReview ?? "",
      };
      formData = FormData.fromMap({
        ...params,
        "productImage": imageFile?.path != null
            ? await MultipartFile.fromFile(imageFile?.path ?? '',
                filename: imageFile!.path.split('.').last)
            : "",
      });

      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.addRatingApi,
          context: Get.context!,
          params: formData,
          isLoading: false);

      if (response.statusCode == 200) {
        getRatingApiMethod(productId: productId);
        showToast(message: LocalStrings.adminApproval, context: Get.context!);
      } else {
        print("Something went wrong rating time");
      }
    } catch (e) {
      print("Add rating : $e");
    } finally {
      isRating.value = false;
      Get.back();
    }
  }

  /// Update rating users
  /// Update rating users
  Future<void> updateRatingUsers({
    String? userId,
    String? productId,
    String? userRating,
    String? userReview,
  }) async {
    try {
      isRating.value = true;
      FormData formData;
      Map<String, dynamic> params = {
        "userId": userId ?? '',
        "productId": productId ?? "",
        "userRating": userRating ?? "",
        "userReview": userReview ?? "",
      };
      formData = FormData.fromMap({
        ...params,
        "productImage": imageFile?.path != null
            ? await MultipartFile.fromFile(imageFile?.path ?? '',
                filename: imageFile!.path.split('.').last)
            : "",
      });
      // Use PUT method to update the rating
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.updateRatingApi, // Endpoint for updating rating
        context: Get.context!,
        params: formData, // Data to update rating
        isLoading: false,
        isPut: true, // Indicating it's a PUT request
      );

      if (response.statusCode == 200) {
        getRatingApiMethod(productId: productId);
        showToast(message: LocalStrings.ratingUpdated, context: Get.context!);
      } else {
        print("Something went wrong rating time");
      }
    } catch (e) {
      print("Update rating time error : $e");
    } finally {
      isRating.value = false;
      Get.back();
    }
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

      Map<String, dynamic> params = currentUserId.trim().isEmpty
          ? {
              "product": productId ?? "",
              "quantity": quantity ?? 1,
              "size": size ?? 6,
              "caratBy": carat ?? jewelleryKt(),
              "colorBy": color ?? jewelleryColor()
            }
          : {
              "user": currentUserId,
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
        if (currentUserId.trim().isEmpty) {
          PrefManager.setString(
              'userId', "${response.data['newCart']['userId']}");
        }
        if (type == LocalStrings.moveCart) {
          //Todo : Remove to the wishlist
          collectionController.removeWishlistApiMethod(productId: productId);
          Get.back();

          //Todo : Locally cart item remove
          wishlistController.removeLocallyWishlist(indexWishlist!);
          Get.put<AddToCartController>(AddToCartController());
          wishlistController.updateProductStatus(productId!, false);
          Get.toNamed(RouteHelper.addCartScreen);
        }
        PrefManager.addCartAndWishlistProductToList(
            'cartProductId',
            '$productId',
            "${size ?? 6}",
            carat ?? jewelleryKt(),
            color ?? jewelleryColor());
        List<String>? cartData = PrefManager.getStringList('cartProductId');
        print("Stored Data cart : ${cartData?.toList()}");
        print("Get user id : ${PrefManager.getString('userId')}");
        showToast(
            message: '${response.data['message']}', context: Get.context!);
      } else {
        showSnackBar(
          context: Get.context!,
          title: 'Error', // You can customize the title here
          message: '${response.data['message']}',
          icon: Icons.error, // Choose an appropriate icon for the error
          iconColor: Colors.red, // Red color for error indication
        );
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

  /// Validate rating dialog
  isValidateRating(
      {String? userId,
      String? productId,
      String? userRating,
      String? userReview}) {
    print("Enter rating 11");
    if (ratingValue.value == 0.0 && userId!.isNotEmpty) {
      print("Enter rating 22");
      showSnackBar(
        context: Get.context!,
        title: 'Rating', // Customize the title as needed
        message: LocalStrings.selectRating,
        icon: Icons.star, // You can choose an icon that represents rating
        iconColor: Colors.yellow, // Yellow color for the star icon
      );
    } else if (CommonValidation().isValidationEmpty(userReview) &&
        userId!.isNotEmpty) {
      print("Enter rating 33");
      showSnackBar(
        context: Get.context!,
        title: 'Feedback', // Customize the title as needed
        message: LocalStrings.enterFeedback,
        icon: Icons.feedback, // You can use a feedback icon
        iconColor: Colors.blue, // Blue color for the feedback icon
      );
    } else if (isRating.value == false &&
        userReview!.isNotEmpty &&
        ratingValue.value != 0.0 &&
        userId!.isNotEmpty) {
      if (userRatingValue?.isEmpty ?? true) {
        /// Add new rating
        addRatingUsers(
          userId: userId,
          productId: productId,
          userRating: userRating,
          userReview: userReview,
        );
      } else {
        /// Update already have rating
        updateRatingUsers(
          userId: userId,
          productId: productId,
          userRating: userRating,
          userReview: userReview,
        );
      }
    } else {
      print("Enter rating 55");
      showSnackBar(
        context: Get.context!,
        title: 'Rating', // Customize the title as needed
        message: LocalStrings.ratingLogin,
        icon: Icons.star, // You can use a star icon for rating
        iconColor: Colors.yellow, // Yellow color for the star icon
      );
    }
    print("Enter rating 66");
  }

  /// Using this method get all rating particular product rating
  Future<void> getRatingApiMethod({String? productId}) async {
    try {
      print("Get ratting 12: ");
      Response response = await APIFunction().apiCall(
          apiName: "${LocalStrings.getRatingApi}$productId",
          context: Get.context!,
          isGet: true,
          isLoading: false);
      if (response.statusCode == 200) {
        String? userId = PrefManager.getString('userId');
        getRatingViewModel = GetRatingViewModel.fromJson(response.data);
        for (var rating in (getRatingViewModel!.approvedRating!)) {
          String? ratingUserId = rating.userId?.id;
          if (ratingUserId == userId) {
            userRatingValue = rating.userRating;
            ratingValue.value = double.parse(userRatingValue!);
            print("Get ratting 11: $userRatingValue");
            break;
          }
        }

        print("Get ratting : ${response.data}");
      } else {
        print("Get ratting not fetch");
      }
    } catch (e) {
      print("Get ratting time error : $e");
    } finally {
      update();
    }
  }

  // Future<void> youMayAlsoLike() async {
  //   try {
  //     Response response = await APIFunction().apiCall(
  //       apiName: LocalStrings.youMayAlsoLikeApi,
  //       context: Get.context!,
  //       isGet: true,
  //       isLoading: false,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final bannerData = response.data['banner'];
  //
  //       if (bannerData is List) {
  //         youMayAlsoLikeData = bannerData
  //             .map((item) => YouMayAlsoLikeModel.fromJson(item))
  //             .toList();
  //         print(
  //             "Fetched You May Also Like Items: ${youMayAlsoLikeData.length}");
  //       } else {
  //         print("Unexpected format: 'banner' is not a List.");
  //       }
  //     } else {
  //       print("API Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Get You May Also Like Error: $e");
  //   } finally {
  //     update();
  //   }
  // }

  @override
  void dispose() {
    videoController?.dispose(); // Dispose if it's not null
    super.dispose();
  }
}
