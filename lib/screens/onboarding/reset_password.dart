
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/icons/arrow_back_icon_icons.dart';
import 'package:fenix/screens/onboarding/reset_password_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

import 'constants.dart';

class ResetPassword extends StatelessWidget {

  ResetPassword({Key? key}) : super(key: key);


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
                            Icon(Icons.lock, color: Color(0xFF2A3750),),
                            Text("Reset Password",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 21,
                                  shadows: [
                                    Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                                  ]
                              ),),
                          ],
                        ),
                        kSpacing, kSpacing, kSpacing,
                        TextFieldWidget(hint: "Enter Your Email",),

                        kSpacing,
                        TextFieldWidget(hint: "First Name",),
                        kSpacing,
                        TextFieldWidget(hint: "Last Name",),
                        kSpacing, kSpacing,
                      ],
                    ),




                    InkWell(
                      onTap:(){
                        Get.to(() => ResetPasswordNext());
                      },
                      child: ButtonWidget(title: "Next"),
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

