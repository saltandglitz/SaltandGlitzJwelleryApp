import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/validation.dart';
import '../../../local_storage/pref_manager.dart';
import '../bottom_bar/bottom_bar_controller.dart';

class SetPasswordController extends GetxController {
  String? email;
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  RxBool isLogin = false.obs;

  String? passwordError; // <--- inline error storage

  // Toggle password visibility
  isShowPassword() {
    showPassword = !showPassword;
    update();
  }

//isValidatePasswordAndLogin({String? email, String? password}) async {
//     final enteredPassword = passwordController.text.trim();
//
//     if (CommonValidation().isValidationEmpty(enteredPassword)) {
//       showSnackBar(
//         context: Get.context!,
//         title: "Error",
//         message: LocalStrings.enterPassword,
//         icon: Icons.error,
//         iconColor: Colors.red,
//       );
//
//       // showSnackBar(
//       //   context: Get.context!,
//       //   message: LocalStrings.enterPassword,
//       // );
//       return;
//     }
//
//     // Call login API and handle success/failure
//     try {
//       final success = await loginUserApiMethod(
//         email: email,
//         password: enteredPassword,
//       );
//
//       if (success) {
//         showToast(message: "Login successful", context: Get.context!);
//       } else {
//         showSnackBar(
//           context: Get.context!,
//           title: "Login Failed",
//           message: "Incorrect email or password.",
//           icon: Icons.error,
//           iconColor: Colors.red,
//         );
//       }
//     } catch (e) {
//       showSnackBar(
//         context: Get.context!,
//         title: "Error",
//         message: "Something went wrong. Please try again.",
//         icon: Icons.error,
//         iconColor: Colors.red,
//       );
//     }
//   }

  // Validate password and attempt login
  isValidatePasswordAndLogin({String? email}) async {
    final enteredPassword = passwordController.text.trim();

    if (CommonValidation().isValidationEmpty(enteredPassword)) {
      passwordError = LocalStrings.enterPassword;
      update();
      return;
    }

    passwordError = null;
    update();

    // Call login API
    try {
      final success = await loginUserApiMethod(
        email: email,
        password: enteredPassword,
      );

      if (success) {
        showToast(message: "Login successful", context: Get.context!);
      } else {
        passwordError = "Incorrect email or password.";
        update();
      }
    } catch (e) {
      passwordError = "Something went wrong. Please try again.";
      update();
    }
  }

  // Call Login API
  Future<bool> loginUserApiMethod({String? email, String? password}) async {
    try {
      final bottomBarController =
          Get.put<BottomBarController>(BottomBarController());
      isLogin.value = true;

      Map<String, dynamic> params = {
        'email': email,
        'password': password,
      };

      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.logInApi,
        context: Get.context,
        params: params,
        isLoading: false,
        isGet: false,
      );

      if (response.statusCode == 200) {
        PrefManager.setString('isLogin', 'yes');
        PrefManager.setString(
            'firstName', response.data['user']['firstName'] ?? '');
        PrefManager.setString(
            'lastName', response.data['user']['lastName'] ?? '');
        PrefManager.setString('email', response.data['user']['email'] ?? '');
        PrefManager.setString(
            'phoneNumber', response.data['user']['mobileNumber'] ?? '');
        PrefManager.setString('gender', response.data['user']['gender'] ?? '');
        PrefManager.setString('token', response.data['user']['token'] ?? '');
        PrefManager.setString('userId', response.data['user']['_id'] ?? '');
        PrefManager.setString(
            'userSaltCash', response.data['user']['userSaltCash'].toString());

        await mergeProductApiMethod(userId: PrefManager.getString('userId'));

        Get.offAllNamed(RouteHelper.bottomBarScreen);
        bottomBarController.selectedIndex = 3.obs;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Login API Error: $e");
      return false;
    } finally {
      isLogin.value = false;
      update();
    }
  }

  // Send OTP via email
  Future getOtpEmailApiMethod({String? email}) async {
    try {
      Map<String, dynamic> params = {'email': email};
      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.sendEmailOtpApi,
        context: Get.context,
        params: params,
      );
      if (response.statusCode == 200) {
        showToast(message: response.data['message'], context: Get.context!);
      }
    } catch (e) {
      log("Get OTP Email Error: $e");
    }
  }

  // Merge Guest Cart & Wishlist Products with Logged-In User
  Future mergeProductApiMethod({String? userId}) async {
    try {
      List<Map<String, dynamic>> cartProducts =
          PrefManager.getStringList('cartProductId')?.map((item) {
                Map<String, dynamic> productMap = json.decode(item);
                return {
                  "productId": productMap["productId"],
                  "size": productMap["size"],
                  "caratBy": productMap["caratBy"],
                  "colorBy": productMap["colorBy"],
                };
              }).toList() ??
              [];

      List<Map<String, dynamic>> wishlistProducts =
          PrefManager.getStringList('wishlistProductId')?.map((item) {
                Map<String, dynamic> productMap = json.decode(item);
                return {
                  "productId": productMap["productId"],
                };
              }).toList() ??
              [];

      Map<String, dynamic> params = {
        "userId": userId,
        "cartProducts": cartProducts,
        "wishlistProducts": wishlistProducts,
      };

      Response response = await APIFunction().apiCall(
        apiName: LocalStrings.mergeProductApi,
        context: Get.context,
        params: params,
        isLoading: false,
      );

      if (response.statusCode == 201) {
        log("Successfully merged guest products.");
      }
    } catch (e) {
      log("Merge Product Error: $e");
    } finally {
      update();
    }
  }
}
