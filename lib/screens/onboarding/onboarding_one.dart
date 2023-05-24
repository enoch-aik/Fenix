
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

import '../../const.dart';
import 'onboarding_two.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [


          Padding(
            padding: EdgeInsets.symmetric(vertical: 78.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
                  child: Image.asset("assets/images/fenixgradientblue.png",fit: BoxFit.fill,),
                ),

                Column(
                  children: [
                    InkWell(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 14.w, horizontal: 55.w),
                        child: Container(
                          // height: 50.w,
                          // width: 256.w,
                          padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 17.w),
                          decoration:  BoxDecoration(
                            border: Border.all(color: Colors.white.withOpacity(0.511), width: 0.85),
                            borderRadius: BorderRadius.circular(8.53.w),
                            gradient:  const LinearGradient(
                              colors: [Color(0xFF9DDFF3), Color(0xFF0F55E8),],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 3,
                                blurRadius: 12,
                                offset: Offset(1, 10), // changes position of shadow
                              ),
                            ],
                        ),
                          child: const Center(
                            child: Text("Start Fenix",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                          ),
                        ),
                      ),
                      onTap: (){
                        Get.to(() => OnboardingTwo());
                      },
                    ),
                    SizedBox(height: 40.w,),


                  ],
                ),
              ],
            ),
          ),

          Positioned(bottom:-50, child:  BottomHillsWidget())
        ],
      ),
    );
  }
}

