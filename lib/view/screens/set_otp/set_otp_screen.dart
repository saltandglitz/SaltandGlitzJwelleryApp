import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/data/controller/login/login_controller.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../../data/controller/resend_otp/resend_otp_controller.dart';
import '../../../data/controller/set_password/set_password_controller.dart';
import '../../components/common_button.dart';

class SetOtp extends StatefulWidget {
  const SetOtp({super.key});

  @override
  State<SetOtp> createState() => _SetOtpState();
}

class _SetOtpState extends State<SetOtp> {
  final createAccountController = Get.put(CreateAccountController());
  final setPasswordController = Get.put(SetPasswordController());
  final resendController = Get.put(ResendOtpController());
  final loginController = Get.put(LoginController());
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  String isForgot = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Todo : Initial start timer to resend otp
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        resendController.startTimer();
      },
    );
    if (Get.arguments != null) {
      isForgot = Get.arguments;
    }
  }

  // bool isTextEnabled = true;
  // int remainingTime = 10;
  // Timer? timer;
  //
  // void startTimer() {
  //   setState(
  //     () {
  //       isTextEnabled = false;
  //       remainingTime = 10;
  //     },
  //   );
  //
  //   timer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (Timer timer) {
  //       setState(
  //         () {
  //           if (remainingTime > 0) {
  //             remainingTime--;
  //           } else {
  //             timer.cancel();
  //             isTextEnabled = true;
  //           }
  //         },
  //       );
  //     },
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ResendOtpController resendOtpController =
        Get.put(ResendOtpController());
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
                  isForgot == 'forgot'
                      ? LocalStrings.forgotPassword
                      : LocalStrings.enterOTP,
                  style: semiBoldMediumLarge.copyWith(),
                ),
                const SizedBox(height: Dimensions.space15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      setPasswordController.email ?? '',
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
                                if (isForgot == 'forgot') {
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                } else {
                                  Get.back();
                                }
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
                // const SizedBox(height: Dimensions.space5),
                // Text(
                //   LocalStrings.phoneNumber,
                //   style: mediumLarge.copyWith(),
                // ),
                const SizedBox(height: Dimensions.space35),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: size.height * 0.055,
                //       width: size.width * 0.099,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: ColorResources.borderColor,
                //         ),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //      const SizedBox(height: Dimensions.space10),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        width: size.width * 0.1,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: otpControllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.space25),
                isForgot == 'forgot'
                    ? Column(
                        children: [
                          GetBuilder(
                            init: CreateAccountController(),
                            builder: (controller) {
                              return CommonTextField(
                                controller: controller.passwordController,
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
                        ],
                      )
                    : const SizedBox(),
                Obx(
                  () {
                    return CommonButton(
                      onTap: () async {
                        String otp = otpControllers
                            .map((controller) => controller.text)
                            .join();
                        if (otp.length < 4) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              message: "Please enter a valid OTP",
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        isForgot == 'forgot'
                            ? createAccountController.resetPasswordApiMethod(
                                email: setPasswordController.email,
                                context: context,
                                otp: otp,
                                newPassword: createAccountController
                                    .passwordController.text
                                    .trim())
                            : createAccountController.getOtpApiMethod(
                                email: setPasswordController.email ?? '',
                                context: context,
                                otp: otp,
                              );
                      },
                      height: size.height * 0.065,
                      width: double.infinity,
                      child: createAccountController.isLogin.value == true
                          ? const CircularProgressIndicator(
                              color: ColorResources.whiteColor)
                          : Text(
                              isForgot == 'forgot'
                                  ? LocalStrings.reset
                                  : LocalStrings.login,
                              style: mediumLarge.copyWith(
                                color: ColorResources.whiteColor,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: Dimensions.space25),
                isForgot == 'forgot'
                    ? const SizedBox()
                    : Obx(
                        () => RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: resendOtpController.isTextEnabled.value
                                    ? LocalStrings.resendOTP
                                    : 'Resend OTP in ${resendOtpController.remainingTime.value} seconds',
                                style: mediumLarge.copyWith(
                                  color: ColorResources.offerColor,
                                ),
                                recognizer: resendOtpController
                                        .isTextEnabled.value
                                    ? (TapGestureRecognizer()
                                      ..onTap = () {
                                        resendOtpController.startTimer();
                                        isForgot == 'forgot'
                                            ? createAccountController
                                                .getNewPasswordApiMethod(
                                                    email: loginController
                                                        .emailController.text
                                                        .trim(),
                                                    context: context)
                                            : createAccountController
                                                .sendOtpApiMethod(
                                                email:
                                                    setPasswordController.email,
                                                context: context,
                                              );
                                      })
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(height: Dimensions.space100),
                CommonButton(
                  onTap: () {
                    //Navigate to setPassword page
                    Get.toNamed(RouteHelper.setPasswordScreen);
                  },
                  height: size.height * 0.065,
                  width: double.infinity,
                  buttonName: LocalStrings.logInWithPassword,
                  textStyle: mediumLarge.copyWith(
                    color: ColorResources.blackColor,
                  ),
                  borderColor: ColorResources.borderColor,
                  gradientFirstColor: ColorResources.whiteColor,
                  gradientSecondColor: ColorResources.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
