import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'theme.dart';

BoxDecoration depressNeumorph() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    color: const Color(0xFFE4F0FA).withOpacity(0.9),
    border: Border.all(color: white.withOpacity(0.8)),
    boxShadow: [
      const BoxShadow(color: Colors.grey),
      BoxShadow(
        color: Colors.white.withOpacity(0.9),
        spreadRadius: -3,
        blurRadius: 3,
        offset: const Offset(3, 5), // changes position of shadow
      ),
    ],
  );
}

BoxDecoration depressNeumorphDark() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    // color: const Color(0xFFE4F0FA).withOpacity(0.9),
    // border: Border.all(color: white.withOpacity(0.8)),
    boxShadow: [
      BoxShadow(color: Colors.grey.withOpacity(0.3)),
      BoxShadow(
        color: Color(0xFFE4F0FA).withOpacity(0.9),
        spreadRadius: -1,
        blurRadius: 2,
        offset: const Offset(1, 1), // changes position of shadow
      ),
    ],
  );
}

BoxDecoration shadow() {
  return BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(10.w),
      boxShadow: <BoxShadow>[
        BoxShadow(color: lightGrey.withOpacity(0.3), offset: Offset(1, 2))
      ]);
}
