import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/home.dart';
import 'package:fenix/screens/products/apartment_details.dart';
import 'package:fenix/screens/profile/create_selling_post/create_apartment.dart';
import 'package:fenix/screens/profile/create_selling_post/create_car.dart';
import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controller/store_controller.dart';
import '../../controller/user_controller.dart';
import '../../helpers/icons/custom_icons_fenix_icons.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';
import '../products/product_details.dart';
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
    var token = userController.getToken();
    storeController.getProducts(token, storeId);
    storeController.getVehicles(token, storeId);
    storeController.getApartments(token, storeId);

    return Scaffold(
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/fenixmall_white.png",
              color: white,
              height: height() * 0.075,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              height() * 0.065,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                       backArrow(),
                      Text(
                        "Your Selling List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27.w,
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
              gradient: appBarGradient,
            ),
          )),
      body: Container(
        color: const Color(0xFFE4EFF9),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: appBarGradient,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.052,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: BODY_PADDING),
                  children: [
                    MenuTitle(
                        icon: CustomIconsFenix.dacha,
                        title: "Dacha",
                        color: tab == "Dacha" ? white : Colors.transparent,
                        onTap: () {
                          setState(() {
                            tab = "Dacha";
                            dacha = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'dacha')
                                .toList();
                            for (var i in storeController.apartmentList) {
                              print(i['apartmentType']);
                            }
                          });
                        }),
                    MenuTitle(
                        icon: CustomIconsFenix.house,
                        title: "House",
                        color: tab == "House" ?white : Colors.transparent,
                        onTap: () {
                          setState(() {
                            tab = "House";
                            house = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'house')
                                .toList();
                          });
                        }),
                    MenuTitle(
                        icon: CustomIconsFenix.apartment,
                        title: "Apartment",
                        color: tab == "Apartment" ?white : Colors.transparent,
                        onTap: () {
                          setState(() {
                            tab = "Apartment";
                            apartment = storeController.apartmentList
                                .where((e) => e['apartmentType'] == 'apartment')
                                .toList();
                          });
                        }),
                    MenuTitle(
                        icon: FontAwesomeIcons.car,
                        title: "Car",
                        color: tab == "Car" ? white : Colors.transparent,
                        onTap: () {
                          setState(() {
                            tab = "Car";
                          });
                        }),
                    MenuTitle(
                        icon: CustomIconsFenix.vector__3_,
                        title: "Electronics",
                        color: tab == "Electronics" ? white : Colors.transparent,
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
              child: RefreshIndicator(
                onRefresh: () async {
                  tab == 'Electronics'
                      ? await storeController.getProducts(token, storeId)
                      : tab == 'Car'
                          ? await storeController.getVehicles(token, storeId)
                          : await storeController.getApartments(token, storeId);
                },
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
                                    itemCount:
                                        storeController.productList.length,
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
                                    itemCount:
                                        storeController.vehicleList.length,
                                    itemBuilder: (context, i) {
                                      var item = storeController.vehicleList[i];
                                      return InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              ProductDetails(product: item));
                                        },
                                        child:  ProductListWidget(
                                            product: item,
                                            isNetwork: item['media'].isNotEmpty,
                                            image: item['media'].isNotEmpty
                                                ? item['media'][0]['url']
                                                : "assets/images/cars.png"),
                                      );
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
                                      return InkWell(
                                          onTap: () {
                                            print(item['media'][0]['url']);
                                            // Get.to(() => ApartmentDetails(
                                            //     apartment: item));
                                          },
                                          child:
                                              ProductListWidget( product: item,
                                                  isNetwork: item['media'].isNotEmpty,
                                                  image: item['media'].isNotEmpty
                                                      ? item['media'][0]['url']
                                                      : "assets/images/cars.png"),);
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

                                      return InkWell(
                                          onTap: () {
                                            Get.to(() => ApartmentDetails(
                                                apartment: item));
                                          },
                                          child:
                                              ProductListWidget(product: item));
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
                                      return InkWell(
                                          onTap: () {
                                            Get.to(() => ApartmentDetails(
                                                apartment: item));
                                          },
                                          child:
                                              ProductListWidget(product: item));
                                    }),
                      ),
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
