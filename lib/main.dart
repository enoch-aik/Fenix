import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'controller/account_controller.dart';
import 'models/services/api_docs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fenix',
        theme: theme,
        onInit: () {
          Get.put(AccountController());
        },
        transitionDuration: const Duration(milliseconds: 250),
        defaultTransition: Transition.native,
        home: const SplashScreen(),
      ),
    );
  }
}
