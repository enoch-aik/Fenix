import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/services/account_services.dart';
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

  // @override
  // void dispose() {
  //   _firstName.clear();
  //   _lastName.clear();
  //   _email.clear();
  //   _password.clear();
  //   super.dispose();
  // }

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
        var userController = Get.put(UserController());
        userController.setToken(response['data']['accessToken']);
        userController.fetchUser(response['data']['accessToken']);
      } else {
        Get.back();

        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, email: _email.text, password: _password.text);
  }
}
