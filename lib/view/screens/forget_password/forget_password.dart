import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/data/controller/login/login_controller.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../../data/controller/forget_password/forget_password_controller.dart';
import '../../../data/controller/set_password/set_password_controller.dart';
import '../../components/common_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final createAccountController = Get.put(CreateAccountController());
  final setPasswordController = Get.put(SetPasswordController());
  final loginController = Get.put(LoginController());
  final forgetController = Get.put(ForgetPasswordController());

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createAccountController.getNewPasswordApiMethod(
          email: loginController.emailController.text.trim(), context: context);
      forgetController.startTimer();
    });
  }

  // bool isTextEnabled = true;
  // int remainingTime = 60;
  // Timer? timer;
  //
  // void startTimer() {
  //   setState(
  //     () {
  //       isTextEnabled = false;
  //       remainingTime = 60;
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
    final ForgetPasswordController forgetPasswordController =
        Get.put(ForgetPasswordController());
    return Scaffold(
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
              Image.asset(
                MyImages.resetPasswordImage,
                height: size.height * 0.20,
              ),
              const SizedBox(height: Dimensions.space40),
              Text(
                LocalStrings.checkYourEmail,
                textAlign: TextAlign.center,
                style: semiBoldMediumLarge.copyWith(),
              ),
              const SizedBox(height: Dimensions.space25),
              Text(
                LocalStrings.linkToResetPassword,
                textAlign: TextAlign.center,
                style: mediumDefault.copyWith(),
              ),
              const SizedBox(height: Dimensions.space30),
              CommonButton(
                onTap: () {
                  // Get.back();
                  Get.toNamed(RouteHelper.setOtpScreen, arguments: "forgot");
                },
                height: size.height * 0.065,
                width: double.infinity,
                buttonName: LocalStrings.continueToLogin,
              ),
              const SizedBox(height: Dimensions.space50),
              Text(
                LocalStrings.ifNotArriveEmail,
                textAlign: TextAlign.center,
                style: mediumDefault.copyWith(),
              ),
              // const SizedBox(height: Dimensions.space20),
              // Text(
              //   LocalStrings.sendEmailAgain,
              //   textAlign: TextAlign.center,
              //   style: mediumDefault.copyWith(
              //     color: ColorResources.offerColor,
              //   ),
              // ),
              Obx(
                () => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: forgetPasswordController.isTextEnabled.value
                            ? LocalStrings.sendEmailAgain
                            : "Please wait ${forgetPasswordController.remainingTime.value} seconds",
                        style: mediumDefault.copyWith(
                          color: ColorResources.offerColor,
                        ),
                        recognizer: forgetPasswordController.isTextEnabled.value
                            ? (TapGestureRecognizer()
                              ..onTap = () {
                                createAccountController.getNewPasswordApiMethod(
                                    email: loginController.emailController.text.trim(), context: context);
                                forgetPasswordController.startTimer();
                              })
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
