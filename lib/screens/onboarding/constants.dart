import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

Widget kSpacing = SizedBox(height: 16.w,);
Widget kLargeSpacing = SizedBox(height: 52.w,);

Color kTextBlackColor = Color(0xFF334669);


const Color scaffoldBg1 = Color(0xff424750);
const Color scaffoldBg2 = Color(0xff202326);
const Color darkText = Color(0xff7F8489);
const Color lightText = Color(0xffFDFDFD);
const Color kBlueColor = Color(0xff0081C9);

Widget backButton = Image.asset("assets/images/backButton.png");
Widget backButtonTwo = Image.asset("assets/images/backButton2.png");
Widget backButtonThree = Image.asset("assets/images/backButton3.png");
Widget forwardButton = Image.asset("assets/images/forwardButton.png");


LinearGradient gradient(a,b) {
  return LinearGradient(
      colors: [
        a,b
      ],
      stops: [0.0, 1.0],
      begin: FractionalOffset.topLeft,
      end: FractionalOffset.bottomRight,
      tileMode: TileMode.repeated
  );
}

LinearGradient gradient2(a,b) {
  return LinearGradient(
      colors: [
        a,b
      ],
      stops: [0.0, 1.0],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
      tileMode: TileMode.repeated
  );
}


LinearGradient gradient3(a,b) {
  return LinearGradient(
      colors: [
        a,b
      ],
      stops: [0.0, 1.0],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      tileMode: TileMode.repeated
  );
}


LinearGradient invertedGradient = LinearGradient(
    colors: [
      Color(0xFF54FADC),
      Color(0xFF1A9AFF),
    ],
    stops: [0.0, 1.0],
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
    tileMode: TileMode.repeated
);


LinearGradient gradientInverted(a,b) {
  return LinearGradient(
      colors: [
        a,b
      ],
      stops: [0.0, 1.0],
      begin: FractionalOffset.topLeft,
      end: FractionalOffset.bottomRight,
      tileMode: TileMode.repeated
  );
}



const fullAngleInRadians = math.pi * 2;

double radius = 90;
double strokeWidth = 40;

double normalizeAngle(double angle) => normalize(angle, fullAngleInRadians);

Offset toPolar(Offset center, double radians, double radius) =>
    center + Offset.fromDirection(radians, radius);

double normalize(double value, double max) => (value % max + max) % max;

double toAngle(Offset position, Offset center) => (position - center).direction;

double toRadian(double value) => (value * math.pi) / 180;

double radianToAngle(double radians) => (2 * math.pi * radians);