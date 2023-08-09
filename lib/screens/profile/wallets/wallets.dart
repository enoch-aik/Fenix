import 'dart:io';

import 'package:fenix/controller/payment_controller.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/profile.dart';
import 'package:fenix/screens/profile/wallets/add_new_card.dart';
import 'package:fenix/screens/profile/wallets/edit_card_details.dart';
import 'package:fenix/screens/profile/wallets/widgets.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../controller/user_controller.dart';

class Wallet extends StatefulWidget {
   Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  InputBorder? border = OutlineInputBorder();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserController _userController =  Get.find();
  final PaymentController _paymentController = Get.find();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentController.getUserCards(token: _userController.getToken(),);
  }


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

                  Text("Payment Wallet",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(color: dark),),


                    IconButton(
                        onPressed: (){
                          Get.to(() => AddCard());
                        },
                        icon: Icon(Icons.add, size: 27.w,),
                    )

                ],),
              )
            ],
          ),
        )
      ),
      body: (_paymentController.userCards == null)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Oops! No Card Found!"),

            TextButton(
                onPressed: (){
                  Get.to(() => AddCard());
                },
              child:  Text("Add Card",
              style: GoogleFonts.aBeeZee(color: blue, fontWeight: FontWeight.w700, fontSize: 16.w),),
            )
          ],
        ),
      )
          : Container(
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
                  child: Column(
                    children: [

                      Text("Enter Your Payment Details"),

                      divider2(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 25.w,
                                width: 25.w,
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: light.withOpacity(0.4),
                                  border: Border.all(color: dark),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Checkbox(
                                    value: true,
                                    checkColor: blue,
                                    side: BorderSide.none,
                                    activeColor: Colors.transparent,
                                    onChanged: (v) {},
                                ),
                              ),
                              tinyHSpace(),
                              Text("Default",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 13.w,
                                    color: black,
                                    fontWeight: FontWeight.w400
                                ),)
                            ],
                          ),

                          InkWell(
                            onTap: (){
                              Get.to(() => EditCard());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.w),
                              decoration: BoxDecoration(
                                color: blue.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              child: Text("Edit Card",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16.w,
                                  color: blue,
                                  fontWeight: FontWeight.w600
                              ),)
                            ),
                          ),
                        ],
                      ),

                      kSpacing,

                      PaymentCardWidget(number: _paymentController.userCards['number']),

                      divider2(),


                      kSpacing,

                      
                      Container(
                        width: width() * 0.6,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30.w),
                          border: Border.all(color: black)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.w),

                        child: Center(
                          child: Text("Next",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18.w,
                                color: black,
                                fontWeight: FontWeight.w600
                            ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}

