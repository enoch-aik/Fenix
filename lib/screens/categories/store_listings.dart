import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/home.dart';
import 'package:fenix/screens/products/apartment_details.dart';
import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controller/store_controller.dart';
import '../../controller/user_controller.dart';
import '../home/widgets/loader.dart';
import '../products/product_details.dart';

class StoreListing extends StatefulWidget {
  const StoreListing({Key? key, this.category}) : super(key: key);
  final category;

  @override
  State<StoreListing> createState() => _StoreListingState();
}

class _StoreListingState extends State<StoreListing> {
  var apartment = [];
  var dacha = [];
  var house = [];

  var storeId;
  String category = '';
  String token = '';
  var productList;
  var isLoadingProducts = true;

  final StoreController storeController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeId = storeController.getDefaultStoreId();
    token = userController.getToken();

    boot();
  }

  boot() async {
    category = widget.category;

    productList = await storeController.getProductsByCategory(token, category);
    if (productList != null) {
      setState(() {
        isLoadingProducts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          height() * 0.07,
        ),
        child: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
          padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      backArrow(),
                      Text(
                        "Your $category List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23.w,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(2, 2))
                            ]),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFE4EFF9),
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     gradient: appBarGradient,
            //   ),
            //   child: SizedBox(
            //     height: MediaQuery.of(context).size.height * 0.052,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       padding: const EdgeInsets.symmetric(horizontal: BODY_PADDING),
            //       children: [
            //         MenuTitle(
            //             icon: CustomIconsFenix.dacha,
            //             title: "Dacha",
            //             color: category == "Dacha" ? white : light,
            //             onTap: () {
            //               setState(() {
            //                 category = "Dacha";
            //                 dacha = storeController.apartmentList
            //                     .where((e) => e['apartmentType'] == 'dacha')
            //                     .toList();
            //                 for (var i in storeController.apartmentList) {
            //                   print(i['apartmentType']);
            //                 }
            //               });
            //             }),
            //         MenuTitle(
            //             icon: CustomIconsFenix.house,
            //             title: "House",
            //             color: category == "House" ? white : light,
            //             onTap: () {
            //               setState(() {
            //                 category = "House";
            //                 house = storeController.apartmentList
            //                     .where((e) => e['apartmentType'] == 'house')
            //                     .toList();
            //               });
            //             }),
            //         MenuTitle(
            //             icon: CustomIconsFenix.apartment,
            //             title: "Apartment",
            //             color: category == "Apartment" ? white : light,
            //             onTap: () {
            //               setState(() {
            //                 category = "Apartment";
            //                 apartment = storeController.apartmentList
            //                     .where((e) => e['apartmentType'] == 'apartment')
            //                     .toList();
            //               });
            //             }),
            //         MenuTitle(
            //             icon: FontAwesomeIcons.car,
            //             title: "Car",
            //             color: category == "Car" ? white : light,
            //             onTap: () {
            //               setState(() {
            //                 category = "Car";
            //               });
            //             }),
            //         MenuTitle(
            //             icon: FontAwesomeIcons.television,
            //             title: "Electronics",
            //             color: category == "Electronics" ? white : light,
            //             onTap: () {
            //               setState(() {
            //                 category = "Electronics";
            //               });
            //             }),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  category == 'Electronics'
                      ? await storeController.getProducts(token, storeId)
                      : category == 'Car'
                          ? await storeController.getVehicles(token, storeId)
                          : await storeController.getApartments(token, storeId);
                },
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(height: 20.w),
                    if (category == 'Electronics')
                      isLoadingProducts
                          ? const Loader()
                          : productList.isEmpty
                              ? empty(category)
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
                                  itemCount: storeController.productList.length,
                                  itemBuilder: (context, i) {
                                    var item = storeController.productList[i];

                                    return InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            ProductDetails(product: item));
                                      },
                                      child: ProductListWidget(
                                          product: item,
                                          isNetwork: item['media'].isNotEmpty,
                                          image: item['media'].isNotEmpty
                                              ? item['media'][0]['url']
                                              : "assets/images/Rectangle 7.png"),
                                    );
                                  }),
                    if (category == 'Car')
                      isLoadingProducts
                          ? const Loader()
                          : productList.isEmpty
                              ? empty(category)
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
                                  itemCount: storeController.vehicleList.length,
                                  itemBuilder: (context, i) {
                                    var item = storeController.vehicleList[i];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() =>
                                            ProductDetails(product: item));
                                      },
                                      child: ProductListWidget(
                                          product: item,
                                          isNetwork: item['media'].isNotEmpty,
                                          image: item['media'].isNotEmpty
                                              ? item['media'][0]['url']
                                              : "assets/images/cars.png"),
                                    );
                                  }),
                    if (category == 'Apartment')
                      isLoadingProducts
                          ? const Loader()
                          : productList.isEmpty
                              ? empty(category)
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
                                  itemCount: apartment.length,
                                  itemBuilder: (context, i) {
                                    var item = apartment[i];
                                    return InkWell(
                                      onTap: () {
                                        print(item['media'][0]['url']);
                                        // Get.to(() => ApartmentDetails(
                                        //     apartment: item));
                                      },
                                      child: ProductListWidget(
                                          product: item,
                                          isNetwork: item['media'].isNotEmpty,
                                          image: item['media'].isNotEmpty
                                              ? item['media'][0]['url']
                                              : "assets/images/cars.png"),
                                    );
                                  }),
                    if (category == 'House')
                      isLoadingProducts
                          ? const Loader()
                          : productList.isEmpty
                              ? empty(category)
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
                                  itemCount: house.length,
                                  itemBuilder: (context, i) {
                                    var item = house[i];

                                    return InkWell(
                                        onTap: () {
                                          Get.to(() => ApartmentDetails(
                                              apartment: item));
                                        },
                                        child:
                                            ProductListWidget(product: item));
                                  }),
                    if (category == 'Dacha')
                      isLoadingProducts
                          ? const Loader()
                          : productList.isEmpty
                              ? empty(category)
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
                                  itemCount: dacha.length,
                                  itemBuilder: (context, i) {
                                    var item = dacha[i];
                                    return InkWell(
                                        onTap: () {
                                          Get.to(() => ApartmentDetails(
                                              apartment: item));
                                        },
                                        child:
                                            ProductListWidget(product: item));
                                  }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
