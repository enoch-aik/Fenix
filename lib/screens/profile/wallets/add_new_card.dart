import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/wallets/widgets.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';


class AddCard extends StatefulWidget {
  AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
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

                      Text("Add Payment Method",
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
                child: Column(
                  children: [

                    PaymentCardWidget(),

                    mediumSpace(),

                    Text("Enter Your Payment Details",
                      style: GoogleFonts.roboto(color: dark),),

                    smallSpace(),

                    PaymentTextFieldWidget(
                      label: "First Name",
                      keyboardType: TextInputType.text,
                    ),
                    PaymentTextFieldWidget(
                      label: "Last Name",
                      keyboardType: TextInputType.text,
                    ),
                    PaymentTextFieldWidget(
                      label: "Card Number",
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width() * 0.2,
                          child: PaymentTextFieldWidget(
                            label: "07",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        mediumHSpace(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: width() * 0.2,
                            child: PaymentTextFieldWidget(
                              label: "23",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    kSpacing,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: width() * 0.2,
                        child: PaymentTextFieldWidget(
                          label: "CVV",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Save card to wallet",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20.w,
                              color: dark,
                              fontWeight: FontWeight.w400
                          ),),
                        FlutterSwitch(
                          activeToggleColor: blue,
                          activeColor: light,
                          inactiveToggleColor: black,
                          inactiveColor: light,
                          valueFontSize: 25.0,
                          toggleSize: 30.0,
                          value: true,
                          borderRadius: 30.0,
                          padding: 3,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              val;
                            });
                          },
                        ),

                      ],
                    ),
                    kSpacing,
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Visa Card",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20.w,
                              color: dark,
                              fontWeight: FontWeight.w400
                          ),),
                        FlutterSwitch(
                          activeToggleColor: blue,
                          activeColor: light,
                          inactiveToggleColor: black,
                          inactiveColor: light,
                          valueFontSize: 25.0,
                          toggleSize: 30.0,
                          value: true,
                          borderRadius: 30.0,
                          padding: 3,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              val;
                            });
                          },
                        ),

                      ],
                    ),

                    kSpacing,
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Master Card",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20.w,
                              color: dark,
                              fontWeight: FontWeight.w400
                          ),),
                        FlutterSwitch(
                          activeToggleColor: blue,
                          activeColor: light,
                          inactiveToggleColor: black,
                          inactiveColor: light,
                          valueFontSize: 25.0,
                          toggleSize: 30.0,
                          value: false,
                          borderRadius: 30.0,
                          padding: 3,
                          showOnOff: false,
                          onToggle: (val) {
                            setState(() {
                              val;
                            });
                          },
                        ),

                      ],
                    ),

                    Container(
                      width: width() * 0.6,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30.w),
                          border: Border.all(color: black)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      margin: EdgeInsets.symmetric(vertical: 50.w),
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
