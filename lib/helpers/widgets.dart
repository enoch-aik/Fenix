import 'package:fenix/screens/onboarding/auth_board.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

class BottomHillsWidget extends StatelessWidget {
  const BottomHillsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bottomHills.png"),
                fit: BoxFit.fitWidth)),
      ),
    );
  }
}

ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
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
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color(0xFF31456A).withOpacity(0.8),
                  fontSize: 15.w),
            ),
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
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              height: 25,
              width: 25,
              child: Center(
                  child: Icon(Icons.arrow_forward_ios,
                      size: 12.w, color: Colors.red)),
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
            ),
          )
        ],
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

class WelcomeCards extends StatelessWidget {
  const WelcomeCards(
      {Key? key,
      required this.pageController,
      required this.title,
      required this.image})
      : super(key: key);

  final PageController pageController;
  final String title;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 81.w, horizontal: 17.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 21.w),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.68,
                    width: MediaQuery.of(context).size.width,
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
                      children: [
                        Image.asset(
                          "assets/images/lottieAnimOne.png",
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/images/lottieAnimTwo.png",
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/images/lottieAnimThree.png",
                          fit: BoxFit.fill,
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
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            } else {
                              Get.back();
                            }
                          },
                          child: backButton,
                        ),
                        InkWell(
                          onTap: () {
                            if (pageController.page != 2.0) {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
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
                alignment: Alignment.bottomCenter,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
            child: child,
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EDF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0.5, 0.1), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(-0.5, -0.5), // changes position of shadow
                ),
              ],
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
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
            child: child,
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3EDF7),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0.5, 0.1), // changes position of shadow
                ),
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(-0.5, -0.5), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  String hint;
  Icon? prefixIcon;
  TextEditingController? textController;
  String? Function(String?)? validator;
  bool? enabled;

  TextFieldWidget(
      {Key? key,
      required this.hint,
      this.prefixIcon,
      this.enabled,
      this.textController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.w),
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
        style: TextStyle(
          fontSize: 16.w,
        ),
        enabled: enabled,
        validator: validator,
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 15.w, color: Colors.grey.shade400),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}

List lottieSlides = [
  Image.asset("assets/images/lottieAnimOne.png"),
  Image.asset("assets/images/lottieAnimOne.png"),
  Image.asset("assets/images/lottieAnimOne.png"),
];

// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),
