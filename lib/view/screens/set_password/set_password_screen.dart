import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/set_password/set_password_controller.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../../data/controller/login/login_controller.dart';
import '../../components/common_button.dart';
import '../../components/common_textfield.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final createAccountController = Get.put(CreateAccountController());
  final setPasswordController = Get.put(SetPasswordController());
  final loginController = Get.put(LoginController());
  String? otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.arguments != null) {
      setPasswordController.email = Get.arguments;
    }
  }

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
                      setPasswordController.email ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: mediumLarge.copyWith(),
                    ),
                    const SizedBox(width: Dimensions.space5),
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
                const SizedBox(height: Dimensions.space35),
                GetBuilder<SetPasswordController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          controller: controller.passwordController,
                          textFieldHeight: size.height * 0.1,
                          obSecureText: controller.showPassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.isShowPassword();
                            },
                            child: Icon(
                              controller.showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ColorResources.blackColor,
                              size: 22,
                            ),
                          ),
                          hintText: LocalStrings.password,
                          borderRadius: Dimensions.offersCardRadius,
                          fillColor: Colors.transparent,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChange: (value) => controller.passwordError =
                              null, // clear error on type
                          errorText:
                              controller.passwordError, // ✅ show inline error
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: Dimensions.space10),
                Obx(() {
                  return CommonButton(
                    onTap: () {
                      setPasswordController.isValidatePasswordAndLogin(
                        email: loginController.emailController.text.trim(),
                      );
                    },
                    height: size.height * 0.065,
                    width: double.infinity,
                    child: setPasswordController.isLogin.value
                        ? const CircularProgressIndicator(
                            color: ColorResources.whiteColor)
                        : Text(
                            LocalStrings.login,
                            style: mediumLarge.copyWith(
                                color: ColorResources.whiteColor),
                          ),
                  );
                }),
                const SizedBox(height: Dimensions.space25),
                GetBuilder(
                  init: CreateAccountController(),
                  builder: (controller) {
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocalStrings.forgotPassword,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(RouteHelper.forgetPasswordScreen);
                                /* controller.resetPasswordApiMethod(
                                  newPassword:
                                      controller.passwordController.text,
                                  otp: otp,
                                  email: setPasswordController.email,
                                  context: context,
                                );*/
                              },
                            style: mediumLarge.copyWith(
                              color: ColorResources.offerColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: Dimensions.space100),
                GetBuilder(
                  init: CreateAccountController(),
                  builder: (ctrl) {
                    return CommonButton(
                      onTap: () {
                        //Navigate to setPassword page
                        Get.toNamed(RouteHelper.setOtpScreen);
                        createAccountController.sendOtpApiMethod(
                          email: setPasswordController.email,
                          context: context,
                        );
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
