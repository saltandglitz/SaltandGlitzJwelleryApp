import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;
import 'package:saltandglitz/view/components/common_message_show.dart';

import '../../../analytics/app_analytics.dart';
import '../../../api_repository/dio_client.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/validation.dart';
import '../../../local_storage/pref_manager.dart';
import '../../model/user_profile_model.dart';
import '../my_account/my_account_controller.dart';

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
  TextEditingController streetAndHouseNumber = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  int selectedValue = -1;
  Timer? timer;
  var currentIndex = (-1).obs;
  bool isLoading = false;

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
    super.onInit();
    fetchUserProfile();
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
      // Call update profile API
      updateUserProfile();
    }
  }

  /// Fetch user profile from API
  Future<void> fetchUserProfile() async {
    try {
      String? token = PrefManager.getString('token');
      if (token == null || token.isEmpty) {
        showLoginDataTexTextField();
        return;
      }

      Response response = await Dioclient.get("/api/users/profile");

      if (response.statusCode == 200) {
        // Parse response using UserProfile model
        UserProfile userProfile = UserProfile.fromJson(response.data);

        // Update controllers with API data
        firstName.text = userProfile.firstName ?? '';
        lastName.text = userProfile.lastName ?? '';
        email.text = userProfile.email ?? '';
        mobileNumber.text = userProfile.mobileNumber ?? '';
        userSaltCash.text = userProfile.userSaltCash?.toString() ?? '0';
        pinCode.text = userProfile.pincode ?? '';
        occupation.text = userProfile.occupation ?? '';

        // Handle dates with proper formatting
        if (userProfile.dateOfBirth != null) {
          birthDay.text = userProfile.dateOfBirth!.toString().split(" ")[0];
        }
        if (userProfile.aniversaryDate != null) {
          anniversary.text =
              userProfile.aniversaryDate!.toString().split(" ")[0];
        }

        // Handle shipping address
        if (userProfile.shippingAddress != null) {
          var address = userProfile.shippingAddress!;
          streetAndHouseNumber.text = address.streetAndHouseNumber ?? '';
          additionalInfo.text = address.additionalInfo ?? '';
          city.text = address.city ?? '';
          state.text = address.state ?? '';
        }

        // Update gender selection
        String gender = userProfile.gender ?? '';
        if (gender == "Female") {
          selectionGender(1);
        } else if (gender == "Male") {
          selectionGender(2);
        } else {
          selectionGender(0);
        }

        // Update local storage with fresh data
        _updateLocalStorage(userProfile);

        // Update profile completion status
        if (Get.isRegistered<MyAccountController>()) {
          final myAccountController = Get.find<MyAccountController>();
          myAccountController.isProfileCompleted.value =
              userProfile.profileCompleted ?? false;
          myAccountController.profileCompleteProgress =
              userProfile.getProfileCompletionPercentage();
          myAccountController.update();
        }

        update();
      } else {
        print("Failed to fetch profile: ${response.statusCode}");
        showLoginDataTexTextField();
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      if (e.toString().contains('Unauthorized')) {
        showSnackBar(
          context: Get.context!,
          title: 'Session Expired',
          message: 'Please log in again',
          icon: Icons.error,
          iconColor: Colors.red,
        );
      }
      showLoginDataTexTextField();
    }
  }

  /// Helper method to update local storage from UserProfile model
  void _updateLocalStorage(UserProfile userProfile) {
    PrefManager.setString('firstName', userProfile.firstName ?? '');
    PrefManager.setString('lastName', userProfile.lastName ?? '');
    PrefManager.setString('email', userProfile.email ?? '');
    PrefManager.setString('phoneNumber', userProfile.mobileNumber ?? '');
    PrefManager.setString(
        'userSaltCash', userProfile.userSaltCash?.toString() ?? '0');
    PrefManager.setString('pincode', userProfile.pincode ?? '');
    PrefManager.setString('occupation', userProfile.occupation ?? '');
    PrefManager.setString('gender', userProfile.gender ?? '');
    PrefManager.setString('profileCompleted',
        userProfile.profileCompleted?.toString() ?? 'false');

    if (userProfile.dateOfBirth != null) {
      PrefManager.setString(
          'dateOfBirth', userProfile.dateOfBirth!.toString().split(" ")[0]);
    }
    if (userProfile.aniversaryDate != null) {
      PrefManager.setString('aniversaryDate',
          userProfile.aniversaryDate!.toString().split(" ")[0]);
    }

    // Update shipping address in local storage
    if (userProfile.shippingAddress != null) {
      var address = userProfile.shippingAddress!;
      PrefManager.setString(
          'streetAndHouseNumber', address.streetAndHouseNumber ?? '');
      PrefManager.setString('additionalInfo', address.additionalInfo ?? '');
      PrefManager.setString('city', address.city ?? '');
      PrefManager.setString('state', address.state ?? '');
    }
  }

  /// Local storage stored data show in textField
  showLoginDataTexTextField() {
    firstName.text = PrefManager.getString('firstName') ?? '';
    lastName.text = PrefManager.getString('lastName') ?? '';
    email.text = PrefManager.getString('email') ?? '';
    mobileNumber.text = PrefManager.getString('phoneNumber') ?? '';
    userSaltCash.text = PrefManager.getString('userSaltCash') ?? '0';
    pinCode.text = PrefManager.getString('pincode') ?? '';
    occupation.text = PrefManager.getString('occupation') ?? '';

    // Load dates
    String? dateOfBirthStr = PrefManager.getString('dateOfBirth');
    if (dateOfBirthStr != null && dateOfBirthStr.isNotEmpty) {
      birthDay.text = dateOfBirthStr;
    }

    String? aniversaryDateStr = PrefManager.getString('aniversaryDate');
    if (aniversaryDateStr != null && aniversaryDateStr.isNotEmpty) {
      anniversary.text = aniversaryDateStr;
    }

    // Load shipping address
    streetAndHouseNumber.text =
        PrefManager.getString('streetAndHouseNumber') ?? '';
    additionalInfo.text = PrefManager.getString('additionalInfo') ?? '';
    city.text = PrefManager.getString('city') ?? '';
    state.text = PrefManager.getString('state') ?? '';

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

  //Todo: Update user profile API method
  Future<void> updateUserProfile() async {
    try {
      isLoading = true;
      update();

      String? userId = PrefManager.getString('userId');
      if (userId == null || userId.isEmpty) {
        showSnackBar(
          context: Get.context!,
          title: 'Error',
          message: 'User ID not found',
          icon: Icons.error,
          iconColor: Colors.red,
        );
        return;
      }

      Map<String, dynamic> params = {
        "firstName": firstName.text,
        "lastName": lastName.text,
        "gender": selectedValue == 1
            ? "Female"
            : selectedValue == 2
                ? "Male"
                : "Other",
        "mobileNumber": mobileNumber.text,
        "pincode": pinCode.text,
        "occupation": occupation.text,
      };

      // Add dates if provided
      if (birthDay.text.isNotEmpty) {
        params["dateOfBirth"] = birthDay.text;
      }
      if (anniversary.text.isNotEmpty) {
        params["aniversaryDate"] = anniversary.text;
      }

      // Add shipping address if any field is filled
      if (streetAndHouseNumber.text.isNotEmpty ||
          city.text.isNotEmpty ||
          state.text.isNotEmpty) {
        params["shippingAddress"] = {
          "streetAndHouseNumber": streetAndHouseNumber.text,
          "additionalInfo": additionalInfo.text,
          "city": city.text,
          "state": state.text,
        };
      }

      Response response = await Dioclient.put(
        "/users/userEdit/$userId",
        data: params,
      );

      if (response.statusCode == 200) {
        // Update local storage with new data manually
        _updateLocalStorageManually();

        // Mark profile as completed if all essential fields are filled
        if (_isProfileEssentialFieldsComplete()) {
          await markProfileCompleted();
        }

        showToast(
          message: LocalStrings.saveChangesMessage,
          context: Get.context!,
        );

        // Navigate back or refresh the data
        Get.back();
      } else {
        String errorMessage = 'Failed to update profile';
        if (response.data != null && response.data['message'] != null) {
          errorMessage = response.data['message'];
        }
        showSnackBar(
          context: Get.context!,
          title: 'Error',
          message: errorMessage,
          icon: Icons.error,
          iconColor: Colors.red,
        );
      }
    } catch (e) {
      String errorMessage = 'Error updating profile';
      if (e.toString().contains('Unauthorized')) {
        errorMessage = 'Session expired. Please log in again.';
        // Optionally redirect to login screen
        // Get.offAllNamed(RouteHelper.loginScreen);
      } else {
        errorMessage = 'Error updating profile: ${e.toString()}';
      }

      showSnackBar(
        context: Get.context!,
        title: 'Error',
        message: errorMessage,
        icon: Icons.error,
        iconColor: Colors.red,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  //Todo: Mark profile as completed
  Future<void> markProfileCompleted() async {
    try {
      String? token = PrefManager.getString('token');
      if (token == null || token.isEmpty) return;

      Response response = await Dioclient.put(
        "/users/markProfileCompleted",
      );

      if (response.statusCode == 200) {
        PrefManager.setString('profileCompleted', 'true');

        // Update MyAccountController if available
        if (Get.isRegistered<MyAccountController>()) {
          final myAccountController = Get.find<MyAccountController>();
          myAccountController.isProfileCompleted.value = true;
          myAccountController.profileCompleteProgress = 1.0;
          myAccountController.update();
        }

        print("Profile marked as completed successfully");
      } else {
        print("Failed to mark profile as completed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error marking profile as completed: $e");
    }
  }

  /// Helper method to update local storage manually when API doesn't return user object
  void _updateLocalStorageManually() {
    PrefManager.setString('firstName', firstName.text);
    PrefManager.setString('lastName', lastName.text);
    PrefManager.setString(
        'gender',
        selectedValue == 1
            ? "Female"
            : selectedValue == 2
                ? "Male"
                : "Other");
    PrefManager.setString('pincode', pinCode.text);
    PrefManager.setString('occupation', occupation.text);

    if (birthDay.text.isNotEmpty) {
      PrefManager.setString('dateOfBirth', birthDay.text);
    }
    if (anniversary.text.isNotEmpty) {
      PrefManager.setString('aniversaryDate', anniversary.text);
    }

    // Update shipping address in local storage
    PrefManager.setString('streetAndHouseNumber', streetAndHouseNumber.text);
    PrefManager.setString('additionalInfo', additionalInfo.text);
    PrefManager.setString('city', city.text);
    PrefManager.setString('state', state.text);
  }

  /// Check if essential profile fields are complete
  bool _isProfileEssentialFieldsComplete() {
    return firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        pinCode.text.isNotEmpty &&
        birthDay.text.isNotEmpty &&
        selectedValue != -1;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
