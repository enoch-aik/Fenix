
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
      backgroundColor: Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [


          Padding(
            padding: EdgeInsets.symmetric(vertical: 78.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),



                Column(
                  children: [
                    SizedBox(
                      height:100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [Colors.green],
                      ),
                    ),
                    Text("Developed by Khasan.A",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16.w
                      ),),
                  ],
                )
              ],
            ),
          ),

          BottomHillsWidget()
        ],
      ),
    );
  }
}

