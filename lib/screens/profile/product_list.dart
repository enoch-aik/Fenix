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
  ProductList(
      {Key? key,
      required this.storeId,
      required this.storeName,
      required this.storeLocation})
      : super(key: key);
  final String storeId, storeName, storeLocation;

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find();
    final UserController userController = Get.find();
    storeController.getProducts(userController.getToken(), storeId);
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: dark,
          icon: const Icon(Icons.add, color: background),
          onPressed: () {
            Get.to(() => CreateProduct(
                  storeId: storeId,
                ));
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
              child: Obx(() => storeController.isFetchingProducts.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : storeController.productList.isEmpty
                      ? Center(
                          child: InkWell(
                          onTap: () => Get.to(() => CreateProduct(
                                storeId: storeId,
                              )),
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
                            var item = storeController.productList[i];
                            return Row(
                              children: [
                                Image.asset('assets/images/headset.png'),
                                smallHSpace(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item['title']),
                                      tinySpace(),
                                      Row(
                                        children: [
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
                                          smallHSpace(),
                                          Text(
                                            '295 Reviews',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      tiny5Space(),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              size: 15),
                                          tinyHSpace(),
                                          Text(
                                            '$storeName, $storeLocation',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      tiny5Space(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.local_shipping_outlined,
                                            size: 15,
                                          ),
                                          tinyHSpace(),
                                          Text(
                                            'Free Shipping',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: darkgreen,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      smallSpace(),
                                      Text(
                                        '${item['price']['amount']} so\'m',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (c, i) => smallSpace(),
                          itemCount: storeController.productList.length)),
            ),
          )
        ],
      ),
    );
  }
}
