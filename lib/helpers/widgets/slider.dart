import 'dart:math' as math;

import 'package:fenix/helpers/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/onboarding/constants.dart';

class ACControl extends StatefulWidget {
  final ValueChanged<double> onTempChanged;
  final ValueNotifier<bool> acState;

  const ACControl({
    Key? key,
    required this.acState,
    required this.onTempChanged,
  }) : super(key: key);

  @override
  State<ACControl> createState() => _ACControlState();
}

class _ACControlState extends State<ACControl> {
  Offset initialOffset = Offset.zero;

  double currentAngle = 0.0012350285539897143;

  double startAngle = toRadian(-90);

  double totalAngle = toRadian(360);

  int temperature = 16;

  @override
  Widget build(BuildContext context) {
    Size sliderSize = Size(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.width * 0.2);

    Size canvasSize = Size(sliderSize.width, sliderSize.width - 35);
    Offset center = canvasSize.center(Offset.zero);
    //TODO: MAKE POSITION RESPONSIVE
    Offset knobPos = toPolar(
        center - Offset(strokeWidth + 6.5, -strokeWidth + 74.5),
        currentAngle + startAngle,
        radius);

    return ValueListenableBuilder(
        valueListenable: widget.acState,
        builder: (context, acState, _) {
          return Stack(
            children: [
              CustomPaint(
                size: canvasSize,
                painter: SliderPainter(
                  startAngle: -1.56,
                  currentAngle: 5.2,
                ),
                child: Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: KText(
                  '95%',
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 23.sp,
                ),
              ),
            ],
          );
        });
  }

  getTemperature(double radians) {
    double addedTemp = radians * (180 / math.pi) / 360 * 18;
    int newTemperature = 16 + addedTemp.toInt();
    setState(() {
      temperature = newTemperature;
    });
  }
}

class SliderPainter extends CustomPainter {
  final double startAngle;
  final double currentAngle;

  SliderPainter({required this.startAngle, required this.currentAngle});

  @override
  void paint(Canvas canvas, Size size) {
    const int meterPoints = 8;
    const int spaceLength = 40;

    double startOfArcInDegree = toRadian(90);

    double meterLength = (360 - (meterPoints * spaceLength)) / meterPoints;

    if (meterLength <= 0) {
      meterLength = 360 / spaceLength - 1;
    }

    Offset center = size.center(Offset.zero);
    Rect meterRect = Rect.fromCircle(center: center, radius: radius + 40);

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    //Painter for the temperature slider
    var tempPaint = Paint()
      ..color = const Color(0xff50CAFF)
    //..shader = SweepGradient(colors: colors).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;


    //add all meters around the circle
    for (int i = 0; i < meterPoints - 1; i++) {
      canvas.drawArc(
        rect,
        startAngle,
        math.pi * 2,
        false,
        Paint()..color = Color(0xFFD6E3F3)
          ..style = PaintingStyle.fill
          ..strokeWidth = strokeWidth,
      );
      //
      // canvas.drawArc(
      //     meterRect,
      //     toRadian(startOfArcInDegree + 135),
      //     toRadian(1),
      //     false,
      //     Paint()
      //       ..color = currentAngle >= toRadian(startOfArcInDegree + 45)
      //           ? kBlueColor
      //           : const Color(0xff15171C)
      //       ..strokeWidth = 10
      //       ..style = PaintingStyle.stroke);
      startOfArcInDegree += meterLength + spaceLength;
    }
    canvas.drawArc(
      rect,
      startAngle,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 15,
    );

    canvas.drawArc(
        rect,
        startAngle,
        math.pi * 2,
        false,
        Paint()
          ..color = Color(0xFFD6E3F3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
    canvas.drawArc(rect, startAngle, currentAngle, false, tempPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


Widget acControl() => Container(
  height: 35,
  width: 35,
  decoration: BoxDecoration(
      color: kBlueColor,
      shape: BoxShape.circle,
      border: Border.all(color: scaffoldBg2, width: 16.0)),
);