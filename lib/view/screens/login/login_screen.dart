import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/route/route.dart';
import 'package:solatn_gleeks/core/utils/color_resources.dart';
import 'package:solatn_gleeks/core/utils/dimensions.dart';
import 'package:solatn_gleeks/core/utils/images.dart';
import 'package:solatn_gleeks/core/utils/local_strings.dart';
import 'package:solatn_gleeks/data/controller/login/login_controller.dart';
import 'package:solatn_gleeks/view/components/common_button.dart';
import 'package:solatn_gleeks/view/components/common_textfield.dart';

import '../../../core/utils/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put<LoginController>(LoginController());

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
                  const SizedBox(height: Dimensions.space20),
                  Container(
                    height: size.height * 0.090,
                    width: size.width * 0.30,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorResources.offerColor,
                          ColorResources.deliveryColorColor.withOpacity(0.5),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        MyImages.qualityImage,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  Text(
                    LocalStrings.welcomeBack,
                    style: semiBoldMediumLarge.copyWith(),
                  ),
                  const SizedBox(height: Dimensions.space20),
                  Text(
                    LocalStrings.loginUnlock,
                    textAlign: TextAlign.center,
                    style: mediumLarge.copyWith(),
                  ),
                  const SizedBox(height: Dimensions.space35),
                  CommonTextField(
                    controller: loginController.enterMobileNumberController,
                    textFieldHeight: size.height * 0.065,
                    hintText: LocalStrings.enterEmail,
                    borderRadius: Dimensions.offersCardRadius,
                    hintTexStyle: semiBoldDefault.copyWith(
                      color: ColorResources.hintTextColor,
                    ),
                    fillColor: Colors.transparent,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: Dimensions.space30),
                  CommonButton(
                    onTap: () {
                      //Navigate to setPassword page
                      Get.toNamed(RouteHelper.setPasswordScreen);
                    },
                    height: size.height * 0.065,
                    width: double.infinity,
                    buttonName: LocalStrings.continueLogin,
                  ),
                  const SizedBox(height: Dimensions.space30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: ColorResources.cardTabColor.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          LocalStrings.orText,
                          textAlign: TextAlign.center,
                          style: mediumSmall.copyWith(),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: ColorResources.cardTabColor.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space30),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space20),
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
                              color:
                                  ColorResources.borderColor.withOpacity(0.1),
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
                              color:
                                  ColorResources.borderColor.withOpacity(0.1),
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
                  const SizedBox(height: Dimensions.space30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: LocalStrings.newSaltAndGlitz,
                          style: mediumDefault.copyWith(
                              color: ColorResources.buttonColorDark),
                        ),
                        TextSpan(
                          text: LocalStrings.createAccount,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(RouteHelper.createAccountScreen);
                            },
                          style: mediumDefault.copyWith(
                              color: ColorResources.offerColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space25),
                  Divider(color: ColorResources.cardTabColor.withOpacity(0.3)),
                  const SizedBox(height: Dimensions.space25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocalStrings.continuingAgree,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.buttonColorDark),
                            ),
                            TextSpan(
                              text: LocalStrings.termsConditions,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: mediumDefault.copyWith(
                                  color: ColorResources.offerColor),
                            ),
                            TextSpan(
                              text: LocalStrings.andText,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.buttonColorDark),
                            ),
                            TextSpan(
                              text: LocalStrings.privacyPolicy,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: mediumDefault.copyWith(
                                  color: ColorResources.offerColor),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: Dimensions.space10),
                ],
              ),
            )),
      ),
    );
  }
}
