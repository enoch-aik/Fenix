import 'package:fenix/const.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../onboarding/constants.dart';
import 'create_store.dart';
import 'product_list.dart';

class StoreList extends StatelessWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // accountContainer('Your Product Information', onTap: () {
    //   Get.to(() => CreateProduct(
    //     storeId: 'clgoud7j70002vm0uhqm5oce4',
    //   ));
    //   clgouf3zx0004vm0u1aboektj
    // }),
    // tinySpace(),

    final StoreController _storeController = Get.find();
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
              child: Obx(() => _storeController.isFetchingStore.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : _storeController.storeList.isEmpty
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
                            print(_storeController.storeList);
                            var item = _storeController.storeList[i];
                            return InkWell(
                              onTap: ()=>Get.to(()=>ProductList(storeId:item['id'])),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE4EFF9),
                                  borderRadius: BorderRadius.circular(10),
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
                                          Text(item['name']),
                                          Text(
                                            item['location'],
                                            style: const TextStyle(fontSize: 14),
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
                          itemCount: _storeController.storeList.length)),
            ),
          )
        ],
      ),
    );
  }
}
