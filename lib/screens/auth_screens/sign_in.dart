import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/auth_screens/resend_verification_mail.dart';
import 'package:fenix/screens/onboarding/auth_board.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/onboarding/reset_email.dart';
import 'package:fenix/screens/onboarding/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../../helpers/validator.dart';
import '../../neumorph.dart';
import '../../theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  PageController pageController = PageController();
  final AccountController _accountController = Get.find();
  final _formKey = GlobalKey<FormState>();

  RxBool obscure = false.obs;
  Rx<IconData> obscureIcon = FontAwesomeIcons.eye.obs;

  RxBool rememberMe = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Padding(
        padding:
            EdgeInsets.only(top: 35.w, left: 31.w, right: 31.w, bottom: 0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: Image.asset(
                        "assets/images/fenixgradientblue.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    kSpacing,
                    kSpacing,
                    Text(AppLocalizations.of(context)!.signInAccount,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 21, shadows: [
                        Shadow(
                            color: dark.withOpacity(0.25),
                            offset: const Offset(0, 1),
                            blurRadius: 4)
                      ]),
                    ),
                    kSpacing,
                    kSpacing,
                    TextFieldWidget(
                      hint: AppLocalizations.of(context)!.email,
                      textController: _accountController.email,
                      validator: (value) => EmailValidator.validate(value!),
                    ),
                    kSpacing,
                    Obx(() => TextFieldWidget(
                        hint: AppLocalizations.of(context)!.password,
                        textController: _accountController.password,
                        obscureText: obscure.value,
                        suffix: InkWell(
                          onTap: (){
                            if(obscure.value == true){
                              obscure.value = false;
                              obscureIcon.value =  FontAwesomeIcons.eye;
                            }
                            else{
                              obscure.value = true;
                              obscureIcon.value =  FontAwesomeIcons.eyeSlash;
                            }
                          },
                          child: Obx(() => Icon(obscureIcon.value, color: primary,)),
                        ),

                        validator: (value) =>
                            PasswordValidator.validate(value!)),),
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Obx(() => Container(
                           decoration: depressNeumorph().copyWith(
                               color: rememberMe.value == true ? dark : Color(0xFFE4F0FA).withOpacity(0.9)
                           ),
                           child: SizedBox(
                             height: 25,
                             width: 25,
                             child: Theme(
                               data: ThemeData(
                                 unselectedWidgetColor:
                                 Colors.transparent, // Your color
                               ),
                               child: Obx(() => Checkbox(
                                 value: rememberMe.value,
                                 activeColor: dark,
                                 onChanged: (v) {
                                   print(v);
                                   rememberMe.value = v!;
                                 },
                               ),),
                             ),
                           )),),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _accountController.signIn();
                        }
                      },
                      child: ButtonWidget(title: AppLocalizations.of(context)!.signIn),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ResetPassword());
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
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      -3, -6), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.lock,
                                  color: Color(0xFF414B5A),
                                  size: 15,
                                ),
                                tinyH5Space(),
                                Text(
                                  AppLocalizations.of(context)!.forgotPassword,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: const Color(0xFF414B5A)
                                              .withOpacity(0.8),
                                          fontSize: 12.w,
                                          fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ResendVerificationMail());
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
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      -3, -6), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.verify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: const Color(0xFF414B5A)
                                          .withOpacity(0.8),
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: backButtonThree,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
