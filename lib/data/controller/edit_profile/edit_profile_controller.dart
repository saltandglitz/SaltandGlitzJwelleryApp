import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandGlitz/view/components/common_message_show.dart';

import '../../../core/utils/local_strings.dart';
import '../../../core/utils/validation.dart';

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
    firstName.text = "Xyz";
    lastName.text = "Kureshi";
    mobileNumber.text = "1234657891";
    email.text = "xyz@gmail.com";
    pinCode.text = "394101";
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

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  // Is validation
  isValidation() {
    if (CommonValidation().isValidationEmpty(firstName.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterFirstName);
    } else if (CommonValidation().isValidationEmpty(pinCode.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterPinCode);
    } else if (selectedValue == -1) {
      showSnackBar(context: Get.context!, message: LocalStrings.selectGender);
    } else if (CommonValidation().isValidationEmpty(birthDay.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterBirthday);
    } else {
      showToast(
          message: LocalStrings.saveChangesMessage, context: Get.context!);
    }
  }
}
