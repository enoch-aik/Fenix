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
import '../home/widgets/loader.dart';
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

  var storeId;
  var token;

  final StoreController storeController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeId = widget.storeId ?? storeController.getDefaultStoreId();
    token = userController.getToken();
    storeController.getProducts(token, storeId);
    storeController.getVehicles(token, storeId);
    storeController.getApartments(token, storeId);

    dacha = storeController.apartmentList
        .where((e) => e['apartmentType'] == 'dacha')
        .toList();

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
                            "Your Selling List",
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
                        color: tab == "Dacha" ? white : light,
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
                        color: tab == "House" ?  white : light,
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
                        color: tab == "Apartment" ?  white : light,
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
                        color: tab == "Car" ?  white : light,
                        onTap: () {
                          setState(() {
                            tab = "Car";
                          });
                        }),
                    MenuTitle(
                        icon: FontAwesomeIcons.television,
                        title: "Electronics",
                        color: tab == "Electronics" ?  white : light,
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
                            ? const Loader()
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
                            ? const Loader()
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
                                        child: ProductListWidget(
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
                            ? const Loader()
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
                                        child: ProductListWidget(
                                            product: item,
                                            isNetwork: item['media'].isNotEmpty,
                                            image: item['media'].isNotEmpty
                                                ? item['media'][0]['url']
                                                : "assets/images/cars.png"),
                                      );
                                    }),
                      ),
                    if (tab == 'House')
                      Obx(
                        () => storeController.isFetchingApartments.isTrue
                            ? const Loader()
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
                            ? const Loader()
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
