
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../auth_screens/sign_in.dart';
import '../onboarding/constants.dart';

class VerificationMailSuccess extends StatelessWidget {

  VerificationMailSuccess({Key? key,}) : super(key: key);


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

                            Text("A verification link has been sent to your email",
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


                            Text("Please go to your email app and click on the link to verify",
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
                          onTap:() async {
                            // Android: Will open mail app or show native picker.
                            // iOS: Will open mail app if single mail app found.
                            var result = await OpenMailApp.openMailApp(
                              nativePickerTitle: 'Select email app to open',
                            );

                            // If no mail apps found, show error
                            if (!result.didOpen && !result.canOpen) {
                              // showNoMailAppsDialog(context);

                              // iOS: if multiple mail apps found, show dialog to select.
                              // There is no native intent/default app system in iOS so
                              // you have to do it yourself.
                            } else if (!result.didOpen && result.canOpen) {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                },
                              );
                            }
                          },
                          child: ButtonWidget(title: "Open Email App"),
                        ),

                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}



// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),

