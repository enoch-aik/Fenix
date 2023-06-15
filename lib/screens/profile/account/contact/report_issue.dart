import 'package:fenix/const.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../onboarding/constants.dart';
import '../../edit_profile.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/fenixmall_white.png",
              color: white,
              height: height() * 0.075,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          )),
      body: Column(
        children: [
          Container(
            height: 50.w,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 20.w),
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Report Issue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
                tinySpace(),
              ],
            ),
          ),
          Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [

                  accountContainer('Fenix has a bug',  onTap: () {}),
                  tinySpace(),
                  accountContainer('The app is not working as expected', onTap: () {}),
                  tinySpace(),
                  accountContainer('App is not loading sometimes',),
                  tinySpace(),
                  accountContainer('Other issues', onTap: () {}),
                  tinySpace(),

                ],
              ))
        ],
      ),
    );
  }

  InkWell accountContainer(title, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration:
        depressNeumorph().copyWith(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                    children: [

                      tinyHSpace(),
                      Text(
                        title,
                        style:
                        const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
              Icon(Icons.arrow_forward, size: 25, color: dark.withOpacity(0.5),),
            ],
          ),
        ),
      ),
    );
  }
}
