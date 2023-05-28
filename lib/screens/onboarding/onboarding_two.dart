
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

import 'auth_board.dart';
import 'constants.dart';

class OnboardingTwo extends StatelessWidget {

 OnboardingTwo({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [

          WelcomeCards(pageController: pageController, title: "Easy Communication and Deals",
              image: Image.asset("assets/images/lottieAnimOne.png",fit: BoxFit.fill,)),



          // ButtonWidget(title: "Next",),

          Positioned(bottom:-50, child:  BottomHillsWidget())
        ],
      ),
    );
  }
}



// margin: EdgeInsets.symmetric(vertical: 17.w, horizontal: 24.w),

