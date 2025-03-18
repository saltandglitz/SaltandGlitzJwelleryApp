import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

// Show password method
  isShowPassword() {
    showPassword = !showPassword;
    update();
  }

  isValidatePasswordAndLogin({String? email, String? password}) {
    if (CommonValidation().isValidationEmpty(passwordController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterPassword);
    } else {
      /// Login user api method
      loginUserApiMethod(email: email, password: password);
    }
  }

  Future loginUserApiMethod({String? email, String? password}) async {
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
          isGet: false);
      print("Response_data : ${response.data['message']}");
      if (response.statusCode == 200) {
        /// Stored data in device Google login or not,First name, Last name & email
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
        //Todo : Off all navigation and move My account screen
        Get.offAllNamed(RouteHelper.bottomBarScreen);
        bottomBarController.selectedIndex = 2.obs;
      } else {
        showSnackBar(
            context: Get.context!, message: "${response.data['message']}");
      }
    } catch (e) {
      print("Login Time Error : $e");
    } finally {
      isLogin.value = false;
      update();
    }
  }

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
      } else {
        showSnackBar(context: Get.context!, message: response.data['message']);
      }
    } catch (e) {
      printActionError("Get otp error : $e");
    }
  }
}
