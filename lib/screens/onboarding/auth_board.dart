
import 'package:fenix/auth_screens/create_account.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/icons/arrow_back_icon_icons.dart';
import 'package:fenix/auth_screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

import 'constants.dart';

class AuthBoard extends StatelessWidget {

   AuthBoard({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [

          WidgetsPad(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),
                  ),
                 Stack(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                         color: Color(0xFFE4F0FA),
                         borderRadius: BorderRadius.circular(24.w),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.blueGrey.withOpacity(0.15),
                             spreadRadius: 12,
                             blurRadius: 13,
                             offset: Offset(6, 6), // changes position of shadow
                           ),
                           BoxShadow(
                             color: Colors.white.withOpacity(1),
                             spreadRadius: 1,
                             blurRadius: 1,
                             offset: Offset(-0.2, -0.2), // changes position of shadow
                           ),
                         ]
                       ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Center(
                          child: Text("Welcome to Fenix\nThe Unique and\nMulti-Functional Online Store\nin Uzbekistan.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 17.w,
                            shadows: [
                              Shadow(color: Colors.grey, blurRadius: 2)
                            ]
                          ),),
                        )
                      ),

                     Positioned(
                       top: 0,
                       right: 0,
                       child: Image.asset("assets/images/chromeTop.png",fit: BoxFit.fill,),
                     ),
                     Positioned(
                       bottom: 0,
                       left: 0,
                       child: Image.asset("assets/images/chromeBottom.png",fit: BoxFit.fill,),
                     )
                   ],
                 ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              child: ButtonWidget(title: "Sign In"),
                            onTap: (){
                                Get.to(() => SignIn());
                            },
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(() => SignUp());
                            },
                              child: ButtonWidget(title: "Create Account"),
                          ),
                          ButtonWidget(title: "Continue as Guest"),
                        ],
                      ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Align(
                        alignment:Alignment.bottomLeft,
                        child: backButtonTwo,
                    ),
                  )
                ],
              )
          ),

          BottomHillsWidget()
        ],
      ),
    );
  }
}




// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),

