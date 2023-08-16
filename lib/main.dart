import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/account_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Fenix',
        theme: theme,
        onInit: () {
          Get.put(AccountController());
        },
        transitionDuration: const Duration(milliseconds: 350),
        defaultTransition: Transition.rightToLeftWithFade,
        home: const SplashScreen(),
      ),
    );
  }
}
