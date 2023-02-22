
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/auth_screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

class AcctCreationSuccess extends StatelessWidget {
  const AcctCreationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [


          Padding(
            padding: EdgeInsets.symmetric(vertical: 78.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),


                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                    Text("Congratulations!\nAccount has been\nCreated ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Color(0xFF1411AB),
                          fontSize: 30.w
                      ),),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                    InkWell(
                      onTap: (){
                        Get.to(() => SignIn());
                      },
                      child: Container(
                        height: 33.w,
                        width: 187.w,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: Color(0xFF03924A),
                        ),
                        child:  Center(
                          child: Text("Back to Sign In",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(

                                color: Colors.white,
                              fontSize: 17.w
                            ),),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

          BottomHillsWidget()
        ],
      ),
    );
  }
}

