import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:solatn_gleeks/core/route/route.dart';
import 'package:solatn_gleeks/data/controller/create_account/create_account_controller.dart';
import 'package:solatn_gleeks/view/components/app_textfield.dart';

import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../components/common_button.dart';
import '../../components/common_textfield.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final createAccountController =
      Get.put<CreateAccountController>(CreateAccountController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder(
        init: CreateAccountController(),
        builder: (controller) {
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
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 40),
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
                                ColorResources.deliveryColorColor
                                    .withOpacity(0.5),
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
                                    color: ColorResources.borderColor
                                        .withOpacity(0.1),
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
                                color: ColorResources.offerSixColor
                                    .withOpacity(0.2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.borderColor
                                        .withOpacity(0.1),
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    style: mediumDefault.copyWith(
                                        color: ColorResources.offerColor),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                                    color: ColorResources.cardTabColor
                                        .withOpacity(0.3))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                LocalStrings.orText,
                                textAlign: TextAlign.center,
                                style: mediumSmall.copyWith(),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                                    color: ColorResources.cardTabColor
                                        .withOpacity(0.3))),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space35),

                        // Country code picker with text field
                        AppTextFieldWidget(
                          controller: createAccountController.mobileController,
                          hintText: LocalStrings.mobile,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),

                        const SizedBox(height: Dimensions.space35),
                        CommonTextField(
                          controller: createAccountController.emailController,
                          textFieldHeight: size.height * 0.065,
                          hintText: LocalStrings.enterEmail,
                          borderRadius: Dimensions.offersCardRadius,
                          fillColor: Colors.transparent,
                          textInputType: TextInputType.emailAddress,
                          // Change to phone if appropriate
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: Dimensions.space35),
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                controller:
                                    createAccountController.firstNameController,
                                textFieldHeight: size.height * 0.065,
                                hintText: LocalStrings.firstName,
                                borderRadius: Dimensions.offersCardRadius,
                                fillColor: Colors.transparent,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            const SizedBox(width: Dimensions.space25),
                            Expanded(
                              child: CommonTextField(
                                controller:
                                    createAccountController.lastNameController,
                                textFieldHeight: size.height * 0.065,
                                hintText: LocalStrings.lastName,
                                borderRadius: Dimensions.offersCardRadius,
                                fillColor: Colors.transparent,
                                textInputType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space35),
                        CommonTextField(
                          controller:
                              createAccountController.passwordController,
                          textFieldHeight: size.height * 0.065,
                          obSecureText: controller.showPassword,
                          onChange: (value) {
                            controller.validatePassword(value);
                          },
                          suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isShowPassword();
                              },
                              child: Icon(
                                controller.showPassword == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ColorResources.conceptTextColor,
                                size: 22,
                              )),
                          hintText: LocalStrings.password,
                          borderRadius: Dimensions.offersCardRadius,
                          fillColor: Colors.transparent,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: Dimensions.space7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 8 Chrs
                            _buildValidationIndicator(controller.hasEightChars,
                                controller.validColor, controller.invalidColor),

                            Text(LocalStrings.chars,
                                style: mediumSmall.copyWith(
                                    color: ColorResources.conceptTextColor)),
                            // 1 Uppercase
                            _buildValidationIndicator(controller.hasUppercase,
                                controller.validColor, controller.invalidColor),

                            Text(LocalStrings.uppercase,
                                style: mediumSmall.copyWith(
                                    color: ColorResources.conceptTextColor)),
                            // 1 Lowercase
                            _buildValidationIndicator(controller.hasLowercase,
                                controller.validColor, controller.invalidColor),

                            Text(LocalStrings.lowercase,
                                style: mediumSmall.copyWith(
                                    color: ColorResources.conceptTextColor)),
                            // 1 Symbol
                            _buildValidationIndicator(controller.hasSymbol,
                                controller.validColor, controller.invalidColor),

                            Text(LocalStrings.symbol,
                                style: mediumSmall.copyWith(
                                    color: ColorResources.conceptTextColor)),
                            // 1 Number
                            _buildValidationIndicator(controller.hasNumber,
                                controller.validColor, controller.invalidColor),

                            Text(LocalStrings.number,
                                style: mediumSmall.copyWith(
                                    color: ColorResources.conceptTextColor)),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space35),
                        CommonTextField(
                          controller:
                              createAccountController.confirmPasswordController,
                          textFieldHeight: size.height * 0.065,
                          obSecureText: controller.showConfirmPassword,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                controller.isShoConfirmPassword();
                              },
                              child: Icon(
                                controller.showConfirmPassword == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: ColorResources.conceptTextColor,
                                size: 22,
                              )),
                          hintText: LocalStrings.confirmPassword,
                          borderRadius: Dimensions.offersCardRadius,
                          fillColor: Colors.transparent,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: Dimensions.space30),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Create a Radio Female
                            Radio(
                              value: 1,
                              groupValue: createAccountController.selectedValue,
                              onChanged: (value) {
                                createAccountController.selectionGender(value);
                              },
                            ),
                            Text(
                              LocalStrings.female,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.conceptTextColor),
                            ),

                            // Create a Radio Men
                            Radio(
                              value: 2,
                              groupValue: createAccountController.selectedValue,
                              onChanged: (value) {
                                createAccountController.selectionGender(value);
                              },
                            ),
                            Text(
                              LocalStrings.male,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.conceptTextColor),
                            ),

                            // Create a Radio i don't want specify
                            Radio(
                              value: 3,
                              groupValue: createAccountController.selectedValue,
                              onChanged: (value) {
                                createAccountController.selectionGender(value);
                              },
                            ),
                            Text(
                              LocalStrings.other,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.conceptTextColor),
                            ),
                          ],
                        ),

                        const SizedBox(height: Dimensions.space30),
                        Container(
                          height: size.height * 0.157,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color:
                                ColorResources.videoCallColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(
                                Dimensions.offersCardRadius),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  createAccountController.isOptCheck();
                                },
                                child: Container(
                                  height: size.height * 0.030,
                                  width: size.width * 0.062,
                                  decoration: BoxDecoration(
                                      color: createAccountController.optCheck ==
                                              true
                                          ? ColorResources.cardTabColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.checkBoxRadius),
                                      border: Border.all(
                                          color: ColorResources.cardTabColor,
                                          width: 3)),
                                  child: createAccountController.optCheck ==
                                          true
                                      ? const Center(
                                          child: Icon(Icons.check,
                                              color: ColorResources.whiteColor,
                                              size: 16),
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                              const SizedBox(width: Dimensions.space15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocalStrings.optWhatsapp,
                                      style: semiBoldLarge.copyWith(
                                          color:
                                              ColorResources.conceptTextColor),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(
                                      LocalStrings.sharingDelivery,
                                      style: mediumSmall.copyWith(
                                          color:
                                              ColorResources.conceptTextColor),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height * 0.040,
                                width: size.width * 0.080,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: ColorResources.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.checkBoxRadius),
                                ),
                                child: Image.asset(MyImages.whatsappImage,
                                    color: ColorResources.moveCartColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space30),
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    style: mediumDefault.copyWith(
                                        color: ColorResources.offerColor),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        CommonButton(
                          onTap: () {
                            createAccountController.isValidation();
                          },
                          height: size.height * 0.065,
                          width: double.infinity,
                          buttonName: LocalStrings.signMe,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocalStrings.alreadyAccount,
                              style: mediumDefault.copyWith(
                                  color: ColorResources.conceptTextColor),
                            ),
                            TextSpan(
                              text: LocalStrings.loginLowercase,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(RouteHelper.loginScreen);
                                },
                              style: mediumDefault.copyWith(
                                  color: ColorResources.offerColor),
                            ),
                          ],
                        )),
                        const SizedBox(height: Dimensions.space10),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget _buildValidationIndicator(
      bool isValid, Color validColor, Color invalidColor) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: createAccountController.passwordController.text.isEmpty
            ? ColorResources.borderColor.withOpacity(0.2)
            : isValid
                ? validColor
                : invalidColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
