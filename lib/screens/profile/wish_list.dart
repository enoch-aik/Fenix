import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.123),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF1A9AFF),
              const Color(0xFF54FADC),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: Image.asset(
                    "assets/images/fenix_c.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
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
                      height: MediaQuery.of(context).size.height * 0.050,
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
                      MediaQuery.of(context)
                          .size
                          .width *
                          0.5,
                      childAspectRatio: 1 / 2.7,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemCount:
                  userController.wishList.length,
                  itemBuilder: (context, i) {
                    var item = userController.wishList[i];
                    return InkWell(
                      onTap: () {

                      },
                      child:  ProductListWidget(
                          product: item,
                          isNetwork: item['media']!=null && item['media'].isNotEmpty,
                          image: item['media']!=null && item['media'].isNotEmpty
                              ? item['media'][0]['url']
                              : "assets/images/electronics.png"),
                    );
                  }),
            ),
            // SizedBox(
            //   height: 20.w,
            // ),
            // Padding(
            //     padding: EdgeInsets.all(14.w),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Your Post List",
            //           style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 17.w,
            //               fontWeight: FontWeight.w700),
            //         ),
            //         Text(
            //           "See all",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 13.w,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         )
            //       ],
            //     )),
            // GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //         maxCrossAxisExtent: 200,
            //         childAspectRatio: 1.3 / 1,
            //         crossAxisSpacing: 0,
            //         mainAxisSpacing: 0),
            //     itemCount: 9,
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemBuilder: (BuildContext ctx, index) {
            //       return Column(
            //         children: [
            //           Container(
            //             height: 66.w,
            //             width: MediaQuery.of(context).size.width * 0.3,
            //             alignment: Alignment.center,
            //             margin: EdgeInsets.symmetric(
            //                 horizontal: 10.w, vertical: 5.w),
            //             decoration: BoxDecoration(
            //               color: Color(0xFFE4EFF9),
            //               borderRadius: BorderRadius.circular(17.w),
            //               border:
            //                   Border.all(color: Color(0xFf334669), width: 0.1),
            //               gradient: LinearGradient(
            //                   colors: [
            //                     Colors.white,
            //                     Color(0xFFDBE6F2).withOpacity(0.2),
            //                     Color(0xFF8F9FAE).withOpacity(0.2),
            //                   ],
            //                   stops: [
            //                     0.0,
            //                     0.5,
            //                     1.0
            //                   ],
            //                   begin: FractionalOffset.topLeft,
            //                   end: FractionalOffset.bottomRight,
            //                   tileMode: TileMode.repeated),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.3),
            //                   spreadRadius: 0,
            //                   blurRadius: 5,
            //                   offset:
            //                       Offset(1, 0), // changes position of shadow
            //                 ),
            //                 BoxShadow(
            //                   color: Colors.white.withOpacity(0.4),
            //                   spreadRadius: 1,
            //                   blurRadius: 3,
            //                   offset:
            //                       Offset(1, 1), // changes position of shadow
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Text(
            //             "great house for...",
            //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                 fontSize: 11.w,
            //                 fontWeight: FontWeight.w300,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       );
            //     }),
          ],
        ),
      ),
    );
  }
}
