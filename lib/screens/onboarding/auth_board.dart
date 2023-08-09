import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/auth_screens/resend_verification_mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auth_screens/create_account.dart';
import '../auth_screens/sign_in.dart';
import 'constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthBoard extends StatelessWidget {
  AuthBoard({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Column(
              children: [
                CustomWidgetsPad(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
                      child: Image.asset(
                        "assets/images/fenixgradientpurple.png",
                      ),
                    ),
                    smallSpace(),
                    Stack(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFE4F0FA),
                                borderRadius: BorderRadius.circular(24.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.15),
                                    spreadRadius: 12,
                                    blurRadius: 13,
                                    offset: const Offset(
                                        6, 6), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(-0.2,
                                        -0.2), // changes position of shadow
                                  ),
                                ]),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 17.w, shadows: [
                                          Shadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 2)
                                        ]),
                                        children:  [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!.welcomeToFenix2,
                                          ),
                                          // TextSpan(
                                          //   text: "Welcome to ",
                                          // ),
                                          // TextSpan(
                                          //     text: "Fenix",
                                          //     style: TextStyle(
                                          //         color: Colors.redAccent)),
                                          // TextSpan(
                                          //   text:
                                          //       "\nThe Unique and\nMulti-Functional Online Store\nin Uzbekistan.",
                                          // ),
                                        ])))),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/chromeTop.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Image.asset(
                            "assets/images/chromeBottom.png",
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                    verticalSpace(0.02),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: ButtonWidget(title: AppLocalizations.of(context)!.signIn),
                          onTap: () {
                            Get.to(() => SignIn());
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SignUp());
                          },
                          child: ButtonWidget(title: AppLocalizations.of(context)!.createAccount),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ResendVerificationMail());
                          },
                          child: ButtonWidget(title: AppLocalizations.of(context)!.verifyAccount),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: backButtonTwo,
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          Positioned(bottom: -50, child: BottomHillsWidget())
        ],
      ),
    );
  }
}

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
