
import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/auth_board.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/onboarding/reset_email.dart';
import 'package:fenix/screens/onboarding/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../../helpers/validator.dart';
import '../../neumorph.dart';
import '../../theme.dart';


class SignIn extends StatelessWidget {

  SignIn({Key? key}) : super(key: key);

  PageController pageController = PageController();
  final AccountController _accountController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Padding(
        padding: EdgeInsets.only(top: 35.w, left: 31.w, right: 31.w, bottom: 0.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
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
                        Shadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0,1), blurRadius: 4)
                      ]
                    ),),

                    kSpacing,

                    TextFieldWidget(hint: "Email & Gmail",
                      textController: _accountController.email,
                      validator: (value) =>
                          EmailValidator.validate(value!),),
                    kSpacing,
                    TextFieldWidget(hint: "Password",
                      textController: _accountController.password,
                      suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                      validator: (value) =>
                          PasswordValidator.validate(value!),),

                    kSpacing,
                    kSpacing,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            decoration: depressNeumorph(),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                  Colors.transparent, // Your color
                                ),
                                child: Checkbox(
                                  value: false,
                                  onChanged: (v) {},
                                ),
                              ),
                            )),
                        tinyHSpace(),
                        Container(
                          decoration: depressNeumorph().copyWith(
                              border:
                              Border.all(color: white.withOpacity(0.1))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                            child: Text(
                              "Remember me",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.2)),
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height:  MediaQuery.of(context).size.height * 0.07,),

                    InkWell(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          _accountController.signIn();
                        }
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.w),
                              color: const Color(0xFFE3EDF7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(-3, -6), // changes position of shadow
                                ),


                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.lock, color: Color(0xFF414B5A),size: 15,),
                                tinyH5Space(),
                                Text("Forgot Password", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: const Color(0xFF414B5A).withOpacity(0.8),
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w800
                                ),),
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.w),
                              color: const Color(0xFFE3EDF7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(-3, -6), // changes position of shadow
                                ),


                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 const Icon(Icons.person, color: Color(0xFF414B5A),size: 15,),
                                tinyH5Space(),

                                Text("Forgot Email", style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color:  const Color(0xFF414B5A).withOpacity(0.8),
                                    fontSize: 12.w,
                                  fontWeight: FontWeight.w800
                                ),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                ),
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

