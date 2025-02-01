import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../components/common_button.dart';
import '../../components/common_textfield.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final createAccountController = Get.put(CreateAccountController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorResources.scaffoldBackgroundColor,
        body: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space50),
                Text(
                  LocalStrings.passwordToLogin,
                  style: semiBoldMediumLarge.copyWith(),
                ),
                const SizedBox(height: Dimensions.space15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalStrings.xyzGmail,
                      textAlign: TextAlign.center,
                      style: mediumLarge.copyWith(),
                    ),
                    const SizedBox(width: Dimensions.space8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocalStrings.changeEmail,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                              },
                            style: mediumLarge.copyWith(
                              color: ColorResources.offerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.space5),
                Text(
                  LocalStrings.phoneNumber,
                  style: mediumLarge.copyWith(),
                ),
                const SizedBox(height: Dimensions.space35),
                GetBuilder(
                  init: CreateAccountController(),
                  builder: (controller) {
                    return CommonTextField(
                      controller: createAccountController.passwordController,
                      textFieldHeight: size.height * 0.065,
                      obSecureText: controller.showPassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.isShowPassword();
                        },
                        child: Icon(
                          controller.showPassword == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorResources.blackColor,
                          size: 22,
                        ),
                      ),
                      hintText: LocalStrings.password,
                      borderRadius: Dimensions.offersCardRadius,
                      fillColor: Colors.transparent,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    );
                  },
                ),
                const SizedBox(height: Dimensions.space25),
                CommonButton(
                  onTap: () {
                    //Navigate to setPassword page
                    Get.toNamed(RouteHelper.setPasswordScreen);
                  },
                  height: size.height * 0.065,
                  width: double.infinity,
                  buttonName: LocalStrings.login,
                ),
                const SizedBox(height: Dimensions.space25),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: LocalStrings.forgotPassword,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(RouteHelper.forgetPasswordScreen);
                          },
                        style: mediumLarge.copyWith(
                          color: ColorResources.offerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.space100),
                CommonButton(
                  onTap: () {
                    //Navigate to setPassword page
                    Get.toNamed(RouteHelper.setOtpScreen);
                  },
                  height: size.height * 0.065,
                  width: double.infinity,
                  buttonName: LocalStrings.getOTP,
                  textStyle: mediumLarge.copyWith(
                    color: ColorResources.blackColor,
                  ),
                  borderColor: ColorResources.borderColor,
                  gradientFirstColor: ColorResources.whiteColor,
                  gradientSecondColor: ColorResources.whiteColor,
                ),
                const SizedBox(height: Dimensions.space25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.070,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorResources.helpNeedThirdColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.borderColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(MyImages.googleImage),
                    ),
                    const SizedBox(width: Dimensions.space25),
                    Container(
                      height: size.height * 0.070,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: ColorResources.offerSixColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.borderColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(MyImages.facebookImage),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
