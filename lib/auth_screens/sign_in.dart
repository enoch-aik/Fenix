
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/icons/arrow_back_icon_icons.dart';
import 'package:fenix/screens/onboarding/loading.dart';
import 'package:fenix/screens/views.dart';
import 'package:fenix/screens/onboarding/account_creation_success.dart';
import 'package:fenix/screens/onboarding/auth_board.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/onboarding/reset_email.dart';
import 'package:fenix/screens/onboarding/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {

  SignIn({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: Padding(
        padding: EdgeInsets.only(top: 35.w, left: 31.w, right: 31.w, bottom: 0.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),
                  ),

                  kSpacing,

                  Text("Sign In Account",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 21,
                    shadows: [
                      Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                    ]
                  ),),

                  kSpacing,

                  TextFieldWidget(hint: "Email & Gmail",),
                  kSpacing,
                  TextFieldWidget(hint: "Password",),

                  kSpacing,
                  kSpacing,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                            value: false,
                            onChanged: (v){},
                          side: BorderSide(color: Colors.white),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFieldWidget(hint: "Remember me",),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height:  MediaQuery.of(context).size.height * 0.07,),

                  InkWell(
                    onTap: (){
                      Get.to(() => Loading());
                    },
                      child: ButtonWidget(title: "Sign In"),
                  ),

                  SizedBox(height:  MediaQuery.of(context).size.height * 0.13,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(()=> ResetPassword());
                        },
                        child: Container(
                          height: 37.w,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock, color: Color(0xFF414B5A)),
                              Text("Forgot Password", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Color(0xFF414B5A).withOpacity(0.8),
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w800
                              ),),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.w),
                            color: Color(0xFFE3EDF7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(-3, -6), // changes position of shadow
                              ),


                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Get.to(()=> ResetEmail());
                        },
                        child: Container(
                          height: 37.w,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, color: Color(0xFF414B5A),),
                              Text("Forgot Email", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Color(0xFF414B5A).withOpacity(0.8),
                                  fontSize: 12.w,
                                fontWeight: FontWeight.w800
                              ),),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.w),
                            color: Color(0xFFE3EDF7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(-3, -6), // changes position of shadow
                              ),


                            ],
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),

              SizedBox(height:  MediaQuery.of(context).size.height * 0.055,),

              Align(
                alignment:Alignment.bottomLeft,
                child: InkWell(
                  onTap: (){
                    Get.off(() => AuthBoard());
                  },
                  child: backButtonThree,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

