import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/core/route/route.dart';
import 'package:saltandGlitz/core/utils/color_resources.dart';
import 'package:saltandGlitz/core/utils/dimensions.dart';
import 'package:saltandGlitz/core/utils/images.dart';
import 'package:saltandGlitz/core/utils/local_strings.dart';
import 'package:saltandGlitz/data/controller/login/login_controller.dart';
import 'package:saltandGlitz/view/components/common_button.dart';
import 'package:saltandGlitz/view/components/common_textfield.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/utils/style.dart';
import '../../../core/utils/validation.dart';
import '../../../data/controller/create_account/create_account_controller.dart';
import '../../../main_controller.dart';
import '../../components/app_circular_loader.dart';
import '../../components/network_connectivity_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put<LoginController>(LoginController());
  final createAccountController =
      Get.put<CreateAccountController>(CreateAccountController());
  final mainController = Get.put<MainController>(MainController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainController.checkToAssignNetworkConnections();

    /// Analysis login view
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.logLogInView, index: 8);
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
          child: GetBuilder<MainController>(
            init: MainController(),
            builder: (mainController) {
              return mainController.isNetworkConnection?.value == false
                  ? NetworkConnectivityView(
                      onTap: () async {
                        RxBool? isEnableNetwork = await mainController
                            .checkToAssignNetworkConnections();

                        if (isEnableNetwork!.value == true) {
                          loginController.enableNetworkHideLoader();
                          Future.delayed(
                            const Duration(seconds: 3),
                            () {
                              Get.put<LoginController>(LoginController());
                              loginController.disableNetworkLoaderByDefault();
                            },
                          );
                          loginController.update();
                        }
                      },
                      isLoading: loginController.isEnableNetwork,
                    )
                  : SingleChildScrollView(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                mainController
                                    .checkToAssignNetworkConnections();
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                size: 25,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space20),
                          Center(
                            child: Image.asset(
                              MyImages.appLogo,
                              height: 25,
                            ),
                          ),
                          const SizedBox(height: Dimensions.space30),
                          Text(
                            LocalStrings.welcomeBack,
                            style: semiBoldMediumLarge.copyWith(),
                          ),
                          const SizedBox(height: Dimensions.space35),
                          Form(
                            key: _formKey,
                            child: CommonTextField(
                              controller: loginController.emailController,
                              textFieldHeight: size.height * 0.1,
                              hintText: LocalStrings.enterEmail,
                              borderRadius: Dimensions.offersCardRadius,
                              hintTexStyle: semiBoldDefault.copyWith(
                                color: ColorResources.hintTextColor,
                              ),
                              fillColor: Colors.transparent,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return LocalStrings.enterEmailText;
                                } else if (!CommonValidation()
                                    .emailValidator(value)) {
                                  return LocalStrings.enterValidEmail;
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: Dimensions.space10),
                          CommonButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // Validation passed
                                AppAnalytics().actionTriggerUserLogin(
                                  eventName: LocalStrings.logLogInButtonClick,
                                  userCredential:
                                      loginController.emailController.text,
                                  index: 8,
                                );

                                Get.toNamed(
                                  RouteHelper.setPasswordScreen,
                                  arguments:
                                      loginController.emailController.text,
                                )?.then((value) =>
                                    loginController.emailController.clear());
                              }
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
                                  color: ColorResources.cardTabColor
                                      .withOpacity(0.3),
                                ),
                              ),
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
                                      .withOpacity(0.3),
                                ),
                              ),
                              const SizedBox(height: Dimensions.space30),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space20),
                          GetBuilder(
                            init: CreateAccountController(),
                            builder: (controller) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// Google button
                                  GestureDetector(
                                    onTap: () {
                                      /// Analysis log google click
                                      AppAnalytics().actionTriggerLogs(
                                          eventName: LocalStrings
                                              .logLogInGoogleButtonClick,
                                          index: 8);
                                      // Google authentication
                                      controller
                                          .signInWithGoogle(screenType: 'Login')
                                          .then(
                                        (value) {
                                          /// Process complete after hide loader
                                          createAccountController
                                              .isLoaderOffMethod();
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.070,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color:
                                            ColorResources.helpNeedThirdColor,
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
                                      child: createAccountController
                                                  .isLoading ==
                                              true
                                          ? AppCircularLoader()
                                          : Image.asset(MyImages.googleImage),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: Dimensions.space30),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: LocalStrings.newSaltAndGlitz,
                                  style: mediumDefault.copyWith(
                                      color: ColorResources.blackColor),
                                ),
                                TextSpan(
                                  text: LocalStrings.createAccount,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      /// Analysis log Create Account Click
                                      AppAnalytics().actionTriggerLogs(
                                          eventName: LocalStrings
                                              .logLogInCreateAccountClick,
                                          index: 8);
                                      Get.toNamed(
                                          RouteHelper.createAccountScreen);
                                    },
                                  style: mediumDefault.copyWith(
                                    color: Color(0xff006600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Dimensions.space25),
                          Divider(
                              color:
                                  ColorResources.cardTabColor.withOpacity(0.3)),
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
                                      ..onTap = () {
                                        /// Analysis log Terms Conditions View
                                        AppAnalytics().actionTriggerLogs(
                                            eventName:
                                                LocalStrings.logLogInTermsView,
                                            index: 8);
                                      },
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
                                      ..onTap = () {
                                        /// Analysis log Privacy Policy View
                                        AppAnalytics().actionTriggerLogs(
                                            eventName: LocalStrings
                                                .logLogInPrivacyPolicyView,
                                            index: 8);
                                      },
                                    style: mediumDefault.copyWith(
                                        color: ColorResources.offerColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space10),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
