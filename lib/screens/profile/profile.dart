import 'package:fenix/controller/store_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/snack_bar.dart';
import 'package:fenix/screens/profile/selling_list.dart';
import 'package:fenix/screens/profile/wish_list.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/widgets/dialogs.dart';
import '../../helpers/widgets/logout_card_widget.dart';
import '../auth_screens/create_profile.dart';
import '../onboarding/constants.dart';
import 'account/account.dart';
import 'create_selling_post/selling_post.dart';
import 'edit_profile.dart';
import 'message.dart';
import 'store_lists.dart';
import 'subscribe.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.find();

  List title = [
    "Your Account",
    "Your Message",
    "Create Selling Post",
    "Subscribe",
    "Your Wishlist",
    "Your Stores",
    "Your Selling",
    "Language",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 46.h,
            child: Image.asset(
              "assets/images/fenixWhite2.png",
              fit: BoxFit.fill,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 27.w,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 27.w,
                  ),
                  InkWell(
                    onTap: () async {
                      Get.bottomSheet(LogoutCard());
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 27.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2(
                const Color(0xFF46E0C4),
                const Color(0xFF59B5C0),
              ),
            ),
          )),
      body: Container(
        color: const Color(0xFFE4EFF9),
        child: ListView(
          children: [
            Container(
              height: 50.w,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(bottom: 20.w),
              decoration: BoxDecoration(
                gradient: gradient2(
                  const Color(0xFF41F0D1),
                  const Color(0xFF4A9A9E),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, Khasan",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.w,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(2, 2))
                        ]),
                  ),
                  Image.asset(
                    "assets/images/icons/personIcon.png",
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
            ),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) Get.to(() => const Account());
                      if (index == 1) Get.to(() => const Messages());
                      if (index == 2) {
                        print('=======');
                        print( _storeController.storeList[0]['id'].toString());
                        (_userController.getUser()!.address == '' ||
                                _userController.getUser()!.mobileNumber == '')
                            ? CustomDialogs.showNoticeDialog(
                                title: 'Sorry!',
                                message:
                                    'Updated your profile to create selling',
                                onClick: () {
                                  Get.to(() => EditProfile());
                                })
                            : Get.to(() => SellingPost(
                                  storeId: _storeController.storeList[0]['id'].toString(),
                                  storeName: _storeController.storeList[0]
                                      ['name'].toString(),
                                  storeLocation: _storeController.storeList[0]
                                      ['location'].toString(),
                                ));
                      }
                      if (index == 3) Get.to(() => const Subscribe());
                      if (index == 4) Get.to(() => const WishList());
                      if (index == 5) Get.to(() => const StoreList());

                      if (index == 6) Get.to(() => const SellingList());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4EFF9),
                        borderRadius: BorderRadius.circular(17.w),
                        border: Border.all(
                            color: const Color(0xFf334669), width: 0.1),
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              const Color(0xFFDBE6F2).withOpacity(0.2),
                              const Color(0xFF8F9FAE).withOpacity(0.2),
                            ],
                            stops: const [
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
                            offset: const Offset(
                                1, 0), // changes position of shadow
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(
                                1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        title[index],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15.w, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }),
            Divider(
              color: const Color(0xFF1994F5).withOpacity(0.22),
              thickness: 5,
              height: 50.w,
            ),
            Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recently Viewed Items",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.w,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.3 / 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: [
                      Container(
                        height: 66.w,
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4EFF9),
                          borderRadius: BorderRadius.circular(17.w),
                          border: Border.all(
                              color: const Color(0xFf334669), width: 0.1),
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                const Color(0xFFDBE6F2).withOpacity(0.2),
                                const Color(0xFF8F9FAE).withOpacity(0.2),
                              ],
                              stops: const [
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
                              offset: const Offset(
                                  1, 0), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Iphone 14 Pro",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11.w,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 20.w,
            ),
            Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Post List",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.w,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.3 / 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: [
                      Container(
                        height: 66.w,
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4EFF9),
                          borderRadius: BorderRadius.circular(17.w),
                          border: Border.all(
                              color: const Color(0xFf334669), width: 0.1),
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                const Color(0xFFDBE6F2).withOpacity(0.2),
                                const Color(0xFF8F9FAE).withOpacity(0.2),
                              ],
                              stops: const [
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
                              offset: const Offset(
                                  1, 0), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "great house for...",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11.w,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
