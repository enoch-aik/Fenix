import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/services/account_services.dart';
import '../screens/auth_screens/sign_in.dart';
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

  refreshToken(token) async {
    AccountServices.refreshToken((status, response) {
      if (status) {
        setUser(response['data']['accessToken'],
            refreshToken: response['data']['refreshToken'], isFetchUser: false);
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token);
  }

  setUser(token, {refreshToken, isFetchUser}) {
    var userController = Get.put(UserController());
    userController.setToken(token);
    userController.setRefresh(refreshToken);
    userController.setPersistToken(token, refreshToken);
    if (isFetchUser != false) {
      userController.fetchUser(token);
    }
  }

  signOut(token) async {
    Get.to(() => Loading(
          navigateScreen: SignIn(),
        ));
    AccountServices.loginOutUser((status, response) {
      if (status) {
        CustomSnackBar.successSnackBar('Logout Successful!', '$response');

        Get.to(() => SignIn());
      } else {
        Get.back();

        CustomSnackBar.failedSnackBar('Logout Failed', '$response');
      }
    }, token);
  }
}
