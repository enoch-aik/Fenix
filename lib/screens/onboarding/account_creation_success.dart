import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auth_screens/sign_in.dart';

class AcctCreationSuccess extends StatelessWidget {
  const AcctCreationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Padding(
        padding: EdgeInsets.only(top: 78.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                "assets/images/logoFrame.png",
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "Congratulations!\nAccount has been\nCreated ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Color(0xFF1411AB), fontSize: 30.w),
                  ),
                  verticalSpace(0.1),
                  InkWell(
                    onTap: () {
                      Get.to(() => SignIn());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: Color(0xFF03924A)),
                      padding: const EdgeInsets.fromLTRB(30, 7, 30, 9),
                      child: Text(
                        "Back to Sign In",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white, fontSize: 16.w),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            BottomHillsWidget()

          ],
        ),
      ),
    );
  }
}
