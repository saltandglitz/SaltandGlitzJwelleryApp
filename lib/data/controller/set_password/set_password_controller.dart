import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandGlitz/api_repository/api_function.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/utils/validation.dart';

class SetPasswordController extends GetxController {
  String? email;
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  isShowPassword() {
    showPassword = !showPassword;
    update();
  }

  isValidatePasswordAndLogin({String? email, String? password}) {
    print("Entered Password: ${passwordController.text = password ?? ""}");
    if (CommonValidation().isValidationEmpty(passwordController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterPassword);
    } else {
      /// Login user api method
      loginUserApiMethod(email: email, password: password);
    }
  }

  Future loginUserApiMethod({String? email, String? password}) async {
    try {
      Map<String, dynamic> params = {
        'email': email,
        'password': password,
      };
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.logInApi, context: Get.context, params: params);
      print("Response_data : ${response.data['message']}");
      if (response.statusCode == 200) {
      } else {
        showSnackBar(
            context: Get.context!, message: "${response.data['message']}");
      }
    } catch (e) {
      print("Login Time Error : $e");
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
