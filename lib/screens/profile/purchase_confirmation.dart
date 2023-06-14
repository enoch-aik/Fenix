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
import '../../../helpers/widgets/dialogs.dart';
import '../../helpers/image_picker.dart';


class PurchaseConfirmation extends StatefulWidget {

  String? plan;
  String? duration;
  String? target;
  String? price;

  PurchaseConfirmation({Key? key, this.price, this.duration, this.plan, this.target, }) : super(key: key);

  @override
  State<PurchaseConfirmation> createState() => _PurchaseConfirmationState();
}

class _PurchaseConfirmationState extends State<PurchaseConfirmation> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  InputBorder? border = OutlineInputBorder();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<dynamic> showImagePickers({isPhoto = true}) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: height() * 0.32,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Get.back();
                                  var selectedImage = isPhoto
                                      ? await openCamera()
                                      : await openVideoCamera();
                                  if (selectedImage != null) {
                                    setState(() {

                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Take ${isPhoto ? 'Photo' : 'Video'} from camera',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  Get.back();

                                  var selectedImage = isPhoto
                                      ? await openGallery()
                                      : await openVideoGallery();
                                  if (selectedImage != null) {
                                    setState(() {

                                    });
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                          'Take ${isPhoto ? 'Photo' : 'Video'} from gallery',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.collections,
                                        size: 25,
                                        color: primary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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

                      Text("Confirm Purchase",
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("Confirmation",
                        style: GoogleFonts.roboto(color: dark),),
                    ),
                    kSpacing,
                    Container(
                      padding: EdgeInsets.all(12.w),
                      margin: EdgeInsets.all(4.w),
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
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.plan!,
                            style: GoogleFonts.roboto(color: dark, fontSize: 15.w),),
                          Row(
                            children: [
                              Checkbox(
                                  value: true,
                                  shape: CircleBorder(),
                                  onChanged: (v){}),
                              Text("24/7 Active",
                                style:  GoogleFonts.roboto(
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w700
                                ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: true,
                                      shape: CircleBorder(),
                                      onChanged: (v){}),
                                  Text(widget.target!,
                                    style:  GoogleFonts.roboto(
                                        fontSize: 13.w,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ],
                              ),
                              Text(widget.duration!,
                                style:  GoogleFonts.roboto(
                                    fontSize: 17.w,
                                    color: blue,
                                    fontWeight: FontWeight.w700
                                ),),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: true,
                                      shape: CircleBorder(),
                                      onChanged: (v){}),
                                  Text(widget.plan!,
                                    style:  GoogleFonts.roboto(
                                        fontSize: 13.w,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ],
                              ),
                              Text("${widget.price!} So'm",
                                style:  GoogleFonts.roboto(
                                    fontSize: 17.w,
                                    color: red,
                                    fontWeight: FontWeight.w700
                                ),),
                            ],
                          ),
                        ],
                      ),
                    ),


                    Divider(color: light.withOpacity(0.4),thickness: 6, height: 40.w,),

                    Align(
                      alignment: Alignment.center,
                      child: Text("Your banner",
                        style: GoogleFonts.roboto(color: dark, fontSize: 17.w),),
                    ),

                    smallSpace(),

                    Container(
                      height: height() * 0.18,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE3EDF7),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 5,
                              offset: const Offset(2, 2), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 5,
                              offset: Offset(-2, -2), // changes position of shadow
                            ),
                          ]
                      ),
                      child: Center(
                        child: Text("Choose Post",
                          style: GoogleFonts.roboto(color: light, fontSize: 15.w, fontWeight: FontWeight.w400),),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        showImagePickers();
                      },
                      child: Container(
                        width: width() * 0.5,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                          decoration: BoxDecoration(
                            color: light.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit, size: 17.w,),
                              tinyHSpace(),
                              Text("Edit Banner",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14.w,
                                    color: dark,
                                    fontWeight: FontWeight.w600
                                ),),
                            ],
                          )
                      ),
                    ),
                    kSpacing,
                    Divider(color: light.withOpacity(0.4),thickness: 6, height: 40.w,),
                    smallSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Promo Code",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w700
                          ),),
                        Text("0%",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              color: red,
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    Divider(color: light.withOpacity(0.4), thickness: 2,),
                    kSpacing,
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w700
                          ),),
                        Text("${widget.price}  So'm",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              color: red,
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    Divider(color: light.withOpacity(0.4), thickness: 2,),
                    kSpacing,
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Promotion Time",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w700
                          ),),
                        Text("${widget.duration}",
                          style:  GoogleFonts.roboto(
                              fontSize: 16.w,
                              color: red,
                              fontWeight: FontWeight.w700
                          ),),
                      ],
                    ),
                    Divider(color: light.withOpacity(0.4), thickness: 2,),
                    kSpacing,
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
                              SizedBox(
                                width: width() * 0.8,
                                child: Text("I Accept the Terms and Conditions and agree to this purchase",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 13.w,
                                      color: black,
                                      fontWeight: FontWeight.w600
                                  ),),
                              )
                            ],
                          ),]
                    ),

                    kSpacing,
                    kSpacing,
                    kSpacing,
                    kSpacing,


                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: width() * 0.6,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30.w),
                            border: Border.all(color: black)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        child: Center(
                          child: Text("Next",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16.w,
                                color: black,
                                fontWeight: FontWeight.w600
                            ),),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: width() * 0.6,
                        decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(30.w),
                            border: Border.all(color: black)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        child: Center(
                          child: Text("Cancel",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16.w,
                                color: white,
                                fontWeight: FontWeight.w600
                            ),),
                        ),
                      ),
                    ),
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
