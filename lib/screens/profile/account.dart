import 'package:fenix/const.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../onboarding/constants.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),

      appBar: AppBar(
          title: SizedBox(
            height: 46.h,
            child: Image.asset(
              "assets/images/fenixWhite2.png",
              fit: BoxFit.fill,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 27.w,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 27.w,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 27.w,
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2(
                const Color(0xFF46E0C4),
                const Color(0xFF59B5C0),
              ),
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
              gradient: gradient2(
                const Color(0xFF41F0D1),
                const Color(0xFF4A9A9E),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap:()=>Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              const Text('Account Settings'),
              smallSpace(),
              accountContainer('Your Account Information'),
              tinySpace(),
              accountContainer('Your Selling List'),
              tinySpace(),
              accountContainer('Login & Security'),
              tinySpace(),
              accountContainer('Contact Us'),
              mediumSpace(),
              const Text('Payment Settings'),
              smallSpace(),
              accountContainer('Your Payments'),
              tinySpace(),
              accountContainer('Your Gift Card'),
              tinySpace(),
              accountContainer('Fenix Card'),


            ],
          ))
        ],
      ),
    );
  }

  Container accountContainer(title) {
    return Container(
      decoration: depressNeumorph().copyWith(borderRadius: BorderRadius.circular(15)),

      //     .copyWith(
      //   color: white,
      //   boxShadow: [
      //     const BoxShadow(
      //       color: Colors.white,
      //     ),
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.9),
      //       spreadRadius: -3,
      //       blurRadius: 3,
      //       offset: const Offset(3, 5), // changes position of shadow
      //     ),
      //   ], // changes position of shadow
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
        child: Row(
          children: [
            Expanded(child: Text(title,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),)),
            const Icon(Icons.arrow_forward,size: 25),
          ],
        ),
      ),
    );
  }
}
