import 'package:get/get.dart';
import 'package:saltandGlitz/main_controller.dart';

import '../core/utils/local_strings.dart';

/// Whole app manage analysis in this class method
class AppAnalytics {
  final mainController = Get.put<MainController>(MainController());

  /// Users in app action activity logs
  actionTriggerLogs(
      {required String eventName, String? userName, int? index}) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'user_name': userName ?? LocalStrings.logGuestUser,
      'page_index': index ?? 0,
    });
    // user_location
    // product
    // product price
    // which platform show product
  }

  /// Users in app action activity with products logs
  actionTriggerWithProductsLogs({
    required String eventName,
    String? userName,
    int? index,
    String? productName,
    String? productImage,
    String? productFilter,
  }) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'user_name': userName ?? LocalStrings.logGuestUser,
      'page_index': index ?? 0,
      'product_name': productName ?? '',
      'product_image': productImage ?? '',
      'product_filter': productFilter ?? '',
    });
    // user_location
    // product
    // product price
    // which platform show product
  }

  /// Users search products item logs
  actionTriggerSearchProductLogs({
    required String eventName,
    String? userName,
    int? index,
    String? searchProduct,
  }) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'user_name': userName ?? LocalStrings.logGuestUser,
      'page_index': index ?? 0,
      'search_product': searchProduct ?? '',
    });
  }

  /// User login logs
  actionTriggerUserLogin({
    required String eventName,
    String? userCredential,
    int? index,
  }) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'user_credential': userCredential ?? '',
      'page_index': index ?? 0,
    });
  }

  /// Create new account logs
  actionTriggerCreateNewAccount({
    required String eventName,
    String? mobileNo,
    String? email,
    String? firstName,
    String? lastName,
    String? genderSelection,
    String? whatsappSupport,
    int? index,
  }) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'mobile_number': mobileNo ?? '',
      'email': email ?? '',
      'first_name': firstName ?? '',
      'last_name': lastName ?? '',
      'gender_selection': genderSelection ?? '',
      'whatsapp_support': whatsappSupport ?? '',
      'page_index': index ?? 0,
    });
  }

  /// Edit profile logs
  actionEditProfileAccount({
    required String eventName,
    String? mobileNo,
    String? email,
    String? firstName,
    String? lastName,
    String? pinCode,
    String? genderSelection,
    String? birthday,
    String? anniversary,
    String? occupation,
    String? spousBirthday,
    int? userSaltCash,
    int? index,
  }) async {
    await mainController.analytics.logEvent(name: eventName, parameters: {
      'first_name': firstName ?? '',
      'last_name': lastName ?? '',
      'mobile_number': mobileNo ?? '',
      'email': email ?? '',
      'pin_code': pinCode ?? '',
      'gender_selection': genderSelection ?? '',
      'birthday': birthday ?? '',
      'anniversary': anniversary ?? '',
      'occupation': occupation ?? '',
      'spous_birthday': spousBirthday ?? '',
      'page_index': index ?? 0,
      'user_salt_cash': userSaltCash ?? 0,
    });
  }
}
