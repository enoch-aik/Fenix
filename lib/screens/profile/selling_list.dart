import 'package:fenix/screens/home/home.dart';
import 'package:fenix/screens/profile/create_selling_post/create_apartment.dart';
import 'package:fenix/screens/profile/create_selling_post/create_car.dart';
import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controller/store_controller.dart';
import '../../controller/user_controller.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';
import 'create_selling_post/create_product.dart';

class SellingList extends StatefulWidget {
  const SellingList({Key? key, this.storeId}) : super(key: key);
  final storeId;

  @override
  State<SellingList> createState() => _SellingListState();
}

class _SellingListState extends State<SellingList> {
  String tab = 'Dacha';
  var apartment = [];
  var dacha = [];
  var house = [];

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find();
    final UserController userController = Get.find();
    var storeId = widget.storeId ?? storeController.getDefaultStoreId();
    storeController.getProducts(userController.getToken(), storeId);
    storeController.getVehicles(userController.getToken(), storeId);
    storeController.getApartments(userController.getToken(), storeId);

    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 46.h,
            child: Image.asset(
              "assets/images/fenixWhite2.png",
              fit: BoxFit.fill,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width * 0.15,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Your Selling List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.w,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(2, 2))
                            ]),
                      ),
                    ],
                  )),
            ),
          ),
          automaticallyImplyLeading: false,
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: gradient2(
                  const Color(0xFF46E0C4),
                  const Color(0xFF59B5C0),
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.052,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    MenuTitle(
                        icon: "Dacha.png",
                        title: "Dacha",
                        color: tab == "Dacha" ? dark : white,
                        onTap: () {
                          setState(() {
                            tab = "Dacha";
                            dacha = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'dacha')
                                .toList();
                            for(var i in storeController.apartmentList ){
                            print(i['apartmentType']);}

                          });
                        }),
                    MenuTitle(
                        icon: "houseRental.png",
                        title: "House",
                        color: tab == "House" ? dark : white,
                        onTap: () {
                          setState(() {
                            tab = "House";
                            house = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'house')
                                .toList();
                          });
                        }),
                    MenuTitle(
                        icon: "apartment.png",
                        title: "Apartment",
                        color: tab == "Apartment" ? dark : white,
                        onTap: () {
                          setState(() {
                            tab = "Apartment";
                            apartment = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'apartment')
                                .toList();
                          });
                        }),
                    MenuTitle(
                        icon: "carRental.png",
                        title: "Car",
                        color: tab == "Car" ? dark : white,
                        onTap: () {
                          setState(() {
                            tab = "Car";
                          });
                        }),
                    MenuTitle(
                        icon: "television.png",
                        title: "Electronics",
                        color: tab == "Electronics" ? dark : white,
                        onTap: () {
                          setState(() {
                            tab = "Electronics";
                          });
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  SizedBox(height: 20.w),
                  if (tab == 'Electronics')
                    Obx(
                      () => storeController.isFetchingProducts.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : storeController.productList.isEmpty
                              ? empty(tab)
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

                                    return ProductListWidget(
                                        product: item,
                                        image: 'assets/images/headset.png');
                                  }),
                    ),
                  if (tab == 'Car')
                    Obx(
                      () => storeController.isFetchingVehicles.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : storeController.vehicleList.isEmpty
                              ? empty(tab)
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
                                    return ProductListWidget(
                                        product: item,
                                        image: 'assets/images/car copy.jpg');
                                  }),
                    ),
                  if (tab == 'Apartment')
                    Obx(
                      () => storeController.isFetchingApartments.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : apartment.isEmpty
                              ? empty(tab)
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
                                    return ProductListWidget(product: item);
                                  }),
                    ),
                  if (tab == 'House')
                    Obx(
                      () => storeController.isFetchingApartments.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : house.isEmpty
                              ? empty(tab)
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

                                    return ProductListWidget(product: item);
                                  }),
                    ),
                  if (tab == 'Dacha')
                    Obx(
                      () => storeController.isFetchingApartments.isTrue
                          ? const Center(child: CircularProgressIndicator())
                          : dacha.isEmpty
                              ? empty(tab)
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
                                    return ProductListWidget(product: item);
                                  }),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
