import 'dart:async';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home.dart';
import 'package:fenix/screens/onboarding/onboarding_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../views.dart';
import 'onboarding_two.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
            (){
              Get.off(() =>  Views());
            }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 78.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // child: Center(
                  //     child: Image.asset(
                  //   "assets/images/logoFrame.png",
                  //   width: Get.height * 0.2,
                  //   height: Get.width * 0.48,
                  // )),
                  width: Get.height * 0.4,
                  height: Get.width * 0.9,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/circle_sh.png'))),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [Color(0xFF28D7AD)],
                      ),
                    ),
                    Text(
                      "Developed by Khasan.A",
                      style: TextStyle(
                          color: Colors.grey.shade800, fontSize: 16.w),
                    ),
                  ],
                )
              ],
            ),
          ),
          const BottomHillsWidget()
        ],
      ),
    );
  }
}
