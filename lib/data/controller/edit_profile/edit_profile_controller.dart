import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/validation.dart';
import '../../../local_storage/pref_manager.dart';

class EditProfileController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController anniversary = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController spouseBirthday = TextEditingController();
  TextEditingController verifyEmailFirst = TextEditingController();
  TextEditingController verifyEmailSecond = TextEditingController();
  TextEditingController verifyEmailThird = TextEditingController();
  TextEditingController verifyEmailFor = TextEditingController();
  TextEditingController userSaltCash = TextEditingController();
  int selectedValue = -1;
  Timer? timer;
  var currentIndex = (-1).obs;

  var startTime;
  List selectOccupationLst = [
    LocalStrings.engineer,
    LocalStrings.consultant,
    LocalStrings.charted,
    LocalStrings.marketing,
    LocalStrings.teacher,
    LocalStrings.entrepreneur,
    LocalStrings.designer,
    LocalStrings.homemaker,
    LocalStrings.itProfessional,
    LocalStrings.others,
    LocalStrings.doctor,
    LocalStrings.lawyer,
    LocalStrings.designerStylist,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showLoginDataTexTextField();
  }

  selectionGender(value) {
    selectedValue = value;
    update();
  }

  // Date pick Birthday , Anniversary
  datePicker(String event) async {
    DateTime now = DateTime.now();
    DateTime? datePick = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(1900),
      lastDate: now,
      initialDate: now,
    );
    if (datePick != null) {
      if (event == LocalStrings.birthday) {
        // BirthDay text filed selection
        birthDay.text = datePick.toString().split(" ")[0];
      } else if (event == LocalStrings.anniversary) {
        // Anniversary text filed selection
        anniversary.text = datePick.toString().split(" ")[0];
      } else {
        // Spouse Birthday text filed selection
        spouseBirthday.text = datePick.toString().split(" ")[0];
      }
    }
    update();
  }

  // Start timer to sent otp
  startTimer() {
    startTime = 12;
    const sec = Duration(seconds: 1);
    timer = Timer.periodic(sec, (Timer timer) {
      if (startTime == 0) {
        timer.cancel();
      } else {
        startTime--;
      }
      update();
    });
    showToast(context: Get.context!, message: LocalStrings.otpSent);
  }

  // Sort selecting item
  sortCurrentIndex(int index) {
    currentIndex.value = index;
    occupation.text = selectOccupationLst[index];
    Get.back();
    update();
  }

  /// Is validation
  isValidation() {
    if (CommonValidation().isValidationEmpty(firstName.text)) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.enterFirstName,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else if (CommonValidation().isValidationEmpty(pinCode.text)) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.enterPinCode,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else if (selectedValue == -1) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.selectGender,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else if (CommonValidation().isValidationEmpty(birthDay.text)) {
      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: LocalStrings.enterBirthday,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } else {
      /// Analysis users edit profile
      AppAnalytics().actionEditProfileAccount(
        eventName: LocalStrings.editProfileSaveChanges,
        firstName: firstName.text,
        lastName: lastName.text,
        mobileNo: mobileNumber.text,
        userSaltCash: int.tryParse(userSaltCash.text) ?? 0,
        email: email.text,
        pinCode: pinCode.text,
        genderSelection: selectedValue == 1
            ? LocalStrings.female
            : selectedValue == 2
                ? LocalStrings.male
                : LocalStrings.other,
        birthday: birthDay.text,
        anniversary: anniversary.text,
        occupation: occupation.text,
        spousBirthday: spouseBirthday.text,
        index: 15,
      );
      showToast(
          message: LocalStrings.saveChangesMessage, context: Get.context!);
    }
  }

  /// Local storage stored data show in textField
  showLoginDataTexTextField() {
    firstName.text = PrefManager.getString('firstName') ?? '';
    lastName.text = PrefManager.getString('lastName') ?? '';
    email.text = PrefManager.getString('email') ?? '';
    mobileNumber.text = PrefManager.getString('phoneNumber') ?? '';
    userSaltCash.text = PrefManager.getString('userSaltCash') ?? '0';

    genderApiSelection();
    update();
  }

  genderApiSelection() {
    String gender = PrefManager.getString('gender') ?? '';
    if (gender == "Female") {
      selectionGender(1);
    } else if (gender == "Male") {
      selectionGender(2);
    } else {
      selectionGender(0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
}
