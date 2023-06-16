import 'dart:io';

import 'package:fenix/const.dart';
import 'package:fenix/screens/onboarding/auth_board.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomHillsWidget extends StatelessWidget {
  const BottomHillsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Container(
    //     height: 120,
    //     width: MediaQuery.of(context).size.width,
    //     decoration: const BoxDecoration(
    //         image: DecorationImage(
    //             image: AssetImage("assets/images/bottomHills.png"),
    //             fit: BoxFit.fitWidth)),
    //   ),
    // );

    return Image.asset("assets/images/bottomHills.png",
        width: width(), fit: BoxFit.fill);
  }
}

ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ThemeData()
      .colorScheme
      .copyWith(primary: primary, background: white, error: blue),
  backgroundColor: const Color(0xFFE4F0FA),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20,
      color: Color(0xFF31456A),
      fontFamily: "Lato",
    ),
    bodyText2: TextStyle(
        fontSize: 20,
        color: Color(0xFF31456A),
        fontFamily: "Lato",
        fontWeight: FontWeight.bold),
  ),
);

class ButtonWidget extends StatelessWidget {
  String title;
  Color color;

  ButtonWidget({
    Key? key,
    required this.title,
    this.color = const Color(0xFFE3EDF7),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.5.w),
      child: Stack(
        children: [
          Container(
            height: 37.w,
            width: 185.w,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.w),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
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
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color(0xFF31456A).withOpacity(0.8),
                  fontSize: 15.w),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: const Color(0xFFE3EDF7),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: const Offset(2, 1), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(-3, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: Icon(Icons.arrow_forward_ios,
                      size: 12.w, color: Colors.red)),
            ),
          )
        ],
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String? title;
  final onPress;
  final color;

  const DefaultButton({
    Key? key,
    this.title,
    this.onPress,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, color: white)),
        ),
        decoration: BoxDecoration(
            color: color ?? lightGreen,
            boxShadow: const [
              BoxShadow(
                spreadRadius: 0.5,
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(4, 4),
                blurRadius: 6,
              ),
              BoxShadow(
                spreadRadius: 0.5,
                color: Color.fromRGBO(255, 255, 255, 1),
                offset: Offset(-4, -4),
                blurRadius: 6,
              )
            ],
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String? title;
  final onPress;
  final color;

  const TransparentButton({
    Key? key,
    this.title,
    this.onPress,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16, color: primary)),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: primary),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class SwipeToggleButton extends StatelessWidget {
  Widget child;

  SwipeToggleButton({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48.w,
        width: 48.w,
        decoration: BoxDecoration(
            color: const Color(0xFFE3EDF7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 6,
                blurRadius: 12,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Center(child: child));
  }
}

class WelcomeCards extends StatefulWidget {
  const WelcomeCards({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<WelcomeCards> createState() => _WelcomeCardsState();
}

class _WelcomeCardsState extends State<WelcomeCards> {
  int selectedPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.w, 81.w, 17.w, 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 20.w),
          Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 10.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 36.w, horizontal: 15.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(0.511), width: 0.85),
                      borderRadius: BorderRadius.circular(8.53.w),
                      color: const Color(0xFFEBF2F9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
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
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (v) {
                        setState(() {
                          selectedPage = v;
                        });
                      },
                      children: [
                        Image.asset(
                          "assets/images/screen 1.png",
                          fit: BoxFit.fitWidth,
                        ),
                        Image.asset(
                          "assets/images/screen 2.png",
                          fit: BoxFit.fitWidth,
                        ),
                        Image.asset(
                          "assets/images/screen 3.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 17.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (pageController.page != 0.0) {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            } else {
                              Get.back();
                            }
                          },
                          child: backButton,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3,
                              (index) => Container(
                                    height: 13,
                                    width: 13,
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          selectedPage == index ? grey : light,
                                    ),
                                  )),
                        ),
                        InkWell(
                          onTap: () {
                            if (pageController.page != 2.0) {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            } else {
                              Get.to(() => AuthBoard());
                            }
                          },
                          child: forwardButton,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetsPad extends StatelessWidget {
  Widget child;

  WidgetsPad({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
        child: Center(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            // constraints: BoxConstraints(
            //   maxHeight: MediaQuery.of(context).size.height * 0.72,
            // ),
            margin: EdgeInsets.only(top: 40.w),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EDF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0.8, 0.5), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(-1, -1), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(13.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE3EDF7),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset:
                        const Offset(0.5, 0.1), // changes position of shadow
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(-0.5, -0.5), // changes position of shadow
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomWidgetsPad extends StatelessWidget {
  Widget child;

  CustomWidgetsPad({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 24.w),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EDF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0.8, 0.5), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(-1, -1), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(13.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE3EDF7),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset:
                        const Offset(0.5, 0.1), // changes position of shadow
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(-0.5, -0.5), // changes position of shadow
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentTextFieldWidget extends StatelessWidget {
  String label;
  TextEditingController? textController;
  String? Function(String?)? validator;
  TextInputType? keyboardType;

  PaymentTextFieldWidget(
      {Key? key,
      required this.label,
      this.keyboardType,
      this.textController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: TextField(
        controller: textController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.aBeeZee(
              color: dark, fontWeight: FontWeight.w400, fontSize: 15.w),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: dark.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.w)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: dark.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.w)),
          fillColor: const Color(0xFFDAE5F2),
          filled: true,
          labelText: label,
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  String hint;
  Widget? prefixIcon;
  Widget? suffix;
  TextEditingController? textController;
  String? Function(String?)? validator;
  bool? enabled;
  bool obscureText;
  int maxLine;
  TextInputType? keyboardType;
  Function()? onTap;
  List<TextInputFormatter>? inputFormatters;

  TextFieldWidget(
      {Key? key,
      required this.hint,
      this.prefixIcon,
      this.suffix,
      this.obscureText = false,
      this.enabled,
      this.maxLine = 1,
      this.textController,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFE4F0FA).withOpacity(0.9),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            spreadRadius: -3,
            blurRadius: 3,
            offset: const Offset(3, 5), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 18.w,
            ),
        onTap: onTap,
        maxLines: maxLine,
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        controller: textController,
        obscureText: obscureText,
        cursorColor: primary,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          hintText: hint,
          // labelText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16.w, color: Colors.grey.shade400),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16.w, color: Colors.grey.shade400),
          prefixIcon: prefixIcon,
          suffix: suffix,
        ),
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  String store;
  List<String>? list;
  List<DropdownMenuItem<String>>? items;
  Function(String?)? onChanged;

  DropDownWidget(
      {this.list, this.items, this.onChanged, this.store = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFE4F0FA).withOpacity(0.9),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            spreadRadius: -3,
            blurRadius: 3,
            offset: const Offset(3, 5), // changes position of shadow
          ),
        ],
      ),
      child: DropdownButton(
          value: store.isEmpty ? list![0] : store,
          underline: Container(),
          menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          itemHeight: 50,
          items: items,
          onChanged: onChanged),
    );
  }
}

Widget backArrow() {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: (Platform.isIOS)
        ? Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 29.w,
          )
        : Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 29.w,
          ),
  );
}

List lottieSlides = [
  Image.asset("assets/images/lottieAnimOne.png"),
  Image.asset("assets/images/lottieAnimOne.png"),
  Image.asset("assets/images/lottieAnimOne.png"),
];

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
