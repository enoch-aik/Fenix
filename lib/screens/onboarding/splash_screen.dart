import 'dart:async';

import 'package:fenix/const.dart';
import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/onboarding_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_two.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    loadApp();
    super.initState();
  }

  loadApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var refreshToken = prefs.getString('refreshToken');
    AccountController accountController = Get.put(AccountController());
    Timer(
        const Duration(seconds: 3),
        () => token == null
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const OnboardingOne()))
            : accountController.setUser(token, refreshToken: refreshToken));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE4F0FA),
        body: Image.asset('assets/images/Splash.gif', fit: BoxFit.cover,height: height(),width: width(),)

        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.symmetric(vertical: 78.w),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Image.asset(
        //             "assets/images/logoFrame.png",
        //             fit: BoxFit.fill,
        //           ),
        //           Text(
        //             "Developed by Khasan.A",
        //             style: TextStyle(
        //                 color: Colors.grey.shade800,
        //                 fontSize: 16.w,
        //                 fontWeight: FontWeight.w200),
        //           )
        //         ],
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 100,
        //       child: LoadingIndicator(
        //         indicatorType: Indicator.ballPulseSync,
        //         colors: [Color(0xFF28D7AD)],
        //       ),
        //     ),
        //     const BottomHillsWidget()
        //   ],
        // ),
        );
  }
}
