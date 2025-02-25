import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../api_repository/api_function.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/color_resources.dart';
import '../../../core/utils/local_strings.dart';
import '../../../core/utils/validation.dart';
import '../../../local_storage/pref_manager.dart';
import '../../../view/components/common_message_show.dart';
import '../bottom_bar/bottom_bar_controller.dart';
import '../my_account/my_account_controller.dart';

class CreateAccountController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final bottomBarController =
      Get.put<BottomBarController>(BottomBarController());
  final Color validColor = ColorResources.videoCallColor;
  final Color invalidColor = ColorResources.notValidateColor;
  bool hasEightChars = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSymbol = false;
  bool hasNumber = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool optCheck = true;
  bool isLoading = false;
  bool isFacebookLoading = false;
  int selectedValue = 3;
  String? userName;
  var user = Rx<User?>(null);
  RxBool isEnableNetwork = false.obs;
  RxBool isCreateUserAccount = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  enableNetworkHideLoader() {
    if (isEnableNetwork.value == false) {
      isEnableNetwork.value = true;
    }
    update();
  }

  disableNetworkLoaderByDefault() {
    if (isEnableNetwork.value == true) {
      isEnableNetwork.value = false;
    }
    update();
  }

  void validatePassword(String value) {
    hasEightChars = value.length >= 8;
    hasUppercase = value.contains(RegExp(r'[A-Z]'));
    hasLowercase = value.contains(RegExp(r'[a-z]'));
    hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasNumber = value.contains(RegExp(r'[0-9]'));
    update();
  }

// Show password method
  isShowPassword() {
    showPassword = !showPassword;
    update();
  }

// Show confirm password method
  isShoConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  selectionGender(value) {
    selectedValue = value;
    update();
  }

  //Todo: This function used when api called passed index wise Female, Male ect...
  String genderSelectionName() {
    if (selectedValue == 1) {
      return "Female";
    } else if (selectedValue == 2) {
      return "Male";
    } else {
      return "Other";
    }
  }

// Check box selection by default true
  isOptCheck() {
    optCheck = !optCheck;
    update();
  }

