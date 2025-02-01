import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/resend_otp/resend_otp_controller.dart';
import '../../components/common_button.dart';

class SetOtp extends StatefulWidget {
  const SetOtp({super.key});

  @override
  State<SetOtp> createState() => _SetOtpState();
}

class _SetOtpState extends State<SetOtp> {
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
                  LocalStrings.enterOTP,
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
                //     const SizedBox(width: Dimensions.space10),
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
                //     const SizedBox(width: Dimensions.space10),
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
                //     const SizedBox(width: Dimensions.space10),
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
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: size.width * 0.1,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
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
                      ),
                    );
                  }),
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
                // Text(
                //   LocalStrings.resendOTP,
                //   style: mediumLarge.copyWith(),
                // ),

                Obx(
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
                          recognizer: resendOtpController.isTextEnabled.value
                              ? (TapGestureRecognizer()
                                ..onTap = () {
                                  resendOtpController.startTimer();
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
