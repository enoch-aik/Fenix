
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/auth_screens/verification_mail_success.dart';
import 'package:fenix/screens/onboarding/reset_password_next.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../onboarding/constants.dart';

class ResendVerificationMail extends StatelessWidget {

  ResendVerificationMail({Key? key}) : super(key: key);

  final AccountController _accountController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: ListView(
        children: [
          WidgetsPad(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),
                        ),
                        kSpacing,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Resend Verification Mail",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 21,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                                  ]
                              ),),
                          ],
                        ),
                        kSpacing, kSpacing, kSpacing,

                        TextFieldWidget(hint: "Enter Your Email",
                        textController: _accountController.password,),

                      ],
                    ),




                    InkWell(
                      onTap:(){
                        _accountController.resendVerificationEmail(_accountController.email.text);
                      },
                      child: ButtonWidget(title: "Send"),
                    ),

                  ],
                ),
              )),
          SizedBox(height:  MediaQuery.of(context).size.height * 0.025,),

          InkWell(
            onTap: (){
              Get.back();
            },
            child: Align(
              alignment:Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: backButtonThree,
              ),
            ),
          )
        ],
      ),
    );
  }
}

