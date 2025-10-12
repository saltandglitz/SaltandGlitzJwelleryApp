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
  TextEditingController additionalInformationDifferentAddress =
      TextEditingController();
  TextEditingController pinCodeDifferentAddress = TextEditingController();
  TextEditingController cityDifferentAddress = TextEditingController();
  TextEditingController stateDifferentAddress = TextEditingController();
  TextEditingController countryDifferentAddress = TextEditingController();
  TextEditingController mobileNumberDifferentAddress = TextEditingController();

  void selectAddressOption(bool value) {
    if (isSameAsShipping != value) {
      isSameAsShipping = value;
      clearAllDifferentAddressField();
      update();
    }
  }

  void selectAddress(int index) {
    selectedIndex.value = index;
  }

  /// Get selected address data
  Map<String, String> getSelectedAddressData() {
    if (selectedIndex.value >= 0 && selectedIndex.value < getAddress.length) {
      final address = getAddress[selectedIndex.value];
      return {
        'street': address.street ?? '',
        'city': address.city ?? '',
        'state': address.state ?? '',
        'postalCode': address.postalCode ?? '',
        'country': address.country ?? '',
      };
    }
    return {
      'street': streetNewAddress.text.trim(),
      'city': cityNewAddress.text.trim(),
      'state': stateNewAddress.text.trim(),
      'postalCode': pinCodeNewAddress.text.trim(),
      'country': countryNewAddress.text.trim(),
    };
  }

  /// Get billing address data based on current selection
  Map<String, String> getBillingAddressData() {
    if (isSameAsShipping) {
      // Use selected address or manual entry for both billing and shipping
      return getSelectedAddressData();
    } else {
      // Use different address for billing when not same as shipping
      return {
        'street': streetDifferentAddress.text.trim(),
        'city': cityDifferentAddress.text.trim(),
        'state': stateDifferentAddress.text.trim(),
        'postalCode': pinCodeDifferentAddress.text.trim(),
        'country': countryDifferentAddress.text.trim(),
      };
    }
  }

  /// Get shipping address data
  Map<String, String> getShippingAddressData() {
    // Shipping address is always the selected address or manual entry
    return getSelectedAddressData();
  }

  /// Calculate total for 14KT items
  double calculateTotal14KTPrice() {
    double total = 0;
    final cartItems = getCartData?.cart?.quantity ?? [];
    for (var item in cartItems) {
      if (item.caratBy == "14KT") {
        var price =
            double.tryParse(item.productId?.total14KT.toString() ?? '') ?? 0;
        var quantity = item.quantity ?? 0;
        total += price * quantity;
      }
    }
    return total;
  }

  /// Calculate total for 18KT items
  double calculateTotal18KTPrice() {
    double total = 0;
    final cartItems = getCartData?.cart?.quantity ?? [];
    for (var item in cartItems) {
      if (item.caratBy == "18KT") {
        var price =
            double.tryParse(item.productId?.total18KT.toString() ?? '') ?? 0;
        var quantity = item.quantity ?? 0;
        total += price * quantity;
      }
    }
    return total;
  }

  /// Get the appropriate total price (14KT or 18KT)
  double getDisplayTotalPrice() {
    double total14k = calculateTotal14KTPrice();
    double total18k = calculateTotal18KTPrice();

    // Return the greater value or the one that's not zero
    if (total14k > 0 && total18k > 0) {
      return total14k > total18k ? total14k : total18k;
    } else if (total14k > 0) {
      return total14k;
    } else if (total18k > 0) {
      return total18k;
    } else {
      // Fallback to original totalPrice
      return getCartData?.totalPrice ?? 0.0;
    }
  }

  /// Validate that we have valid address data
  bool _hasValidAddress() {
    // Check if an address is selected
    if (selectedIndex.value >= 0 && selectedIndex.value < getAddress.length) {
      return true;
    }

    // Check if manual address fields are filled
    final addressData = getSelectedAddressData();
    return addressData['street']!.isNotEmpty &&
        addressData['city']!.isNotEmpty &&
        addressData['state']!.isNotEmpty &&
        addressData['postalCode']!.isNotEmpty &&
        addressData['country']!.isNotEmpty;
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

      // Validate that we have address data
      if (!_hasValidAddress()) {
        showToast(
            message: "Please select an address or add a new address",
            context: Get.context!);
        return;
      }

      final billingAddress = getBillingAddressData();
      final shippingAddress = getShippingAddressData();

      Map<String, dynamic> params = {
        "cartId": cartId ?? "",
        "billingAddress": {
          "street": billingAddress['street'] ?? "",
          "city": billingAddress['city'] ?? "",
          "state": billingAddress['state'] ?? "",
          "postalCode": billingAddress['postalCode'] ?? "",
          "country": billingAddress['country'] ?? ""
        },
        "shippingAddress": {
          "street": shippingAddress['street'] ?? "",
          "city": shippingAddress['city'] ?? "",
          "state": shippingAddress['state'] ?? "",
          "postalCode": shippingAddress['postalCode'] ?? "",
          "country": shippingAddress['country'] ?? ""
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
