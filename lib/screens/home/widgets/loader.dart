import 'package:fenix/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.blueGrey.withOpacity(0.2),
        highlightColor: Colors.blueGrey.withOpacity(0.1),
        enabled: true,
        child: GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              childAspectRatio: 1/ 2,
              mainAxisSpacing: 25,
              crossAxisSpacing: 0),
          itemCount: 6,
          itemBuilder: (context, index) => const BannerPlaceholder(),
        ));
  }
}

class LineLoader extends StatelessWidget {
  const LineLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.yellow.withOpacity(0.8),
        highlightColor: Colors.red.withOpacity(0.7),
        enabled: true,
        child: Container(
          height: 5.w,
          width: width(),
          decoration:  const BoxDecoration(
            color: Colors.yellow,
          ),
        ));
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(-3, -6), // changes position of shadow
            ),
          ]),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 28.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 18.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
