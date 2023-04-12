import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';

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
            gradient: gradient(
              const Color(0xFF1A9AFF),
              const Color(0xFF54FADC),
            ),
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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      )),
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
                  Image.asset('assets/images/sub1.png'),
                  smallSpace(),
                  Image.asset('assets/images/sub2.png'),
                  smallSpace(),
                  Image.asset('assets/images/sub3.png'),
                  smallSpace(),
                  Image.asset('assets/images/sub1.png'),
                  smallSpace(),
                  Image.asset('assets/images/sub2.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
