import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../onboarding/constants.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget(
      {Key? key, this.product, this.image, this.isNetwork = false})
      : super(key: key);
  final product, image, isNetwork;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.452,
              margin: EdgeInsets.symmetric(horizontal: 9.w),
              decoration: BoxDecoration(
                  color: const Color(0xFFDAE5F2),
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
                      offset:
                          const Offset(-3, -6), // changes position of shadow
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.455,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      image: isNetwork == true
                          ? DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover)
                          : DecorationImage(
                              image: AssetImage(
                                  image ?? "assets/images/house.png"),
                              fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.455,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: SizedBox(
                            height: 100.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product['title'] ??
                                      "Delivery info will  be here dg likseller offer sajncnask...",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 12.w,
                                          color: const Color(0xFF334669),
                                          fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  children: [
                                    RatingBar(
                                        initialRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 18.w,
                                        ignoreGestures: true,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(Icons.star,
                                                color: Colors.orange),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Colors.orange,
                                            ),
                                            empty: const Icon(
                                              Icons.star_outline,
                                              color: Colors.grey,
                                            )),
                                        onRatingUpdate: (value) {}),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "259 reviews.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 10.w,
                                              color: const Color(0xFF334669)
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "United State, Florida 3340",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 11.w,
                                              color: const Color(0xFF334669)
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.fire_truck),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Free Shipping",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 12.w,
                                              color: const Color(0xFF0F7D46),
                                              fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "17,000   so’m",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 15.w,
                                  color: const Color(0xFFCE242B),
                                  fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 7,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    color: white.withOpacity(0.6), shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: kTextBlackColor,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Button(btnText: "Edit Post"),
        Button(btnText: "See the Post"),
        Button(
          btnText: "Delete Post",
          textColor: Colors.white,
          btnColor: const Color(0xFFCE242B),
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  String btnText;
  Color? textColor;
  Color? btnColor;

  Button({Key? key, required this.btnText, this.textColor, this.btnColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 7.w),
      padding: EdgeInsets.symmetric(vertical: 5.w),
      decoration: BoxDecoration(
        color: btnColor ?? const Color(0xFFE4EFF9),
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(color: const Color(0xFf334669), width: 0.1),
        gradient: LinearGradient(
            colors: [
              btnColor ?? Colors.white,
              btnColor ?? const Color(0xFFDBE6F2).withOpacity(0.2),
              btnColor ?? const Color(0xFF8F9FAE).withOpacity(0.2),
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
            offset: const Offset(1, 0), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        btnText,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14.w,
            fontWeight: FontWeight.w800,
            color: textColor ?? kTextBlackColor),
      ),
    );
  }
}
