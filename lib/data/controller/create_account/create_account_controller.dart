import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/utils/color_resources.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';
import 'package:solatn_gleeks/core/utils/validation.dart';
import 'package:solatn_gleeks/view/components/common_message_show.dart';

class CreateAccountController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Color validColor = ColorResources.videoCallColor;
  final Color invalidColor = ColorResources.notValidateColor;

  bool hasEightChars = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSymbol = false;
  bool hasNumber = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool optCheck = true;
  int selectedValue = 3;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void validatePassword(String value) {
    hasEightChars = value.length >= 8;
    hasUppercase = value.contains(RegExp(r'[A-Z]'));
    hasLowercase = value.contains(RegExp(r'[a-z]'));
    hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasNumber = value.contains(RegExp(r'[0-9]'));
    update();
  }

// Show password method
  isShowPassword() {
    showPassword = !showPassword;
    update();
  }

// Show confirm password method
  isShoConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  selectionGender(value) {
    selectedValue = value;
    update();
  }

// Check box selection by default true
  isOptCheck() {
    optCheck = !optCheck;
    update();
  }

// Checked validation after move signup
  isValidation() {
    if (CommonValidation().isValidationEmpty(mobileController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterMobileNumber);
    } else if (!CommonValidation().phoneValidator(mobileController.text) ||
        mobileController.text.length <= 9) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterValidNumber);
    } else if (CommonValidation().isValidationEmpty(emailController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterEmailText);
    } else if (!CommonValidation().emailValidator(emailController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterValidEmail);
    } else if (CommonValidation().isValidationEmpty(firstNameController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterFirstName);
    } else if (CommonValidation().isValidationEmpty(lastNameController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterLastName);
    } else if (CommonValidation().isValidationEmpty(passwordController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterPassword);
    } else if (hasEightChars == false ||
        hasUppercase == false ||
        hasLowercase == false ||
        hasSymbol == false ||
        hasNumber == false) {
      showSnackBar(context: Get.context!, message: LocalStrings.validPassword);
    } else if (CommonValidation()
        .isValidationEmpty(confirmPasswordController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterConfirmPassword);
    } else if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.validConfirmPassword);
    } else {
      // Navigation after signup
      showToast(
          message: LocalStrings.signupSuccessfully, context: Get.context!);
    }
    update();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
