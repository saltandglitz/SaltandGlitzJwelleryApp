import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:saltandglitz/core/utils/local_strings.dart';
import 'package:saltandglitz/data/controller/edit_profile/edit_profile_controller.dart';
import 'package:saltandglitz/view/components/app_textfield.dart';
import '../../../analytics/app_analytics.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/style.dart';
import '../../components/app_bar_background.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Analysis log edit profile view
    AppAnalytics()
        .actionTriggerLogs(eventName: LocalStrings.editProfileView, index: 15);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder(
      init: EditProfileController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: ColorResources.scaffoldBackgroundColor,
            appBar: AppBarBackground(
              child: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: Text(LocalStrings.myAccount),
                titleTextStyle: regularLarge.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorResources.buttonColor,
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  color: ColorResources.buttonColor,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        /// Analysis log whatsapp click
                        AppAnalytics().actionTriggerLogs(
                            eventName: LocalStrings.editProfileWhatsappClick,
                            index: 15);
                      },
                      child: Image.asset(
                        MyImages.whatsappImage,
                        height: size.height * 0.055,
                        width: size.width * 0.055,
                        color: ColorResources.buttonColor,
                      ),
                    ),
                  ),
                ],
                backgroundColor: ColorResources.whiteColor,
                // Set the background color of the AppBar
                elevation: 0, // Remove default shadow
              ),
            ),
            // Save changes
            bottomSheet: GestureDetector(
              onTap: () {
                // Is Validation Check Save Changes
                controller.isValidation();
              },
              child: Container(
                height: size.height * 0.080,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: ColorResources.buttonColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.borderColor,
                      offset: Offset(0, 1),
                      // Position the shadow below the AppBar
                      blurRadius: 2, // Adjust the blur radius as needed
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    LocalStrings.saveChanges,
                    style: mediumMediumLarge.copyWith(
                      color: ColorResources.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 15, vertical: 12),
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         BorderRadius.circular(Dimensions.offersCardRadius),
                    //     gradient: const LinearGradient(
                    //       colors: [
                    //         ColorResources.offerFirstColor,
                    //         ColorResources.offerNineColor,
                    //         ColorResources.lightGreenColour,
                    //       ],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         LocalStrings.editProfile,
                    //         style: regularLarge.copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           color: ColorResources.buttonColor,
                    //         ),
                    //       ),
                    //       const SizedBox(height: Dimensions.space5),
                    //       Text(
                    //         LocalStrings.specialOccasions,
                    //         style: regularDefault.copyWith(
                    //           color: ColorResources.buttonColor,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: Dimensions.space30),
                    AppTextFieldWidget(
                      controller: controller.firstName,
                      isShowCountryPicker: false,
                      labelText: LocalStrings.firstNameStar,
                      boxConstraints: const BoxConstraints(minWidth: 15),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    AppTextFieldWidget(
                      controller: controller.lastName,
                      isShowCountryPicker: false,
                      labelText: LocalStrings.lastNameStar,
                      boxConstraints: const BoxConstraints(minWidth: 15),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    AppTextFieldWidget(
                      controller: controller.mobileNumber,
                      isEnable: false,
                      fillColor:
                          ColorResources.lightGreenColour.withOpacity(0.3),
                      labelText: LocalStrings.mobileNumber,
                      suffixIcon: const Icon(
                        Icons.check_circle_rounded,
                        color: ColorResources.offerColor,
                        size: 25,
                      ),
                    ),
                    const SizedBox(height: Dimensions.space35),

                    // EmailId & verify
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFieldWidget(
                            controller: controller.email,
                            isShowCountryPicker: false,
                            isEnable: false,
                            fillColor: ColorResources.lightGreenColour
                                .withOpacity(0.3),
                            labelText: LocalStrings.emailId,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                          ),
                        ),

                        const SizedBox(width: Dimensions.space20),
                        // Verify email
                        GestureDetector(
                          onTap: () {
                            //Verify email bottom sheet
                            verifyEmailBottomSheet();
                            controller.startTimer();
                          },
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                              color: ColorResources.lightGreenColour
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius),
                            ),
                            child: Center(
                              child: Text(
                                LocalStrings.verify,
                                style: mediumDefault.copyWith(
                                  color: ColorResources.buttonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space35),
                    AppTextFieldWidget(
                      controller: controller.pinCode,
                      isShowCountryPicker: false,
                      labelText: LocalStrings.pinCode,
                      boxConstraints: const BoxConstraints(minWidth: 15),
                    ),
                    const SizedBox(height: Dimensions.space30),
                    // Gender selection radio button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Create a Radio Male
                        Flexible(
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.27,
                            decoration: BoxDecoration(
                              color: ColorResources.lightGreenColour
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: ColorResources.buttonColor,
                                  value: 1,
                                  groupValue: controller.selectedValue,
                                  onChanged: (value) {
                                    controller.selectionGender(value);
                                  },
                                ),
                                Text(
                                  LocalStrings.male,
                                  style: mediumDefault.copyWith(
                                      color: ColorResources.buttonColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space20),
                        // Create a Radio Female
                        Flexible(
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.27,
                            decoration: BoxDecoration(
                              color: ColorResources.lightGreenColour
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: ColorResources.buttonColor,
                                  value: 2,
                                  groupValue: controller.selectedValue,
                                  onChanged: (value) {
                                    controller.selectionGender(value);
                                  },
                                ),
                                Text(
                                  LocalStrings.female,
                                  style: mediumDefault.copyWith(
                                      color: ColorResources.buttonColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.space20),
                        // Create a Radio Other
                        Flexible(
                          child: Container(
                            height: size.height * 0.065,
                            width: size.width * 0.27,
                            decoration: BoxDecoration(
                              color: ColorResources.lightGreenColour
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.offersCardRadius),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: ColorResources.buttonColor,
                                  value: 3,
                                  groupValue: controller.selectedValue,
                                  onChanged: (value) {
                                    controller.selectionGender(value);
                                  },
                                ),
                                Text(
                                  LocalStrings.other,
                                  style: mediumDefault.copyWith(
                                      color: ColorResources.buttonColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space35),
                    // Birthday
                    GestureDetector(
                      onTap: () {
                        controller.datePicker(LocalStrings.birthday);
                      },
                      child: AppTextFieldWidget(
                        controller: controller.birthDay,
                        isShowCountryPicker: false,
                        labelText: LocalStrings.birthday,
                        isEnable: false,
                        boxConstraints: const BoxConstraints(minWidth: 15),
                        suffixIcon: Container(
                          height: size.height * 0.10,
                          width: size.width * 0.10,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 10),
                          decoration: BoxDecoration(
                            color: ColorResources.backgroundDatePickerColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorResources.borderColor.withOpacity(0.3),
                                offset: const Offset(0.0, 1.0), //(x,y)
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.calendar_month_rounded,
                              size: 23, color: ColorResources.buttonColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    // Anniversary
                    GestureDetector(
                      onTap: () {
                        controller.datePicker(LocalStrings.anniversary);
                      },
                      child: AppTextFieldWidget(
                        controller: controller.anniversary,
                        isShowCountryPicker: false,
                        labelText: LocalStrings.anniversary,
                        isEnable: false,
                        boxConstraints: const BoxConstraints(minWidth: 15),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.10,
                            width: size.width * 0.10,
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 10),
                            decoration: BoxDecoration(
                              color: ColorResources.backgroundDatePickerColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor
                                      .withOpacity(0.3),
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.calendar_month_rounded,
                                size: 23, color: ColorResources.buttonColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    // Occupation
                    GestureDetector(
                      onTap: () {
                        selectOccupationBottomSheet();
                      },
                      child: AppTextFieldWidget(
                        controller: controller.occupation,
                        isShowCountryPicker: false,
                        labelText: LocalStrings.occupation,
                        isEnable: false,
                        boxConstraints: const BoxConstraints(minWidth: 15),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.10,
                            width: size.width * 0.10,
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 10),
                            decoration: BoxDecoration(
                              color: ColorResources.backgroundDatePickerColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor
                                      .withOpacity(0.3),
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.keyboard_arrow_down_rounded,
                                size: 30, color: ColorResources.buttonColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    // Spouse Birthday
                    GestureDetector(
                      onTap: () {
                        controller.datePicker(LocalStrings.spousBirthday);
                      },
                      child: AppTextFieldWidget(
                        controller: controller.spouseBirthday,
                        isShowCountryPicker: false,
                        labelText: LocalStrings.spousBirthday,
                        isEnable: false,
                        boxConstraints: const BoxConstraints(minWidth: 15),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.10,
                            width: size.width * 0.10,
                            padding: EdgeInsets.zero,
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, right: 10),
                            decoration: BoxDecoration(
                              color: ColorResources.backgroundDatePickerColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor
                                      .withOpacity(0.3),
                                  offset: const Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.calendar_month_rounded,
                                size: 23, color: ColorResources.buttonColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space35),
                    // Shipping Address Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        LocalStrings.shippingAddress,
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.buttonColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    // Street and House Number
                    AppTextFieldWidget(
                      controller: controller.streetAndHouseNumber,
                      isShowCountryPicker: false,
                      labelText: 'Street and House Number',
                    ),
                    const SizedBox(height: Dimensions.space20),
                    // Additional Info
                    AppTextFieldWidget(
                      controller: controller.additionalInfo,
                      isShowCountryPicker: false,
                      labelText: 'Additional Info (Optional)',
                    ),
                    const SizedBox(height: Dimensions.space20),
                    // City
                    AppTextFieldWidget(
                      controller: controller.city,
                      isShowCountryPicker: false,
                      labelText: 'City',
                    ),
                    const SizedBox(height: Dimensions.space20),
                    // State
                    AppTextFieldWidget(
                      controller: controller.state,
                      isShowCountryPicker: false,
                      labelText: 'State',
                    ),
                    const SizedBox(height: Dimensions.space25),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: LocalStrings.byClicking,
                            style: mediumDefault.copyWith(
                                color: ColorResources.buttonColor),
                          ),
                          TextSpan(
                            text: LocalStrings.tAndC,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                /// Analysis log edit profile Term & Condition
                                AppAnalytics().actionTriggerLogs(
                                    eventName: LocalStrings
                                        .editProfileTermConditionView,
                                    index: 15);
                              },
                            style: mediumDefault.copyWith(
                                color: ColorResources.offerColor),
                          ),
                          TextSpan(
                            text: " ${LocalStrings.and} ",
                            style: mediumDefault.copyWith(
                                color: ColorResources.buttonColor),
                          ),
                          TextSpan(
                            text: "${LocalStrings.privacyPolicy}.",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                /// Analysis log edit profile privacy policy.
                                AppAnalytics().actionTriggerLogs(
                                    eventName: LocalStrings
                                        .editProfilePrivacyPolicyView,
                                    index: 15);
                              },
                            style: mediumDefault.copyWith(
                                color: ColorResources.offerColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.090),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

// Email id verify open bottomSheet
  verifyEmailBottomSheet() {
    final size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      backgroundColor: ColorResources.cardBgColor,
      isScrollControlled: true,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.emailIdRadius),
            topLeft: Radius.circular(Dimensions.emailIdRadius)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      context: context,
      builder: (context) {
        return GetBuilder(
            init: EditProfileController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorResources.cardBgColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.emailIdRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: Dimensions.space30),
                            Container(
                              height: 5,
                              width: 45,
                              color:
                                  ColorResources.offerTenColor.withOpacity(0.1),
                            ),
                            const SizedBox(height: Dimensions.space55),
                            Container(
                              height: size.height * 0.100,
                              width: size.width * 0.20,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.emailIdRadius),
                                gradient: const LinearGradient(
                                  colors: [
                                    ColorResources.lightGreenColour,
                                    ColorResources.offerNineColor,
                                  ],
                                  stops: [0.2, 0.8],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Image.asset(
                                MyImages.securityImage,
                                color: ColorResources.whiteColor,
                              ),
                            ),
                            const SizedBox(height: Dimensions.space25),
                            Text(
                              controller.email.text,
                              textAlign: TextAlign.center,
                              style: boldMediumLarge.copyWith(
                                  color: ColorResources.buttonColor),
                            ),
                            const SizedBox(height: Dimensions.space15),
                            Text(
                              LocalStrings.enterOtp,
                              textAlign: TextAlign.center,
                              style: regularLarge.copyWith(
                                  color: ColorResources.buttonColor),
                            ),
                            const SizedBox(height: Dimensions.space40),
                            // Otp field
                            Align(
                              alignment: Alignment.center,
                              child: OtpTextField(
                                fieldHeight: size.height * 0.065,
                                fieldWidth: size.width * 0.14,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.offersCardRadius)),
                                    borderSide: BorderSide(
                                        color: ColorResources.borderColor,
                                        width: 1),
                                  ),
                                ),
                                alignment: Alignment.center,
                                disabledBorderColor: ColorResources.borderColor,
                                enabledBorderColor: ColorResources.borderColor,
                                focusedBorderColor: ColorResources.borderColor,
                                margin: const EdgeInsets.only(right: 15),
                                numberOfFields: 4,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        Dimensions.offersCardRadius)),
                                borderColor: ColorResources.borderColor,
                                keyboardType: TextInputType.number,
                                textStyle: boldLarge.copyWith(
                                    color: ColorResources.buttonColor),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                contentPadding: EdgeInsets.zero,
                                //set to true to show as box or false to show as dash
                                showFieldAsBox: true,
                                //runs when a code is typed in
                                onCodeChanged: (String code) {
                                  //handle validation or checks here
                                },
                              ),
                            ),
                            const SizedBox(height: Dimensions.space30),
                            controller.startTime == 0
                                ? GestureDetector(
                                    onTap: () {
                                      controller.startTimer();
                                    },
                                    child: Text(
                                      LocalStrings.resendText,
                                      textAlign: TextAlign.center,
                                      style: semiBoldSmall.copyWith(
                                          color: ColorResources.buttonColor),
                                    ),
                                  )
                                : RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: LocalStrings.resend,
                                          style: semiBoldSmall.copyWith(
                                              color:
                                                  ColorResources.buttonColor),
                                        ),
                                        TextSpan(
                                          text: "${controller.startTime} ",
                                          style: semiBoldSmall.copyWith(
                                              color:
                                                  ColorResources.buttonColor),
                                        ),
                                        TextSpan(
                                          text: LocalStrings.secs,
                                          style: semiBoldSmall.copyWith(
                                              color:
                                                  ColorResources.buttonColor),
                                        ),
                                      ],
                                    )),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.space60),
                      GestureDetector(
                        onTap: () {
                          /// Analysis log edit profile verify email click
                          AppAnalytics().actionTriggerLogs(
                              eventName: LocalStrings.editProfileVerifyEmail,
                              index: 15);
                        },
                        child: Container(
                            height: size.height * 0.080,
                            decoration: const BoxDecoration(
                              color: ColorResources.buttonColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorResources.borderColor,
                                  offset: Offset(0, 1),
                                  // Position the shadow below the AppBar
                                  blurRadius:
                                      2, // Adjust the blur radius as needed
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                LocalStrings.verify,
                                style: mediumMediumLarge.copyWith(
                                  color: ColorResources.whiteColor,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  // Selected occupation
  selectOccupationBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: ColorResources.cardBgColor,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.bottomSheetRadius),
            topLeft: Radius.circular(Dimensions.bottomSheetRadius)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorResources.cardBgColor,
            borderRadius: BorderRadius.circular(Dimensions.bottomSheetRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: ColorResources.offerThirdTextColor.withOpacity(0.1),
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Container(
                      height: 5,
                      width: 40,
                      color: ColorResources.whiteColor,
                    ),
                    const SizedBox(height: Dimensions.space25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalStrings.selectOccupation,
                          style: boldDefault.copyWith(
                              color: ColorResources.buttonColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space20),
              GetBuilder(
                  init: EditProfileController(),
                  builder: (controller) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.selectOccupationLst.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.sortCurrentIndex(index);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Text(
                                            controller
                                                .selectOccupationLst[index],
                                            style: boldDefault.copyWith(
                                              color: controller
                                                          .currentIndex.value ==
                                                      index
                                                  ? ColorResources
                                                      .sortSelectedColor
                                                  : ColorResources.buttonColor,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorResources
                                                        .buttonColor,
                                                    width: 2),
                                                shape: BoxShape.circle),
                                            child: controller
                                                        .currentIndex.value ==
                                                    index
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .buttonColor,
                                                        border: Border.all(
                                                            color: ColorResources
                                                                .buttonColor,
                                                            width: 2),
                                                        shape: BoxShape.circle),
                                                  )
                                                : const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space12),
                                Divider(
                                  height: 10,
                                  color: ColorResources.offerThirdTextColor
                                      .withOpacity(0.1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
