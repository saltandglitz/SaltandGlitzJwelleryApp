import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:saltandGlitz/data/model/get_add_cart_view_model.dart';
import 'package:saltandGlitz/local_storage/pref_manager.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/utils/app_const.dart';

class AddToCartController extends GetxController {
  int currentIndex = 0;
  Timer? timer;
  RxBool isEnableNetwork = false.obs;
  RxBool isGetCartData = false.obs;
  RxBool isRemoveCart = false.obs;

  // List<RxInt>? isQuantity;
  GetAddCartViewModel? getAddCartData;
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());
  static const List<Map<String, String>> texts = [
    {"title": LocalStrings.pointsOrder, "subtitle": LocalStrings.nextOrder},
    {"title": LocalStrings.oderOnline, "subtitle": LocalStrings.sameDay},
  ];

  List productsImage = [
    MyImages.ringsProductsImage,
    MyImages.earringsProductsImage,
    MyImages.chainProductsImage
  ];

  // =List.generate(productsImage.length, (_) => 1.obs);
  List productsName = [
    LocalStrings.rings,
    LocalStrings.earrings,
    LocalStrings.chain
  ];
  List productQuantity = [
    LocalStrings.quantityFirst,
    LocalStrings.quantitySecond,
    LocalStrings.quantityFirst,
  ];
  List productsSize = [
    LocalStrings.sizeFirst,
    LocalStrings.sizeSecond,
    LocalStrings.sizeThird,
  ];

  // animation text show offers
  implementAnimationOffersMethod() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      currentIndex = (currentIndex + 1) % texts.length;
      update();
    });
  }

  /// Remove products
  removeProduct(int index) {
    // productsImage.removeAt(index);
    getAddCartData?.cart?.quantity?.removeAt(index);
    update();
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

  //Todo : Get cart using api method
  Future getCartDataApiMethod() async {
    try {
      isGetCartData.value = true;
      print("get_cart_data_user id :${PrefManager.getString('userId')}");
      Response response = await APIFunction().apiCall(
        apiName: "${LocalStrings.getCartApi}${PrefManager.getString('userId')}",
        context: Get.context,
        isLoading: false,
        isGet: true,
      );
      if (response.statusCode == 200) {
        getAddCartData = GetAddCartViewModel.fromJson(response.data);
        print("get_cart_data : $getAddCartData");
      }
    } catch (e) {
      print("Get cart data error :$e");
    } finally {
      isGetCartData.value = false;
      update();
    }
  }

  Future removeCartApiMethod({String? itemId}) async {
    try {
      isRemoveCart.value = true;
      String? userId = PrefManager.getString('userId');

      String apiName = "${LocalStrings.removeCartApi}$userId/$itemId";

      // Make the API call to delete the item from the cart
      Response response = await APIFunction().delete(
        apiName: apiName,
        context: Get.context!,
        token: PrefManager.getString('token'), // Use the token if necessary
        isLoading: false, // If you need loading behavior
      );

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        PrefManager.removeCartListItem('cartProductId', '$itemId');
        List<String>? wishlistData = PrefManager.getStringList('cartProductId');
        print("Stored Data cart remove: ${wishlistData?.toList()}");
        showToast(
            context: Get.context!, message: "${response.data['message']}");
      } else {
        print("Failed to delete item: ${response.data}");
      }
    } catch (e) {
      print("Error deleting item: $e");
    } finally {
      isRemoveCart.value = false;
      update();
      // Perform any cleanup if necessary
    }
  }

  //Todo : Increment product items api method
  Future incrementProductApiMethod({
    String? cartId,
    String? productId,
    int? productSize,
    String? carat,
    String? colorJewellery,
    int? index,
  }) async {
    try {
      Map<String, dynamic> params = {
        "cartId": cartId,
        "productId": productId,
        "size": productSize ?? 6,
        "caratBy": carat ?? "14KT",
        "colorBy": colorJewellery ?? "Yellow Gold",
        "quantity": 1
      };
      print("Increment params : $params");
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.incrementCartItemQuantityApi,
        context: Get.context,
        params: params,
        isLoading: true,
        isGet: false,
      );
      if (response.statusCode == 200) {
        //Todo : Increment productId matched both then assign new quantity
        for (var product in response.data['updatedCart']['quantity']) {
          if (product['productId'] == productId) {
            getAddCartData?.cart?.quantity?[index!].quantity =
                product['quantity'];
            double updatedTotalPrice = getAddCartData!.totalPrice + product['totalPrice'];
            // Update the total price of the cart
            getAddCartData!.totalPrice = updatedTotalPrice;
          }
        }
      }
    } catch (e) {
      print("Increment cart error :$e");
    } finally {
      update();
    }
  }

  //Todo : Decrement product items api method
  Future decrementProductApiMethod({
    String? cartId,
    String? productId,
    int? productSize,
    String? carat,
    String? colorJewellery,
    int? index,
  }) async {
    try {
      Map<String, dynamic> params = {
        "cartId": cartId,
        "productId": productId,
        "size": productSize ?? 6,
        "caratBy": carat ?? "14KT",
        "colorBy": colorJewellery ?? "Yellow Gold",
        "quantity": 1
      };
      print("Increment params : $params");
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.decrementCartItemQuantityApi,
        context: Get.context,
        params: params,
        isLoading: true,
        isGet: false,
      );
      if (response.statusCode == 200) {
        //Todo : Increment productId matched both then assign new quantity
        for (var product in response.data['updatedCart']['quantity']) {
          if (product['productId'] == productId) {
            getAddCartData?.cart?.quantity?[index!].quantity =
                product['quantity'];
            double updatedTotalPrice = getAddCartData!.totalPrice - product['totalPrice'];
            // Update the total price of the cart
            getAddCartData!.totalPrice = updatedTotalPrice;
          }
        }
      }
    } catch (e) {
      print("Decrement cart error :$e");
    } finally {
      update();
    }
  }
}
