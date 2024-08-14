class CommonValidation{
  /// <<< To check email valid or not --------- >>>
  bool emailValidator(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  /// <<< To check phone valid or not --------- >>>
  bool phoneValidator(String contact) {
    String p = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check password valid or not --------- >>>
  bool passwordValidator(String contact) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(contact)) {
      return true;
    }
    return false;
  }

  /// <<< To check data, string, list, object are empty or not --------- >>>
  bool isValidationEmpty(String? val) {
    if (val == null || val.isEmpty || val == "null" || val == "" || val == "NULL") {
      return true;
    } else {
      return false;
    }
  }
}