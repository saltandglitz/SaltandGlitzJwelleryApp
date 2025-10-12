import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandglitz/api_repository/api_function.dart';
import 'package:saltandglitz/core/utils/images.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/data/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:saltandglitz/data/model/get_add_cart_view_model.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';
import 'package:saltandglitz/view/components/common_message_show.dart';

class AddToCartController extends GetxController {
  int currentIndex = 0;
  Timer? timer;
  RxBool isEnableNetwork = false.obs;
  RxBool isGetCartData = false.obs;
  RxBool isRemoveCart = false.obs;

  GetAddCartViewModel? getAddCartData;
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());

  static List<Map<String, String>> texts = [
    {"title": LocalStrings.pointsOrder, "subtitle": LocalStrings.nextOrder},
    {"title": LocalStrings.oderOnline, "subtitle": LocalStrings.sameDay},
  ];

  List productsImage = [
    MyImages.ringsProductsImage,
    MyImages.earringsProductsImage,
    MyImages.chainProductsImage
  ];

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

  implementAnimationOffersMethod() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      currentIndex = (currentIndex + 1) % texts.length;
      update();
    });
  }

  removeProduct(int index) {
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

  // Total for 14KT items
  double calculateTotal14KTPrice() {
    double total = 0;
    final cartItems = getAddCartData?.cart?.quantity ?? [];

    for (var item in cartItems) {
      if (item.caratBy == "14KT") {
        var price =
            double.tryParse(item.productId?.total14KT.toString() ?? '') ?? 0;

        final qty = item.quantity ?? 1;
        total += price * qty;
      }
    }

    return total;
  }

// Total for 18KT items
  double calculateTotal18KTPrice() {
    double total = 0;
    final cartItems = getAddCartData?.cart?.quantity ?? [];

    for (var item in cartItems) {
      if (item.caratBy == "18KT") {
        var price =
            double.tryParse(item.productId?.total18KT.toString() ?? '') ?? 0;

        final qty = item.quantity ?? 1;
        total += price * qty;
      }
    }

    return total;
  }

// Combined total
  double calculateTotalPrice() {
    return calculateTotal14KTPrice() + calculateTotal18KTPrice();
  }

  // Helper method to get price for a single cart item
  double getItemPrice(dynamic item) {
    if (item == null) return 0;

    if (item.caratBy == "14KT") {
      return getItem14KTPrice(item);
    } else if (item.caratBy == "18KT") {
      return getItem18KTPrice(item);
    }

    return 0;
  }

  // Get 14KT price for a single item
  double getItem14KTPrice(dynamic item) {
    if (item?.productId == null) return 0;

    var price =
        double.tryParse(item.productId?.total14KT.toString() ?? '') ?? 0;

    return price;
  }

  // Get 18KT price for a single item
  double getItem18KTPrice(dynamic item) {
    if (item?.productId == null) return 0;

    var price =
        double.tryParse(item.productId?.total18KT.toString() ?? '') ?? 0;

    return price;
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
        print("Parsed Total Price: ${getAddCartData?.totalPrice}");
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

      Response response = await APIFunction().delete(
        apiName: apiName,
        context: Get.context!,
        token: PrefManager.getString('token'),
        isLoading: false,
      );

      if (response.statusCode == 200) {
        PrefManager.removeCartWishlistListItem('cartProductId', '$itemId');
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
    }
  }

  // ✅ Increment item
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
        for (var product in response.data['updatedCart']['quantity']) {
          if (product['productId'] == productId) {
            getAddCartData?.cart?.quantity?[index!].quantity =
                product['quantity'];
            getAddCartData?.cart?.quantity?[index!].totalPrice =
                product['totalPrice'];
          }
        }
      }
    } catch (e) {
      print("Increment cart error :$e");
    } finally {
      update();
    }
  }

  // ✅ Decrement item
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
      print("Decrement params : $params");
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.decrementCartItemQuantityApi,
        context: Get.context,
        params: params,
        isLoading: true,
        isGet: false,
      );
      if (response.statusCode == 200) {
        for (var product in response.data['updatedCart']['quantity']) {
          if (product['productId'] == productId) {
            getAddCartData?.cart?.quantity?[index!].quantity =
                product['quantity'];
            getAddCartData?.cart?.quantity?[index!].totalPrice =
                product['totalPrice'];
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
