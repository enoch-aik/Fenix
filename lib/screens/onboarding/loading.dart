import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key,  this.navigateScreen}) : super(key: key);
  final Widget? navigateScreen;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   widget.navigateScreen!=null?
    //   Get.off(() => widget.navigateScreen):Get.back();
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 78.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.height * 0.4,
                  height: Get.width * 0.9,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/fenix_loading.png'))),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [Color(0xFF28D7AD)],
                      ),
                    ),
                    Text(
                      "Developed by Khasan.A",
                      style: TextStyle(
                          color: Colors.grey.shade800, fontSize: 16.w),
                    ),
                  ],
                )
              ],
            ),
          ),
          const BottomHillsWidget()
        ],
      ),
    );
  }
}
