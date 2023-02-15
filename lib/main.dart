import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/onboarding_one.dart';
import 'package:fenix/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390,844),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Fenix',
        theme: theme,
        home: SplashScreen(),
      ),
    );
  }
}
