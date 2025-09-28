import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:saltandglitz/api_repository/api_function.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/local_storage/pref_manager.dart';
import 'package:saltandglitz/view/components/common_message_show.dart';

import '../../../core/route/route.dart';
import '../../model/get_address_view_model.dart';
import '../../model/get_cart_view_model.dart';

class PlaceOrderController extends GetxController {
  bool isSameAsShipping = true;
  GetCartApiViewModel? getCartData;
  bool isGetCart = false;
  RxBool isCreateOrder = false.obs;
  String? cartId;
  List<Addresses> getAddress = [];
// Observable to hold selected radio button index
  RxInt selectedIndex = (-1).obs;


  /// New address
  TextEditingController firstNameNewAddress = TextEditingController();
  TextEditingController lastNameNewAddress = TextEditingController();
  TextEditingController streetNewAddress = TextEditingController();
  TextEditingController additionalInformationNewAddress =
      TextEditingController();
  TextEditingController pinCodeNewAddress = TextEditingController();
  TextEditingController cityNewAddress = TextEditingController();
  TextEditingController stateNewAddress = TextEditingController();
  TextEditingController countryNewAddress = TextEditingController();
  TextEditingController mobileNumberNewAddress = TextEditingController();

  /// Different address
  TextEditingController firstNameDifferentAddress = TextEditingController();
  TextEditingController lastNameDifferentAddress = TextEditingController();
  TextEditingController streetDifferentAddress = TextEditingController();
  TextEditingController additionalInformationDifferentAddress =TextEditingController();
  TextEditingController pinCodeDifferentAddress = TextEditingController();
  TextEditingController cityDifferentAddress = TextEditingController();
  TextEditingController stateDifferentAddress = TextEditingController();
  TextEditingController countryDifferentAddress = TextEditingController();
  TextEditingController mobileNumberDifferentAddress = TextEditingController();


  void selectAddressOption(bool value) {
    if (isSameAsShipping != value) {
      isSameAsShipping = value;
      update();
    }
  }
// Function to set the selected address index
  void selectAddress(int index) {
    selectedIndex.value = index;
  }
  /// Cancel click new address clear field
  clearAllNewAddressField() {
    firstNameNewAddress.clear();
    lastNameNewAddress.clear();
    streetNewAddress.clear();
    additionalInformationNewAddress.clear();
    pinCodeNewAddress.clear();
    cityNewAddress.clear();
    stateNewAddress.clear();
    countryNewAddress.clear();
    mobileNumberNewAddress.clear();
    update();
  }

  /// Cancel click Different address clear field
  clearAllDifferentAddressField() {
    firstNameDifferentAddress.clear();
    lastNameDifferentAddress.clear();
    streetDifferentAddress.clear();
    additionalInformationDifferentAddress.clear();
    pinCodeDifferentAddress.clear();
    cityDifferentAddress.clear();
    stateDifferentAddress.clear();
    countryDifferentAddress.clear();
    mobileNumberDifferentAddress.clear();
    update();
  }

  /// Get cart api method
  Future<void> getCartApiMethod() async {
    try {
      isGetCart = true;
      Response response = await APIFunction().apiCall(
        apiName: "${LocalStrings.getCartApi}${PrefManager.getString('userId')}",
        context: Get.context!,
        isLoading: false,
        isGet: true,
      );
      if (response.statusCode == 200) {
        getCartData = GetCartApiViewModel.fromJson(response.data);
      }
    } catch (e) {
      print("Get cart time error :$e");
    } finally {
      isGetCart = false;
      update();
    }
  }

  /// Create order api method
  Future<void> createOrderApiMethod({
    String? cartId,
    String? streetNewAddress,
    String? cityNewAddress,
    String? stateNewAddress,
    String? postalCodeNewAddress,
    String? countryNewAddress,
    String? streetDifferentAddress,
    String? cityDifferentAddress,
    String? stateDifferentAddress,
    String? postalCodeDifferentAddress,
    String? countryDifferentAddress,
  }) async {
    try {
      isCreateOrder.value = true;
      Map<String, dynamic> params = {
        "cartId": cartId ?? "",
        "billingAddress": {
          "street": streetNewAddress ?? "",
          "city": cityNewAddress ?? "",
          "state": stateNewAddress ?? "",
          "postalCode": postalCodeNewAddress ?? "",
          "country": countryNewAddress ?? ""
        },
        "shippingAddress": {
          "street": isSameAsShipping == false
              ? streetDifferentAddress
              : streetNewAddress ?? "",
          "city": isSameAsShipping == false
              ? cityDifferentAddress
              : cityNewAddress ?? "",
          "state": isSameAsShipping == false
              ? stateDifferentAddress
              : stateNewAddress ?? "",
          "postalCode": isSameAsShipping == false
              ? postalCodeDifferentAddress
              : postalCodeNewAddress ?? "",
          "country": isSameAsShipping == false
              ? countryDifferentAddress
              : countryNewAddress ?? ""
        }
      };
      print("PARAMS ORDER : $params");
      print("PARAMS ORDER 11 : $isSameAsShipping");
      Response response = await APIFunction().apiCall(
        apiName:
            "${LocalStrings.createOrderApi}${PrefManager.getString("userId")}",
        context: Get.context!,
        isLoading: false,
        params: params,
      );
      if (response.statusCode == 201) {
        print("Create order ===> ${response.data}");
        showToast(
            message: "${response.data["message"]}", context: Get.context!);
        Get.toNamed(RouteHelper.giftScreen);
        clearAllNewAddressField();
      }
    } catch (e) {
      print("Create Order time error : $e");
    } finally {
      isCreateOrder.value = false;
      update();
    }
  }

  /// Get address api method
  Future<void> getAddressApiMethod() async {
    try {
      Response response = await APIFunction().apiCall(
          apiName:
              "${LocalStrings.getAddressApi}${PrefManager.getString("userId")}",
          context: Get.context,
          isLoading: false,
          isGet: true);
      if (response.statusCode == 200) {
        getAddress = (response.data["address"]["addresses"] as List)
            .map((e) => Addresses.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Get cart address time error: $e");
    } finally {
      update();
    }
  }
}
