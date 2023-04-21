import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../onboarding/constants.dart';
import 'create_product.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key, required this.storeId}) : super(key: key);
  final String storeId;
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final StoreController _storeController = Get.find();
    // _storeController.getProducts(_userController.getToken(), storeId);
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: dark,
          icon: const Icon(Icons.add, color: background),
          onPressed: () {
            Get.to(() => CreateProduct(
                  storeId: storeId,
                  // storeId: 'clgoud7j70002vm0uhqm5oce4',
                ));
            //   clgouf3zx0004vm0u1aboektj
          },
          label:
              const Text('Add Product', style: TextStyle(color: background))),
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
                  "Products",
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
              child: Obx(() => _storeController.isFetchingProducts.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : _storeController.productList.isEmpty
                      ? Center(
                          child: InkWell(
                          onTap: () => Get.to(() => CreateProduct(
                                storeId: 'clgoud7j70002vm0uhqm5oce4',
                              )),
                          //   clgouf3zx0004vm0u1aboektj
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
                            print(_storeController.productList);
                            var item = _storeController.productList[i];
                            return Container(
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

                              // {id: clgqpdgnf0006v50ujfgdr8bi, title: Tap, storeId: clgqd4gq50006tl0u2kjmchrq, plan: Basic, category: Fresh, description: This is amazing, price: {amount: 1200000, discount: 20}, shipping: {price: 1500, details: Class on, Adriana , location: New York, shipping: true}, specifics: {size: 12, brand: Teas, color: Grey, category: Fresh, features: Very good, material: Mac, quantity: 5, condition: New, storageCapacity: 123}, date_created: 2023-04-21T15:25:02.476Z}]}
                              // flutter: [{id: clgqpdgnf0006v50ujfgdr8bi, title: Tap, storeId: clgqd4gq50006tl0u2kjmchrq, plan: Basic, category: Fresh, description: This is amazing, price: {amount: 1200000, discount: 20}, shipping: {price: 1500, details: Class on, Adriana , location: New York, shipping: true}, specifics: {size: 12, brand: Teas, color: Grey, category: Fresh, features: Very good, material: Mac, quantity: 5, condition: New, storageCapacity: 123}, date_created: 2023-04-21T15:25:02.476Z}

                              child: Row(
                                children: [
                                  Image.asset('assets/images/headset.png'),
                                  smallHSpace(),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['title']),
                                        Row(
                                          children: const [
                                            Icon(Icons.star,
                                                color: Colors.orange, size: 15),
                                            Icon(Icons.star,
                                                color: Colors.orange, size: 15),
                                            Icon(Icons.star_border,
                                                color: Colors.orange, size: 15),
                                            Icon(Icons.star_border,
                                                color: Colors.orange, size: 15),
                                            Icon(Icons.star_border,
                                                color: Colors.orange, size: 15),
                                          ],
                                        ),
                                        Text(
                                          '${item['price']['amount']} so\'m',
                                          style: const TextStyle(fontSize: 16,fontWeight:FontWeight.bold,color: blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_outlined)
                                ],
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
