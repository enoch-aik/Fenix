import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const double BODY_PADDING = 20.0;
const double TOP_PADDING = 35.0;
const double DIALOG_RADIUS = 30.0;
const double MODAL_RADIUS = 20.0;
const double MID_RADIUS = 10.0;
const double BUTTON_RADIUS = 5.0;
const double INPUT_FIELD_RADIUS = 3.0;

double height() => Get.height;
double width() => Get.width;

smallHSpace() => const SizedBox(width: 20);
tinyHSpace() => const SizedBox(width: 10);
smallSpace() => const SizedBox(height: 20);
tinySpace() => const SizedBox(height: 10);
tiny15Space() => const SizedBox(height: 15);
tiny5Space() => const SizedBox(height: 5);
tinyH5Space() => const SizedBox(width: 5);
mediumSpace() => const SizedBox(height: 30);
mediumHSpace() => const SizedBox(width: 30);

verticalSpace(factor) => SizedBox(height: height() * factor);
horizontalSpace(factor) => SizedBox(width: width() * factor);



