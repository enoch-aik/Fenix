import 'dart:io';

import 'package:fenix/controller/payment_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/widgets/loader.dart';
import 'package:fenix/screens/profile/subscribe/plan_list.dart';
import 'package:fenix/screens/profile/subscribe/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../theme.dart';
import '../../onboarding/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Subscribe extends StatelessWidget {
   Subscribe({Key? key}) : super(key: key);

  final PaymentController _paymentController = Get.find();
  final UserController _userController = Get.find();

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
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Column(
              children: [
                Padding(
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
                       Text(AppLocalizations.of(context)!.subscribePlan),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
               Obx(() => (_paymentController.isGettingPlans.value == true) ?
               Column(
                 children: [
                   LineLoader(),
                   tinySpace(),
                   Text("Getting Plans...",
                     style: GoogleFonts.lato(
                         fontSize: 11.w,
                         fontWeight: FontWeight.w400
                     ),),
                   tinySpace(),
                 ],
               ) : SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  InkWell(
                    onTap: (){
                      _paymentController.getPlans(token: _userController.getToken(), planType: "platinum");
                    },

                    child: Image.asset('assets/images/sub1.png'),
                  ),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        _paymentController.getPlans(token: _userController.getToken(), planType: "diamond");
                      },
                      child: Image.asset('assets/images/sub2.png')),

                  smallSpace(),
                  InkWell(
                      onTap: (){
                        _paymentController.getPlans(token: _userController.getToken(), planType: "gold");
                      },
                      child: Image.asset('assets/images/sub3.png')),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        _paymentController.getPlans(token: _userController.getToken(), planType: "silver");
                      },
                      child: Image.asset('assets/images/sub4.png')),
                  smallSpace(),
                  InkWell(
                      onTap: (){
                        _paymentController.getPlans(token: _userController.getToken(), planType: "bronze");
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
