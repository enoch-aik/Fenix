import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/purchase_confirmation.dart';
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


class PurchaseDetails extends StatefulWidget {

  String? plan;
  String? duration;
  String? target;
  String? price;

  PurchaseDetails({Key? key, this.price, this.duration, this.plan, this.target, }) : super(key: key);

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  bool useGlassMorphism = false;

  bool useBackgroundImage = false;

  File? _image;
  String profileImage = '';

  bool accept = false;

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
                                      _image = selectedImage;
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
                                      _image = selectedImage;
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
                      gradient: gradient2(Color(0xFFCAEBD7),Color(0xFF5EF2F2)),
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

                      Text("Choose a ${(widget.plan == "Top Banner") ? "banner" : "product"}",
                        style: GoogleFonts.roboto(color: dark, fontSize: 18.w),),

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
                    Text("You've selected the ${widget.plan} Plan",
                      style: GoogleFonts.roboto(color: dark, fontSize: 17.w),),
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
                              Text(widget.price!,
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

                    mediumSpace(),

                    Text("Please choose the ${(widget.plan == "Top Banner") ? " banner image" : "product"} you want to promote",
                      style: GoogleFonts.roboto(color: dark, fontSize: 17.w),),

                    smallSpace(),

                    Container(
                      height: height() * 0.18,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE3EDF7),
                          borderRadius: BorderRadius.circular(16),
                          image: _image != null
                              ? DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: FileImage(_image!))
                              : const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('')),
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
                        child: _image != null ? Text("") : Text("Choose ${(widget.plan == "Top Banner") ? "Image" : "Post"}",
                          style: GoogleFonts.roboto(color: light, fontSize: 15.w, fontWeight: FontWeight.w400),),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        showImagePickers();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.w),
                          decoration: BoxDecoration(
                            color: blue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Text("${(widget.plan == "Top Banner") ? "Upload Image" : "Choose Post"}",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16.w,
                                color: blue,
                                fontWeight: FontWeight.w600
                            ),)
                      ),
                    ),
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
                            value: accept,
                            checkColor: blue,
                            side: BorderSide.none,
                            activeColor: Colors.transparent,
                            onChanged: (v) {
                              setState(() {
                                accept = v!;
                              });
                            },
                          ),
                        ),
                        tinyHSpace(),
                        Text("I Accept the Terms and Conditions",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 13.w,
                              color: black,
                              fontWeight: FontWeight.w400
                          ),)
                      ],
                    ),]
                ),
                    kSpacing,

                    (widget.plan == "Top Banner") ? Text("Note: please make sure the photo must be high quality and proper size. if you promote any sexual content or some groups that is against the law, your account wil be ban forever",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16.w,
                          color: red,
                          fontWeight: FontWeight.w400
                      ),) : Text(""),

                    kSpacing,
                    kSpacing,
                    kSpacing,
                    kSpacing,


                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (){
                          Get.to(() => PurchaseConfirmation(
                            plan: widget.plan!,
                            price: widget.price,
                            target: widget.target,
                            duration: widget.duration,
                            image: _image,
                          ));
                        },
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
