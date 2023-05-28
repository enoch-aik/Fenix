import 'dart:io';

import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double BODY_PADDING = 20.0;
const double TOP_PADDING = 35.0;
const double DIALOG_RADIUS = 30.0;
const double MODAL_RADIUS = 20.0;
const double MID_RADIUS = 10.0;
const double BUTTON_RADIUS = 5.0;
const double INPUT_FIELD_RADIUS = 3.0;

double height() => Get.height;
double width() => Get.width;

LinearGradient appBarGradient = gradient(
  const Color(0xFF691232),
  const Color(0xFF1770A2),
);

smallHSpace() => const SizedBox(width: 20);
tinyHSpace() => const SizedBox(width: 10);
smallSpace() => const SizedBox(height: 20);
tinySpace() => const SizedBox(height: 10);
tiny15Space() => const SizedBox(height: 15);
tiny5Space() => const SizedBox(height: 5);
tinyH5Space() => const SizedBox(width: 5);
mediumSpace() => const SizedBox(height: 30);
mediumHSpace() => const SizedBox(width: 30);

verticalSpace(factor) => SizedBox(height: height() * factor);
horizontalSpace(factor) => SizedBox(width: width() * factor);


const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
const String passwordLengthError = 'Password length must be greater than 6';
const String emptyUsernameField = 'Name  cannot be empty';
const String usernameLengthError = 'Username length must be greater than 5';
const String emailRegex = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
    '\\@' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
    '(' +
    '\\.' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
    ')+';
const String PHONE_NUMBER_LENGTH_ERROR = 'Phone number must be 11 digits';

const String phoneNumberRegex = r'0[789][01]\d{8}';
const String upperCaseRegex = r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$';
const String lowerCaseRegex = r'^(?=.*?[a-z]).{8,}$';
const String symbolRegex = r'^(?=.*?[!@#\$&*~]).{8,}$';
const String digitRegex = r'^(?=.*?[0-9]).{8,}$';
const String passwordDigitErr = 'Password must have at least one digit';
const String passwordUppercaseErr = 'Password must have at least one Upper case';
const String passwordSymbolErr = 'Password must have a least one special character';

const String phoneNumberLengthError = 'Phone number must be 11 digits';

const String invalidPhoneNumberField =
    "Number provided isn\'t valid.Try another phone number";



