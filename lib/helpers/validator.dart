import '../const.dart';

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyEmailField;
    }
    // Regex for email validation
    final regExp = RegExp(emailRegex);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return invalidEmailField;
  }
}

class PhoneNumberValidator {
  static String? validate(String value) {
    print(value);
    if (value.isEmpty) {
      return emptyTextField;
    }
    if (value.length < 10) {
      return PHONE_NUMBER_LENGTH_ERROR;
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyPasswordField;
    }

    if (value.length < 8) {
      return passwordLengthError;
    }
    final regExp = RegExp(digitRegex);

    if (!regExp.hasMatch(value)) {
      return passwordDigitErr;
    }

    final regSymbolExp = RegExp(symbolRegex);

    if (!regSymbolExp.hasMatch(value)) {
      return passwordSymbolErr;
    }

    final regUpperExp = RegExp(upperCaseRegex);

    if (!regUpperExp.hasMatch(value)) {
      return passwordUppercaseErr;
    }

    return null;
  }
}

class UsernameValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyUsernameField;
    }

    if (value.length < 5) {
      return usernameLengthError;
    }

    return null;
  }
}

class FieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    return null;
  }
}





