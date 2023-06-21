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
import '../../helpers/categories.dart';
import '../../theme.dart';
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
print(category);
    var list =( category=='Apartment'||category=='House'||category=='Apartment')?

    await storeController.getMyApartmentByCategory(token, category)
    : (category=='Cars'||category=='Car Parts'||category=='Car Interior') ?
    await storeController.getMyVehicleByCategory(token, category) :
    await storeController.getMyProductsByCategory(token, category);
    print('Products -- $list');
    if (list != null) {
      setState(() {
        productList = list;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backArrow(),
                      Text(
                        "$category",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.w,
                            fontWeight: FontWeight.w600,
                            ),
                      ),
                      (category == "Cellphones and Accessories") ? IconButton(
                          onPressed: (){
                            pickBrand(Category().electronics[1]['cell phones'], 'Category',
                                onSelect: (v) {
                                  Get.back();

                                  setState(() {
                                    print(v['brand']);

                                   v['brand'] == "Apple" ? pickModel(Category().electronics[1]['cell phones'][0]['model'], 'Brand',
                                        onSelect: (v) {Get.back();})
                                       :  v['brand'] == "Samsung" ? pickModel(Category().electronics[1]['cell phones'][1]['model'], 'Brand',
                                       onSelect: (v) {Get.back();})
                                       :   pickModel(Category().electronics[1]['cell phones'][2]['model'], 'Brand',
                                       onSelect: (v) {Get.back();});
                                  });
                                });
                          },
                          icon: Icon(Icons.filter_list_alt, color: white, size: 28.w,))
                          : smallHSpace(),

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
                                  itemCount: productList.length,
                                  itemBuilder: (context, i) {
                                    var item = productList[i];

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
                    if (category == 'Cars')
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
                                  itemCount: productList.length,
                                  itemBuilder: (context, i) {
                                    var item = productList[i];
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
                              ?  empty(category)
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
                                  itemCount: productList.length,
                                  itemBuilder: (context, i) {
                                    var item = productList[i];
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
                                  itemCount:productList.length,
                                  itemBuilder: (context, i) {
                                    var item = productList[i];

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
                                  itemCount: productList.length,
                                  itemBuilder: (context, i) {
                                    var item = productList[i];
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
  pickBrand(List list, String title, {onSelect}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(children: [
            closeButton(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text('Select $title',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)))),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(list.length, (i) {
                        var item = list[i];
                        return ListTile(
                            title: Text(item['brand'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            onTap: () => onSelect(item));
                      }))),
            ),
          ]),
        ));
  }


  pickModel(List list, String title, {onSelect}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(children: [
            closeButton(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text('Select $title',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)))),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(list.length, (i) {
                        var item = list[i];
                        return ListTile(
                            title: Text(item,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            onTap: () => onSelect(item));
                      }))),
            ),
          ]),
        ));
  }

  InkWell closeButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: width() * 0.13,
            height: 2.5,
            decoration: BoxDecoration(
                color: lightGrey, borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }

}


