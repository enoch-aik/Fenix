import 'package:fenix/const.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/screens/profile/account/contact/contact_us.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../onboarding/constants.dart';
import '../edit_profile.dart';
import 'account_info.dart';
import 'login_and_security.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/fenixmall_white.png",
                color: white,
                height: height() * 0.075,
              ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
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
              accountContainer('Your Account Information', onTap: () {
                Get.to(() => AccountInfo());
              }),
              tinySpace(),
              accountContainer('Login & Security', onTap: () {
                Get.to(() => LoginAndSecurity());
              }),
              tinySpace(),
              accountContainer('Contact Us', onTap: (){
                Get.to(() => ContactUs());
              }),
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
                  child: Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              )),
              const Icon(Icons.arrow_forward, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
