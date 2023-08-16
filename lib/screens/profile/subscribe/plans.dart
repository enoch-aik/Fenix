
import 'dart:io';

import 'package:fenix/screens/profile/subscribe/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../theme.dart';
import '../../onboarding/constants.dart';

class Plans extends StatelessWidget {
  String? type;
  String? planType;
  String? planTarget;
  List? planDetails;

  Plans({Key? key, this.type, this.planDetails, this.planType, this.planTarget}) : super(key: key);


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
            decoration: BoxDecoration(
                gradient: gradient2(Color(0xFFCAEBD7),Color(0xFF5EF2F2)),
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  Row(
                    children: [
                      // planDetails!["icon"],
                      tinyH5Space(),
                      Text(type!.toUpperCase(),
                      style: GoogleFonts.roboto(
                          fontSize: 15.w,
                          color: dark,
                          fontWeight: FontWeight.w700
                      ),),
                    ],
                  ),
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
                  GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 1 / 1.83,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 10),
                      itemCount: planDetails!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctx, index) {
                        return PlanWidget(
                          title: planType!,
                          plan: planDetails![index]['type'],
                          target: planTarget!,
                          price: planDetails![index]['price'].toString(),
                          duration: planDetails![index]['validity'].toString(),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

