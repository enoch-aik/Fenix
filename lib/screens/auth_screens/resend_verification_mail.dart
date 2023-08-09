
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/auth_screens/verification_mail_success.dart';
import 'package:fenix/screens/onboarding/reset_password_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../onboarding/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResendVerificationMail extends StatelessWidget {

  ResendVerificationMail({Key? key}) : super(key: key);

  final AccountController _accountController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              WidgetsPad(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child:   Image.asset(
                                "assets/images/fenixgradientblue.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            kSpacing,

                            Text(AppLocalizations.of(context)!.resendVerificationMail,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 21,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                                  ]
                              ),),
                            kSpacing, kSpacing, kSpacing,

                            TextFieldWidget(hint: AppLocalizations.of(context)!.enterMail,
                            textController: _accountController.email,),

                          ],
                        ),


                        InkWell(
                          onTap:(){
                            if(_formKey.currentState!.validate()){
                              _accountController.resendVerificationEmail(_accountController.email.text);
                            }
                          },
                          child: ButtonWidget(title: AppLocalizations.of(context)!.send),
                        ),

                      ],
                    ),
                  )),
              // SizedBox(height:  MediaQuery.of(context).size.height * 0.025,),

              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Align(
                  alignment:Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                    child: backButtonThree,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

