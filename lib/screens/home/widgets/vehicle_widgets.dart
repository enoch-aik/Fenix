import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../onboarding/constants.dart';

class VehicleWidget extends StatelessWidget {
  const VehicleWidget({Key? key, this.actionText, this.vehicle})
      : super(key: key);
  final String? actionText;
  final vehicle;

  @override
  Widget build(BuildContext context) {
    print(vehicle);
    return vehicle == null
        ? const Text('Empty')
        : Container(
            height: 279.h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 130.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.w),
                color: Colors.red,
                image: const DecorationImage(
                    image: AssetImage("assets/images/car copy.jpg"),
                    fit: BoxFit.cover)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (actionText == null)
                  Positioned(
                    right: 0,
                    child: Image.asset("assets/images/icons/favorite_icon.png"),
                  ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset("assets/images/notch.png"),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Text(
                          "⭐ 4.1 (1,648)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: -130,
                  left: 0.5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: 169.h,
                        width: MediaQuery.of(context).size.width * 0.92,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.w),
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          children: [
                            Container(
                                height: 71.h,
                                width: MediaQuery.of(context).size.width * 0.92,
                                padding: EdgeInsets.only(top: 7.w, left: 10.w),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF334669),
                                      ],
                                      stops: [
                                        0.0,
                                        1.0
                                      ],
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      tileMode: TileMode.repeated),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${vehicle['title'] ?? "Chicago,IL Des Planes 60018"}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Title:    ${vehicle['description'] ?? 'House 3 bedroom 2 bathroom has pool , garage, AC, heater,TV, shower '}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 12.w,
                                              fontWeight: FontWeight.w700),
                                    )
                                  ],
                                )),
                            Container(
                                height: 96.h,
                                width: MediaQuery.of(context).size.width * 0.92,
                                padding: EdgeInsets.only(
                                    top: 12.w, left: 10.w, right: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(13.w),
                                      bottomRight: Radius.circular(13.w)),
                                  color: const Color(0xFFE4EFF9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 9,
                                      offset: const Offset(
                                          3, 4), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 9,
                                      offset: const Offset(
                                          -3, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "COST",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF334669),
                                                      fontSize: 10.5.w,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 7.w,
                                            ),
                                            Text(
                                              "${vehicle['price']} so’m",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF334669),
                                                      fontSize: 10.5.w,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "MILEAGE",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF334669),
                                                      fontSize: 10.5.w,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 7.w,
                                            ),
                                            Text(
                                              "${vehicle['specifics']['mileage']}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFF334669),
                                                      fontSize: 10.5.w,
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "AVAILABLE",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: const Color(
                                                              0xFF334669),
                                                          fontSize: 10.5.w,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 7.w,
                                                ),
                                                Text(
                                                  "${vehicle['specifics']['brand']} - ${vehicle['specifics']['model']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: const Color(
                                                              0xFF334669),
                                                          fontSize: 10.5.w,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  vehicle['specifics']
                                                          ['amenities']
                                                      .length,
                                                  (index) => Text(
                                                        vehicle['specifics']
                                                                ['amenities']
                                                            [index],
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ))
                                              // [
                                              //   Image.asset("assets/images/icons/bathtub-outline.png"),
                                              //   Image.asset("assets/images/icons/pool.png"),
                                              //   Image.asset("assets/images/icons/television.png"),
                                              //   Image.asset("assets/images/icons/billiards.png"),
                                              //   Image.asset("assets/images/icons/car-3-plus.png"),
                                              //   Image.asset("assets/images/icons/thermometer-plus.png"),
                                              //   Image.asset("assets/images/icons/snowflake-thermometer.png"),
                                              //   Image.asset("assets/images/icons/shower-head.png")
                                              // ],
                                              ),
                                        ),
                                        Container(
                                          height: 28.w,
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                              gradient: gradient(
                                                  const Color(0xFF9DDFF3),
                                                  const Color(0xFf0F55E8)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8.53.w)),
                                          child: Center(
                                            child: Text(
                                              actionText ?? "Book Now",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 13.5.w,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          );
  }
}
