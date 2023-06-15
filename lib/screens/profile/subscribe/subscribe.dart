import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/profile/subscribe/plan_list.dart';
import 'package:fenix/screens/profile/subscribe/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const.dart';
import '../../../theme.dart';
import '../../onboarding/constants.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.02),
        child: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Padding(
              padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: (Platform.isIOS)
                        ? Icon(Icons.arrow_back_ios, color: dark, size: 29.w,)
                        : Icon(Icons.arrow_back,  color: dark, size: 29.w,),
                  ),
                  const Text('SUBSCRIBE PLAN'),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => Plans(
                        type: "Diamond Plan ${topBanner['type']}",
                        planDetails: topBanner,
                      ));
                    },
                    child: Image.asset('assets/images/sub1.png'),
                  ),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        Get.to(() => Plans(
                          type: "Diamond Plan ${top10['type']}",
                          planDetails: top10,
                        ));
                      },
                      child: Image.asset('assets/images/sub2.png')),

                  smallSpace(),
                  InkWell(
                      onTap: (){
                        Get.to(() => Plans(
                          type: "Diamond Plan ${bestSelling['type']}",
                          planDetails: bestSelling,
                        ));
                      },
                      child: Image.asset('assets/images/sub3.png')),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        Get.to(() => Plans(
                          type: "Diamond Plan ${topDeals['type']}",
                          planDetails: topDeals,
                        ));
                      },
                      child: Image.asset('assets/images/sub4.png')),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        Get.to(() => Plans(
                          type: "Diamond Plan ${
                              recommendedDeals['type']}",
                          planDetails: recommendedDeals,
                        ));
                      },
                      child: Image.asset('assets/images/sub5.png')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
