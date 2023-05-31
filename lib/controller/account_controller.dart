import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/services/account_services.dart';
import '../screens/auth_screens/sign_in.dart';
import '../screens/auth_screens/verification_mail_success.dart';
import '../screens/onboarding/account_creation_success.dart';
import '../screens/onboarding/loading.dart';

class AccountController extends GetxController {
  TextEditingController get firstName => _firstName;
  final TextEditingController _firstName = TextEditingController();

  TextEditingController get lastName => _lastName;
  final TextEditingController _lastName = TextEditingController();

  TextEditingController get email => _email;
  final TextEditingController _email = TextEditingController();

  TextEditingController get password => _password;
  final TextEditingController _password = TextEditingController();

  signUp() async {
    Get.to(() => const Loading(
          navigateScreen: AcctCreationSuccess(),
        ));

    AccountServices.registerUser((status, response) {
      print('==> $response');
      if (status) {
        CustomSnackBar.successSnackBar(
            'Great!', 'Kindly check your email for a verification email');

        Get.to(() => const AcctCreationSuccess());
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    },
        email: _email.text,
        firstName: _firstName.text,
        lastName: _lastName.text,
        password: _password.text);
  }

  signIn() async {
    Get.to(() => const Loading(
          navigateScreen: AcctCreationSuccess(),
        ));
    AccountServices.loginUser((status, response) {
      if (status) {
        setUser(response['data']['accessToken'],
            refreshToken: response['data']['refreshToken']);
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, email: _email.text, password: _password.text);
  }

  changePassword(token, oldPassword, newPassword) async {
    Get.to(() => const Loading(navigateScreen: AcctCreationSuccess()));
    AccountServices.changePassword((status, response) {
      Get.back();
      if (status) {
        Get.back();
        CustomSnackBar.successSnackBar(
            'Great', 'Password changed successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {"oldPassword": oldPassword, "newPassword": newPassword});
  }

  deleteAccount(token, oldPassword, newPassword) async {
    Get.to(() => const Loading(navigateScreen: AcctCreationSuccess()));
    AccountServices.changePassword((status, response) {
      Get.back();
      if (status) {
        CustomSnackBar.successSnackBar('Great', 'Account deleted successfully');
        Get.offAll(() => SignIn());
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {"oldPassword": oldPassword, "newPassword": newPassword});
  }

  refreshToken(token,{fetchUser=false}) async {
    AccountServices.refreshToken((status, response) {
      if (status) {
        setUser(response['data']['accessToken'],
            refreshToken: response['data']['refreshToken'], isFetchUser: fetchUser);
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token);
  }

  setUser(token, {refreshToken, isFetchUser}) {
    var userController = Get.put(UserController());
    userController.setToken(token);
    print('New token - $token');
    userController.setRefresh(refreshToken);
    print('New refreshToken - $refreshToken');

    userController.setPersistToken(token, refreshToken);
    if (isFetchUser != false) {
      userController.fetchUser(token);
    }
  }

  signOut(token) async {
    Get.to(() => Loading(
          navigateScreen: SignIn(),
        ));
    AccountServices.loginOutUser((status, response) async{
      if (status) {
        CustomSnackBar.successSnackBar('Logout Successful!', '$response');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Get.offAll(() => SignIn());
      } else {
        Get.back();

        CustomSnackBar.failedSnackBar('Logout Failed', '$response');
      }
    }, token);
  }

  resendVerificationEmail(email) async {
    Get.to(() =>  Loading(navigateScreen: VerificationMailSuccess()));
    AccountServices.resendVerificationEmail((status, response) {
      Get.back();
      if (status) {
        Get.back();
        CustomSnackBar.successSnackBar(
            'Great', 'Verification mail sent successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {"email": email});
  }
}
