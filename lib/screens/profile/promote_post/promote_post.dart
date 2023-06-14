import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/promote_post/widgets.dart';
import 'package:fenix/screens/profile/wallets/widgets.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../helpers/widgets/dialogs.dart';


class PromotePost extends StatefulWidget {
  PromotePost({Key? key}) : super(key: key);

  @override
  State<PromotePost> createState() => _PromotePostState();
}

class _PromotePostState extends State<PromotePost> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  InputBorder? border = OutlineInputBorder();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.09),
          child: Container(
            color: const Color(0xFFE4EFF9),
            child: Column(
              children: [
                Container(
                  height: height() * 0.065,
                  decoration: BoxDecoration(gradient: appBarGradient),
                ),
                Container(
                  height: height() * 0.06,
                  decoration: BoxDecoration(
                    color: light.withOpacity(0.4),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.w)),
                  ),
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

                      Text("Promote Post",
                        style: GoogleFonts.roboto(color: dark),),

                      mediumHSpace(),

                    ],),
                )
              ],
            ),
          )
      ),
      body: Container(
        color: const Color(0xFFEBF2F9),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: EdgeInsets.only(top: 10.w, bottom: 15.w),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFFE3EDF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0.8, 0.5), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(-1, -1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                    itemBuilder: (context, index)
                    => PromotedPostWidget(),
                  separatorBuilder: (_,__) => divider2(),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}


