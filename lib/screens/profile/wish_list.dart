import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/dialogs.dart';
import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../../controller/store_controller.dart';
import '../home/home.dart';
import '../home/search.dart';
import '../onboarding/constants.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    userController.getWishList(userController.getToken());
    String token = userController.getToken();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            height() * 0.165),
        child: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/fenixmall_white.png",
                    color: white,
                    height: height() * 0.075,
                  ),
                ),
              ),
              tiny5Space(),
              Expanded(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    InkWell(
                      onTap: () => Get.to(() => const SearchScreen()),
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 0.050,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.w),
                          color: Colors.white,
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: 16.w,
                          ),
                          enabled: false,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.015),
                            hintText: "Search Fenix",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 15.w, color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFE4EFF9),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 8, 5),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: blue),
                  tinyHSpace(),
                  const Text('Your Wishlist'),
                ],
              ),
            ),
            const Divider(color: primary),
            SizedBox(
              height: 20.w,
            ),
            Obx(
              () => userController.isFetchingWishes.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : userController.wishList.isEmpty
                      ? empty('Wishlist')
                      : GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      MediaQuery.of(context).size.width * 0.5,
                                  childAspectRatio: 1 / 2.5,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0),
                          itemCount: userController.wishList.length,
                          itemBuilder: (context, i) {
                            var item = userController.wishList[i];
                            return InkWell(
                              onTap: () {},
                              child: wishedItem(item, i, userController, token),
                            );
                          }),
            ),
          ],
        ),
      ),
    );
  }

  wishedItem(product, index, UserController userController, token) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: height() * 0.42,
              width: width() * 0.452,
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
                    height: height() * 0.25,
                    width: width() * 0.455,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/house.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 10.w
                  ),
                  SizedBox(
                    height: height() * 0.15,
                    width: width() * 0.455,
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
                                  style: TextStyle(
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
                                      style: TextStyle(
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
                                      style: TextStyle(
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
                                      style: TextStyle(
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
                          style: TextStyle(
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
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10.w),
        Button(btnText: "See the Post"),
        Button(
          onTap: () {
            CustomDialogs.showNoticeDialog(
                message:
                    'Do you really want to remove this item from your wish list?\n\nYou won\'t see it here again',
                okText: 'Yes, remove',
                closeText: 'Cancel',
                onClick: () {
                  Get.back();
                  userController.deleteItemFromWishList(
                      token, (product['apartmentId'] != null) ? product['apartmentId']
                      : (product['productId'] != null) ? product['productId']
                      : product['vehicleId'],

                      (product['apartmentId'] != null) ? "apartment"
                          : (product['productId'] != null) ? "product"
                          : "car");
                });
          },
          btnText: "Delete Post",
          textColor: Colors.white,
          btnColor: const Color(0xFFCE242B),
        )
      ],
    );
  }
}
