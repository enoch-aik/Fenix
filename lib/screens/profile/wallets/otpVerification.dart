import 'dart:async';
import 'dart:io';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/wallets/wallets.dart';
import 'package:fenix/screens/profile/wallets/widgets.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../controller/payment_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../helpers/widgets/dialogs.dart';
import '../../views.dart';


class VerifyCode extends StatefulWidget {

  int? time;
  String? message;

  VerifyCode({Key? key, this.time, this.message}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  InputBorder? border = OutlineInputBorder();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final input1Controller = TextEditingController();
  final input2Controller = TextEditingController();
  final input3Controller = TextEditingController();
  final input4Controller = TextEditingController();
  final input5Controller = TextEditingController();
  final input6Controller = TextEditingController();

  final PaymentController _paymentController = Get.find();
  final UserController _userController =  Get.find();

  Timer? _timer;
  int _start = 0;

  RxBool processing = false.obs;

 startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.time);
    _start = (widget.time! / 1000).toInt();
    startTimer();
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
                _paymentController.paymentStatus == true ? SizedBox() : Container(
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

                     Text("OTP Verification",
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
        width: width(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() => _paymentController.paymentStatus == true
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: green, size: 120.w,),
              kSpacing,
              Text("Card Verified Successfully!!"),

              verticalSpace(0.2),


              Obx(() => (processing.value == true) ? CircularProgressIndicator() : ElevatedButton(
                onPressed: (){
                  print("dfff");
                  processing.value = true;
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      _paymentController.paymentStatus = false.obs;
                      processing.value = false;
                      print(_paymentController.paymentStatus);
                    });
                    Get.off(() => Views());
                  });
                },
                child: Text("Pay",
                  style: GoogleFonts.aBeeZee(color: white, fontSize: 15.w, fontWeight: FontWeight.w600),),
              ),),
            ],
          )
              : Container(
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

                    Text("Enter OTP",
                      style: GoogleFonts.roboto(color: dark),),

                    smallSpace(),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        otpInput(first: true, last: false, controller: input1Controller),
                        otpInput(first: false, last: false, controller: input2Controller),
                        otpInput(first: false, last: false, controller: input3Controller),
                        otpInput(first: false, last: false, controller: input4Controller),
                        otpInput(first: false, last: false, controller: input5Controller),
                        otpInput(first: false, last: true, controller: input6Controller),
                      ],
                    ),

                    kSpacing,

                    Text(widget.message!,
                      style: GoogleFonts.roboto(color: dark, fontSize: 12.w),),
                    kSpacing,
                    Text("OTP will expire in ${_start} secs",
                      style: GoogleFonts.roboto(color: dark, fontSize: 12.w),),

                    mediumSpace(),
                    InkWell(
                      onTap: (){
                        String code = input1Controller.text + input2Controller.text
                            + input3Controller.text + input4Controller.text
                            + input5Controller.text + input6Controller.text;
                        // print(code);
                        _paymentController.verifyOTP(token: _userController.getToken(), code:code);
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't get OTP? ",
                          style: GoogleFonts.roboto(color: dark, fontSize: 12.w),),
                        InkWell(
                          onTap: (){
                            _paymentController.resendOTP(token: _userController.getToken());
                            setState(() {
                              _start = 60;
                              startTimer();
                            });
                          },
                          child: Text("Resend",
                            style: GoogleFonts.roboto(color: blue, fontSize: 12.w),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
        ),),
    );
  }

  Widget otpInput({first, last, controller}){
    return  Container(
      height: 85.w,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (value){
            if(value.length == 1 && last == false){
              FocusScope.of(context).nextFocus();
            }
            if(value.length == 0 && first == false){
              FocusScope.of(context).previousFocus();
            }
          },
          readOnly: false,
          controller: controller,
          showCursor: false,
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counter: Offstage(),
            labelStyle: GoogleFonts.aBeeZee(
                color: dark, fontWeight: FontWeight.w400, fontSize: 15.w),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: dark, width: 1.8),
                borderRadius: BorderRadius.circular(8.w)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: dark.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8.w)),
            fillColor: const Color(0xFFDAE5F2),
            filled: true,
          ),
        ),
      ),
    );
  }


}
