import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets/dialogs.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../../helpers/widgets/snack_bar.dart';
import '../auth_screens/create_profile.dart';
import '../onboarding/constants.dart';
import 'create_selling_post/create_store.dart';
import 'create_selling_post/selling_post.dart';
import 'edit_profile.dart';
import 'product_list.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find();
    final UserController userController = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: dark,
          icon: const Icon(Icons.add, color: background),
          onPressed: () {
            Get.to(() => CreateStore());
          },
          label: const Text('Add Store', style: TextStyle(color: background))),
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
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 27.w,
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
      body: Column(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios, color: white),
                ),
                Text(
                  "Stores",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: BODY_PADDING),
              child: Obx(() => storeController.isFetchingStore.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : storeController.storeList.isEmpty
                      ? Center(
                          child: InkWell(
                          onTap: () => Get.to(() => CreateStore()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_box, size: 30),
                              smallSpace(),
                              const Text('You do not have any store yet'),
                            ],
                          ),
                        ))
                      : ListView.separated(
                          itemBuilder: (c, i) {
                            print(storeController.storeList);
                            var item = storeController.storeList[i];
                            return InkWell(
                              onTap: () => (userController.getUser()!.address ==
                                          '' ||
                                      userController.getUser()!.mobileNumber ==
                                          '')
                                  ? CustomDialogs.showNoticeDialog(
                                      title: 'Sorry!',
                                      message:
                                          'Updated your profile to create selling',
                                      onClick: () {
                                        Get.to(() => EditProfile());
                                      })
                                  : Get.to(() => SellingPost(
                                      storeId: item['id'].toString(),
                                      storeName: item['name'].toString(),
                                      storeLocation:
                                          item['location'].toString())),
                              // onTap: ()=>Get.to(()=>ProductList(storeId:item['id'],storeName:item['name'],storeLocation:item['location'])),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4EFF9),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xFf334669),
                                      width: 0.1),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        const Color(0xFFDBE6F2)
                                            .withOpacity(0.2),
                                        const Color(0xFF8F9FAE)
                                            .withOpacity(0.2),
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
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.storefront,
                                      size: 45,
                                    ),
                                    smallHSpace(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item['name'].toString()),
                                          Text(
                                            item['location'].toString(),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right_outlined)
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (c, i) => smallSpace(),
                          itemCount: storeController.storeList.length)),
            ),
          )
        ],
      ),
    );
  }
}
