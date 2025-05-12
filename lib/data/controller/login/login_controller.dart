

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/core/utils/validation.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/route/route.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isEnableNetwork = false.obs;

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

  emailValidation() {
    if (CommonValidation().isValidationEmpty(emailController.text)) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.enterEmailText,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else if (!CommonValidation().emailValidator(emailController.text)) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.enterValidEmail,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else {
      /// Analysis log login click
      AppAnalytics().actionTriggerUserLogin(
          eventName: LocalStrings.logLogInButtonClick,
          userCredential: emailController.text,
          index: 8);
      //Navigate to setPassword page
      Get.toNamed(RouteHelper.setPasswordScreen,
              arguments: emailController.text)!
          .then((value) => emailController.clear());
    }
  }
}
