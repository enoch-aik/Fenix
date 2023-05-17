import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../onboarding/constants.dart';
import 'bar_chart.dart';
import 'chart.dart';
import '../../theme.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            height() * 0.2),
        child: Container(
          decoration: BoxDecoration(
              gradient: gradient(
                const Color(0xFF691232),
                const Color(0xFF1770A2),
              ),
              border:
                  Border(bottom: BorderSide(color: Colors.purple, width: 2))),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/fenix_c.png",
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.050,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.w),
                  color: Colors.white,
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 16.w,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    hintText: "Search Fenix",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 17.w, color: Colors.grey.shade500),
                    suffixIcon: Icon(Icons.search, size: 30.w),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.072,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    MenuTitle(
                      icon: "Dacha.png",
                      title: "Dacha",
                      color: white,
                    ),
                    MenuTitle(
                      icon: "houseRental.png",
                      title: "House Rental",
                      color: white,
                    ),
                    MenuTitle(
                      icon: "apartment.png",
                      title: "Apartment",
                      color: white,
                    ),
                    MenuTitle(
                      icon: "carRental.png",
                      title: "Car Rental",
                      color: white,
                    ),
                    MenuTitle(
                      icon: "storeRental.png",
                      title: "Store Rental",
                      color: white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 5.w),
            decoration: neumorph().copyWith(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(2, -2),
                      blurRadius: 5),
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(-2, 2)),
                ],
                // border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'Tez Orada!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20.w, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          Container(
              height: Get.height * 0.24,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              decoration: neumorph(),
              child: LineGraph()),
          SizedBox(height: 10),
          Container(
              height: Get.height * 0.22,
              width: width() * 0.9,
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              child: BarChartScreen()),
        ],
      ),
    );
  }

  BoxDecoration neumorph() {
    return BoxDecoration(
      color: Color(0xFFE4EFF9),
      borderRadius: BorderRadius.circular(17.w),
      border: Border.all(color: Color(0xFf334669), width: 0.1),
      gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xFFDBE6F2).withOpacity(0.2),
            Color(0xFF8F9FAE).withOpacity(0.2),
          ],
          stops: [
            0.0,
            0.5,
            1.0
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          tileMode: TileMode.repeated),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0,
          blurRadius: 5,
          offset: Offset(1, 0), // changes position of shadow
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(1, 1), // changes position of shadow
        ),
      ],
    );
  }
}
