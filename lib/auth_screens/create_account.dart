import 'package:fenix/const.dart';
import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/helpers/validator.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/snackBar.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  PageController pageController = PageController();
  final AccountController _accountController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset(
                    "assets/images/logoFrame.png",
                    fit: BoxFit.fill,
                  ),
                ),
                kSpacing,
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3EDF7),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(-1, -1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Create New Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 21.w, shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 1),
                                  blurRadius: 4)
                            ]),
                          ),
                          kSpacing,
                          kSpacing,
                          TextFieldWidget(
                            hint: "First Name",
                            textController: _accountController.firstName,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Last Name",
                            textController: _accountController.lastName,
                            validator: (value) =>
                                UsernameValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "Email",
                            textController: _accountController.email,
                            validator: (value) =>
                                EmailValidator.validate(value!),
                          ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "Phone Number",
                          // ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "Date of Birth",
                          // ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "Address",
                          // ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "Street Name",
                          // ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "City",
                          // ),
                          // kSpacing,
                          // TextFieldWidget(
                          //   hint: "Country",
                          // ),
                          kSpacing,
                          TextFieldWidget(
                            hint: "New Password",
                            textController: _accountController.password,
                            validator: (value) =>
                                PasswordValidator.validate(value!),
                          ),
                          kSpacing,
                          TextFieldWidget(
                              hint: "Re-enter Password",
                              validator: (value) {
                                if (value != _accountController.password.text) {
                                  return "Password does not match";
                                }
                                return null;
                              }),
                          kSpacing,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.w),
                                  color:
                                      const Color(0xFFE4F0FA).withOpacity(0.9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.9),
                                      spreadRadius: -3,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          3, 6), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                          margin: const EdgeInsets.all(3),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xFF797979)
                                                  .withOpacity(0.5)),
                                          child: Center(
                                              child: Icon(
                                            Icons.male,
                                            color: kTextBlackColor,
                                          ))),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 15.w),
                                      hintText: "Male",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 15.w,
                                              color: Colors.grey.shade400)),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.w),
                                  color:
                                      const Color(0xFFE4F0FA).withOpacity(0.9),
                                  boxShadow: [
                                    const BoxShadow(
                                      color: Colors.grey,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.9),
                                      spreadRadius: -3,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          3, 6), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                          height: 30,
                                          width: 30,
                                          margin: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: const Color(0xFF797979)
                                                  .withOpacity(0.5)),
                                          child: Center(
                                              child: Icon(
                                            Icons.female,
                                            color: kTextBlackColor,
                                          ))),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 15.w),
                                      hintText: "Female",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 15.w,
                                              color: Colors.grey.shade400)),
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
                                  _accountController.signUp();
                                }else{
                                  CustomSnackBar.failedSnackBar('Error', 'Ensure that all required fields are filled');
                                }
                                // Get.to(() => Agreement());
                              },
                              child: ButtonWidget(title: "Next")),
                          verticalSpace(0.04),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: backButtonThree,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