// Checked validation after move signup
  isValidation(
      {String? firstName,
      String? lastName,
      String? mobileNumber,
      String? email,
      String? password,
      String? gender,
      BuildContext? context}) {
    if (CommonValidation().isValidationEmpty(mobileController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterMobileNumber);
    } else if (!CommonValidation().phoneValidator(mobileController.text) ||
        mobileController.text.length <= 9) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterValidNumber);
    } else if (CommonValidation().isValidationEmpty(emailController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterEmailText);
    } else if (!CommonValidation().emailValidator(emailController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterValidEmail);
    } else if (CommonValidation().isValidationEmpty(firstNameController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterFirstName);
    } else if (CommonValidation().isValidationEmpty(lastNameController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterLastName);
    } else if (CommonValidation().isValidationEmpty(passwordController.text)) {
      showSnackBar(context: Get.context!, message: LocalStrings.enterPassword);
    } else if (hasEightChars == false ||
        hasUppercase == false ||
        hasLowercase == false ||
        hasSymbol == false ||
        hasNumber == false) {
      showSnackBar(context: Get.context!, message: LocalStrings.validPassword);
    } else if (CommonValidation()
        .isValidationEmpty(confirmPasswordController.text)) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.enterConfirmPassword);
    } else if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(
          context: Get.context!, message: LocalStrings.validConfirmPassword);
    } else {
      //Todo : New user create account
      createNewUserAccountApiMethod(
          firstName: firstName,
          lastName: lastName,
          mobileNumber: mobileNumber,
          email: email,
          password: password,
          gender: gender,
          context: context);

      /// Analysis create new account user
      // AppAnalytics().actionTriggerCreateNewAccount(
      //     eventName: LocalStrings.createNewAccountButtonClick,
      //     mobileNo: mobileController.text,
      //     email: emailController.text,
      //     firstName: firstNameController.text,
      //     lastName: lastNameController.text,
      //     genderSelection: selectedValue == 1
      //         ? LocalStrings.female
      //         : selectedValue == 2
      //             ? LocalStrings.male
      //             : LocalStrings.notSpecify,
      //     whatsappSupport: optCheck == true ? 'Yes' : 'No',
      //     index: 9);
      // // Navigation after signup
      // showToast(
      //     message: LocalStrings.signupSuccessfully, context: Get.context!);
    }
    update();
  }

  /// Google sign in method
  Future<User?> signInWithGoogle({String? screenType}) async {
    isLoading = true;
    update();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    /// Check signIn account validate or not if valid continue process other wise closed this method
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(authCredential);
        user = userCredential.user;

        if (user != null) {
          /// Stored displayName & email user particular data
          String displayName = user.displayName ?? '';
          String email = user.email ?? '';

          /// Get current user id token if want send api token this token used and you want used any get api response used this token google authentication time
          final currentUserIdToken = auth.currentUser?.getIdToken();

          /// Display name show First name & Last name wise divide
          List<String> nameParameters = displayName.split(" ");
          String firstName = nameParameters.isNotEmpty ? nameParameters[0] : '';
          String lastName = nameParameters.length > 1
              ? nameParameters.sublist(1).join(' ')
              : '';
          userName = firstName;

          /// Phone number
          String phoneNumber = user.phoneNumber ?? '';

          /// Stored data in device Google login or not,First name, Last name & email
          PrefManager.setString('isLogin', 'yes');
          PrefManager.setString('firstName', firstName);
          PrefManager.setString('lastName', lastName);
          PrefManager.setString('email', email);
          PrefManager.setString('phoneNumber', phoneNumber);
          PrefManager.setString('loginType', 'Google');

          //Todo : Off all navigation and move My account screen
          Get.offAllNamed(RouteHelper.bottomBarScreen);
          bottomBarController.selectedIndex = 2.obs;

          /// Show login message
          showToast(
              message: LocalStrings.loginSuccessfully, context: Get.context!);
        } else {
          Get.snackbar('Login Failed', 'Something went wrong');
        }
      } catch (e) {
        Get.snackbar('Login Failed', "$e");
      } finally {
        isLoading = false;
        update();
      }
    }
    return user;
  }

  /// Set if api called otherwise google authentication time process complete after hide loader.
  isLoaderOffMethod() {
    isLoading = false;
    update();
  }

  /// Set if api called otherwise facebook authentication time process complete after hide loader.
  isLoaderOffFacebookMethod() {
    isFacebookLoading = false;
    update();
  }

  /// Sign out google method
  Future<void> signOutWithGoogle() async {
    isLoading = true;
    update();
    final bottomBarController =
        Get.put<BottomBarController>(BottomBarController());
    final myAccountController =
        Get.put<MyAccountController>(MyAccountController());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      /// Checked is web or not after sign Out google functionality
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await googleSignIn.signOut();

      /// Remove device local data in device stored isLogin ,First name ,Last name ,Email , Phone number
      PrefManager.removeString('isLogin');
      PrefManager.removeString('firstName');
      PrefManager.removeString('lastName');
      PrefManager.removeString('email');
      PrefManager.removeString('phoneNumber');
      PrefManager.removeString('loginType');

      // myAccountController.loginKey = '';
      bottomBarController.selectedIndex.value = 0;
      bottomBarController.update();
    } catch (e) {
      Get.snackbar('Login Failed', "$e");
    } finally {
      isLoading = false;
      update();
    }
  }

  //Todo : Facebook sign in method
  Future<void> signInWithFacebook({String? screenType}) async {
    try {
      isFacebookLoading = true;
      update();
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        await FirebaseAuth.instance.signInWithCredential(credential);
        final userData = await FacebookAuth.i.getUserData(
          fields: "name,email,picture.width(200),birthday,friends,gender,link",
        );

        /// Name divided First Name & Last Name
        List<String> nameParameter = userData['name'].toString().split(" ");
        String firstName = nameParameter.isNotEmpty ? nameParameter[0] : '';
        String lastName =
            nameParameter.length > 1 ? nameParameter.sublist(1).join(' ') : '';

        /// Email data show
        String email = userData['email'];

        /// Phone number facebook not get so always send blank
        String phoneNumber = '';

        /// Assign first name userName to show login after firstName
        userName = firstName;

        /// Stored data in device Google login or not,First name, Last name & email
        PrefManager.setString('isLogin', 'yes');
        PrefManager.setString('firstName', firstName);
        PrefManager.setString('lastName', lastName);
        PrefManager.setString('email', email);
        PrefManager.setString('phoneNumber', phoneNumber);
        PrefManager.setString('loginType', 'FaceBook');

        /// New account create time to back
        //Todo : Off all navigation and move My account screen
        Get.offAllNamed(RouteHelper.bottomBarScreen);
        bottomBarController.selectedIndex = 2.obs;

        /// Show login message
        showToast(
            message: LocalStrings.loginSuccessfully, context: Get.context!);

        /// String form access token to send api data
        // print("Access_token_string : ${accessToken.tokenString}");
      } else {
        Get.snackbar('Login Failed', result.message ?? 'An error occurred');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isFacebookLoading = false;
      update();
    }
  }

  //Todo : Sign out facebook method
  Future<void> signOutWithFacebook() async {
    isLoading = true;
    update();
    final bottomBarController =
        Get.put<BottomBarController>(BottomBarController());
    final myAccountController =
        Get.put<MyAccountController>(MyAccountController());
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Sign out from Facebook
      await FacebookAuth.instance.logOut();

      /// Remove device local data in device stored isLogin ,First name ,Last name ,Email , Phone number
      PrefManager.removeString('isLogin');
      PrefManager.removeString('firstName');
      PrefManager.removeString('lastName');
      PrefManager.removeString('email');
      PrefManager.removeString('phoneNumber');
      PrefManager.removeString('loginType');

      //Todo : Off all navigation and move My account screen
      Get.offAllNamed(RouteHelper.bottomBarScreen);
      bottomBarController.selectedIndex = 2.obs;
      bottomBarController.update();
    } catch (e) {
      Get.snackbar('Sign Out Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

//Todo : Create new user account api method
  Future createNewUserAccountApiMethod(
      {String? firstName,
      String? lastName,
      String? mobileNumber,
      String? email,
      String? password,
      String? gender,
      BuildContext? context}) async {
    try {
      final bottomBarController =
          Get.put<BottomBarController>(BottomBarController());
      isCreateUserAccount.value = true;
      Map<String, dynamic> params = {
        'firstName': firstName,
        'lastName': lastName,
        'mobileNumber': mobileNumber,
        'email': email,
        'password': password,
        'gender': gender,
      };
      print("Create_account : ${params}");
      Response response = await APIFunction().apiCall(
          apiName: LocalStrings.registerApi,
          context: context,
          params: params,
          isLoading: false);
      if (response.statusCode == 201) {
        // showSnackBar(context: context, message: response.data);

        /// Stored data in device Google login or not,First name, Last name & email
        PrefManager.setString('isLogin', 'yes');
        PrefManager.setString('firstName', firstName ?? '');
        PrefManager.setString('lastName', lastName ?? '');
        PrefManager.setString('email', email ?? '');
        PrefManager.setString('phoneNumber', mobileNumber ?? '');
        PrefManager.setString('gender', gender ?? '');
        PrefManager.setString('token', response.data['user']['token'] ?? '');
        PrefManager.setString('user_id', response.data['user']['_id'] ?? '');
        //Todo : Off all navigation and move My account screen
        Get.offAllNamed(RouteHelper.bottomBarScreen);
        bottomBarController.selectedIndex = 2.obs;
        print("TOKEN : ${PrefManager.getString("token")}");
        showToast(context: Get.context!, message: response.data['message']);
      } else if (response.statusCode == 400) {
        showSnackBar(context: Get.context!, message: "User already exists");
      } else {
        // Handle any other errors
        showSnackBar(context: Get.context!, message: response.data['message']);
      }
      printAction("User_Create_Account : ${response.data['message']}");
    } catch (e) {
      printActionError("Create_User_Account_Error : $e");
    } finally {
      isCreateUserAccount.value = false;
      update();
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
