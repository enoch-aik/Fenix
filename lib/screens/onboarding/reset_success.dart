
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auth_screens/sign_in.dart';
import 'constants.dart';

class ResetSuccess extends StatelessWidget {

  String page;

  ResetSuccess({Key? key, required this.page}) : super(key: key);


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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),
                        ),
                        kLargeSpacing,

                        Text("Congratulations!\n$page has been\nRestarted",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Color(0xFF288827),
                            fontSize: 25.w,
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                            ]
                        ),),

                        kLargeSpacing,
                        kLargeSpacing,


                        Text("Please go back to sign in screen and use the same info",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Color(0xFF31456A).withOpacity(0.6),
                            fontSize: 18.w,
                            shadows: [
                              Shadow(color: Colors.black.withOpacity(0.25), offset: Offset(0,1), blurRadius: 4)
                            ]
                        ),),


                      ],
                    ),




                    InkWell(
                      onTap:(){
                        Get.off(() => SignIn());
                      },
                      child: ButtonWidget(title: "Back to Sign In"),
                    ),

                  ],
                ),
              )),
        ],
      ),
    );
  }
}



// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),

