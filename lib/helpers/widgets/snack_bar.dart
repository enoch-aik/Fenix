import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme.dart';

class CustomSnackBar {
  static successSnackBar(title, message) {
    Get.snackbar(title, message,
        borderColor: green,
        borderWidth: 0.7,
        backgroundColor: background,
        icon: const Icon(
          Icons.check_circle,
          color: green,
        ));
  }



  static failedSnackBar(title, message) {
    Get.snackbar(title, message,
        borderColor: red,
        borderWidth: 0.7,
        duration: const Duration(seconds: 3),
        backgroundColor:background ,
        icon: const Icon(
          Icons.error,
          color: red,
        ));
  }
}
