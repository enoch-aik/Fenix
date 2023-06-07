import 'package:fenix/const.dart';
import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/controller/store_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/distance_calculator.dart';
import 'package:fenix/helpers/icons/custom_icons_fenix_icons.dart';
import 'package:fenix/helpers/widgets/recently_viewed_widget.dart';
import 'package:fenix/screens/dealsDetails.dart';
import 'package:fenix/screens/home/house_rent.dart';
import 'package:fenix/screens/home/search.dart';
import 'package:fenix/screens/products/product_details.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/chat_controller.dart';
import '../../controller/map_controller.dart';
import '../../controller/product_controller.dart';
import '../../helpers/categories.dart';
import '../../helpers/icons/custom_icons_icons.dart';
import '../../helpers/widgets/top_rated_Items.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';
import '../products/apartment_details.dart';
import '../profile/product_list.dart';
import 'car_listing.dart';
import 'widgets/loader.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String homeTab = 'Dacha';
  String token = '';
  String storeId = '';
  String tab = 'dacha';

  final searchWordController = TextEditingController();
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.put(StoreController());
  final AccountController _accountController = Get.put(AccountController());
  final ChatController _chatController = Get.put(ChatController());
  final ProductController _productController = Get.put(ProductController());
  final MapController _mapController = Get.put(MapController());

  Position? _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    boot();
    super.initState();
  }

  boot() async {
    token = _userController.getToken();
    storeId = _storeController.getDefaultStoreId();
    _storeController.getProducts(token, storeId);
    _storeController.getApartments(token, storeId);
    _storeController.getVehicles(token, storeId);
    _userController.getWishList(token);
    _mapController.getApartments(token,
        longitude: -88.14801, latitude: 36.74582);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.18),
        child: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
          padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/fenixmall_white.png",
                    color: white,
                    height: height() * 0.075,
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              TextField(
                onChanged: (v) {
                  setState(() {});
                },
                controller: searchWordController,
                onSubmitted: (v) => _productController.searchStore(tab, v),
                onEditingComplete: () => _productController.searchStore(
                    tab, searchWordController.text),
                onTapOutside: (v) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  enabledBorder: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Search Fenix",
                  hintStyle:
                      TextStyle(fontSize: 15.w, color: Colors.grey.shade500),
                  suffixIcon: searchWordController.text.isEmpty
                      ? const Icon(Icons.search)
                      : IconButton(
                          onPressed: () {
                            searchWordController.text = '';
                            FocusScope.of(context).unfocus();
                            setState(() {});
                            _productController.clearSearch(tab);
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.052,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        MenuTitle(
                          icon: CustomIconsFenix.dacha,
                          title: "Dacha",
                          color: tab == 'dacha' ? white : light,
                          onTap: () => setState(() {
                            tab = 'dacha';
                            _productController.getDacha();
                          }),
                        ),
                        MenuTitle(
                          icon: CustomIconsFenix.house,
                          title: "House",
                          color: tab == 'house' ? white : light,
                          onTap: () => setState(() {
                            tab = 'house';
                            _productController.getHouse();
                          }),
                        ),
                        MenuTitle(
                          icon: CustomIconsFenix.apartment,
                          title: "Apartment",
                          color: tab == 'apartment' ? white : light,
                          onTap: () => setState(() {
                            tab = 'apartment';
                            _productController.getApartments();
                          }),
                        ),
                        MenuTitle(
                          icon: FontAwesomeIcons.car,
                          title: "Car",
                          color: tab == 'car' ? white : light,
                          onTap: () => setState(() {
                            tab = 'car';
                            _productController.getVehicle();
                          }),
                        ),
                        MenuTitle(
                          icon: FontAwesomeIcons.television,
                          title: "Electronics",
                          color: tab == 'electronics' ? white : light,
                          onTap: () => setState(() {
                            tab = 'electronics';
                            _productController.getProducts();
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _productController.clearSearch(tab);
        },
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            // Column(children: [
            //   Container(
            //       height: 30.w,
            //       width: MediaQuery.of(context).size.width,
            //       padding: EdgeInsets.symmetric(horizontal: 10.w),
            //       decoration: BoxDecoration(
            //         gradient: gradient(
            //           const Color(0xFF691232),
            //           const Color(0xFF1770A2),
            //         ),
            //       ),
            //       child: Row(
            //         children: [
            //           Icon(Icons.location_on, size: 17.w, color: white),
            //           Text(
            //             " Deliver to chicago,iL 5932 ",
            //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //               fontSize: 13.w,
            //               color: white,
            //               fontWeight: FontWeight.w800,
            //             ),
            //           ),
            //         ],
            //       )),
            //   SizedBox(
            //     height: 276.w,
            //     width: MediaQuery.of(context).size.width,
            //     child: PageView(
            //       children: [
            //         Image.asset(
            //           "assets/images/cokeAd.png",
            //           fit: BoxFit.fitWidth,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //       ],
            //     ),
            //   ),
            //   kSpacing,
            //   // Obx(
            //   //   () => _storeController.getDefaultStoreId()==''
            //   //       ? const Center(child: CircularProgressIndicator())
            //   //       : ProductList(
            //   //           storeId: storeId,
            //   //           storeName: 'name',
            //   //           storeLocation: 'location',
            //   //         ),
            //   // ),
            //   kSpacing,
            //   SizedBox(
            //     height: 152.w,
            //     width: MediaQuery.of(context).size.width,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 7,
            //       itemBuilder: (context, index) {
            //         return InkWell(
            //           onTap: () {
            //             // Get.to(() => const ProductDetails());
            //           },
            //           child: Container(
            //             width: 114.w,
            //             height: 152.w,
            //             margin: EdgeInsets.all(4.5.w),
            //             padding: EdgeInsets.all(7.w),
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(13.w)),
            //             child: Image.asset(
            //               "assets/images/phone.png",
            //               fit: BoxFit.fill,
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 57.w,
            //       margin: EdgeInsets.symmetric(vertical: 17.w),
            //       decoration: const BoxDecoration(
            //         color: Color(0xFF1F4167),
            //         gradient: LinearGradient(
            //             colors: [
            //               Color(0xFF1F4167),
            //               Color(0xFF125EB7),
            //               Color(0xFF0777FB),
            //             ],
            //             stops: [
            //               0.0,
            //               0.5,
            //               1.0
            //             ],
            //             begin: FractionalOffset.topLeft,
            //             end: FractionalOffset.bottomRight,
            //             tileMode: TileMode.repeated),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Padding(
            //               padding: EdgeInsets.only(top: 5.w),
            //               child: Icon(
            //                 CustomIcons.crown_badge,
            //                 color: const Color(0xFFFCC70A),
            //                 size: 42.w,
            //               )),
            //           Text(
            //             "Top 10 Rated Items",
            //             style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                 fontSize: 18.w,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ],
            //       )),
            //   ListView.builder(
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: 1,
            //       shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         return RatedItemsWidget();
            //       }),
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 40.w,
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.symmetric(vertical: 17.w),
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
            //       decoration: BoxDecoration(
            //           color: const Color(0xFF1F4167),
            //           gradient: gradient(
            //               const Color(0xFF1F4167), const Color(0xFF0777FB))),
            //       child: Text(
            //         "Recently Viewed Items",
            //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //             fontSize: 18.w,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w700),
            //       )),
            //   SizedBox(
            //     height: 160.w,
            //     child: ListView.builder(
            //         itemCount: 5,
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (context, index) {
            //           return const RecentlyViewed();
            //         }),
            //   ),
            //   SizedBox(
            //     height: 160.w,
            //     child: ListView.builder(
            //         itemCount: 5,
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (context, index) {
            //           return const RecentlyViewed();
            //         }),
            //   ),
            //   Divider(
            //     color: const Color(0xFF1994F5).withOpacity(0.22),
            //     thickness: 5,
            //     height: 50.w,
            //   ),
            //   const RecentlyViewed(),
            //   const RecentlyViewed(),
            //   const RecentlyViewed(),
            //   Container(
            //     height: 276.w,
            //     width: MediaQuery.of(context).size.width,
            //     margin: EdgeInsets.only(top: 20.w),
            //     child: PageView(
            //       children: [
            //         Image.asset(
            //           "assets/images/cokeAd.png",
            //           fit: BoxFit.fitWidth,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //         Image.asset(
            //           "assets/images/logoFrame.png",
            //           fit: BoxFit.fill,
            //         ),
            //       ],
            //     ),
            //   ),
            //   SizedBox(
            //     height: 152.w,
            //     width: MediaQuery.of(context).size.width,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 7,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           width: 114.w,
            //           height: 152.w,
            //           margin: EdgeInsets.all(4.5.w),
            //           padding: EdgeInsets.all(7.w),
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(13.w)),
            //           child: Image.asset(
            //             "assets/images/phone.png",
            //             fit: BoxFit.fill,
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 57.w,
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.symmetric(vertical: 17.w),
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
            //       decoration: BoxDecoration(
            //           color: const Color(0xFF1F4167),
            //           gradient: gradient(
            //               const Color(0xFF1F4167), const Color(0xFF0777FB))),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Icon(
            //                 CustomIcons.best_selling,
            //                 color: const Color(0xFFE48C24),
            //                 size: 37.w,
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text(
            //                 "Best Selling Items",
            //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                     fontSize: 18.w,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Get.to(() => DealsDetails(title: "Best Selling Items"));
            //             },
            //             child: Container(
            //               height: 24.w,
            //               width: 75.w,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(12.w),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "More",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                         fontSize: 13.w,
            //                         fontWeight: FontWeight.w700),
            //                   ),
            //                   SizedBox(
            //                     width: 3.w,
            //                   ),
            //                   Icon(
            //                     Icons.menu,
            //                     color: kTextBlackColor,
            //                     size: 15.w,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       )),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ProductWidget(),
            //       ProductWidget(),
            //     ],
            //   ),
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 57.w,
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.symmetric(vertical: 17.w),
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
            //       decoration: BoxDecoration(
            //           color: const Color(0xFF1F4167),
            //           gradient: gradient(
            //               const Color(0xFF1F4167), const Color(0xFF0777FB))),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Icon(
            //                 CustomIcons.top_deals,
            //                 color: const Color(0xFFE48C24),
            //                 size: 33.w,
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text(
            //                 "Top Deals",
            //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                     fontSize: 18.w,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Get.to(() => DealsDetails(
            //                 title: "Top Deals",
            //               ));
            //             },
            //             child: Container(
            //               height: 24.w,
            //               width: 75.w,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(12.w),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "More",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                         fontSize: 13.w,
            //                         fontWeight: FontWeight.w700),
            //                   ),
            //                   SizedBox(
            //                     width: 3.w,
            //                   ),
            //                   Icon(
            //                     Icons.menu,
            //                     color: kTextBlackColor,
            //                     size: 15.w,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       )),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ProductWidget(),
            //       ProductWidget(),
            //     ],
            //   ),
            //   Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 57.w,
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.symmetric(vertical: 17.w),
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
            //       decoration: BoxDecoration(
            //           color: const Color(0xFF1F4167),
            //           gradient: gradient(
            //               const Color(0xFF1F4167), const Color(0xFF0777FB))),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Icon(
            //                 CustomIcons.recommended_deals,
            //                 color: const Color(0xFFE48C24),
            //                 size: 33.w,
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text(
            //                 "Recommended Deals",
            //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //                     fontSize: 18.w,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Get.to(() => DealsDetails(
            //                 title: "Recommended Deals",
            //               ));
            //             },
            //             child: Container(
            //               height: 24.w,
            //               width: 75.w,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(12.w),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     "More",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                         fontSize: 13.w,
            //                         fontWeight: FontWeight.w700),
            //                   ),
            //                   SizedBox(
            //                     width: 3.w,
            //                   ),
            //                   Icon(
            //                     Icons.menu,
            //                     color: kTextBlackColor,
            //                     size: 15.w,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )
            //         ],
            //       )),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       ProductWidget(),
            //       ProductWidget(),
            //     ],
            //   ),
            // ],),

            smallSpace(),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 40.w,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 17.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                decoration: BoxDecoration(
                    color: const Color(0xFF1F4167),
                    gradient: gradient(
                        const Color(0xFF1F4167), const Color(0xFF0777FB))),
                child: Text(
                  "Regular Selling Items",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  tab == 'car'
                      ? Obx(
                          () => _productController.isFetchingProducts.isTrue
                              ? const Loader()
                              : _productController.vehicleList.isEmpty
                                  ? empty('car')
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
                                              childAspectRatio: 1 / 2.2,
                                              mainAxisSpacing: 0,
                                              crossAxisSpacing: 5),
                                      itemCount:
                                          _productController.productList.length,
                                      itemBuilder: (context, index) {
                                        var item = _productController
                                            .vehicleList[index];
                                        return InkWell(
                                            onTap: () {
                                              Get.to(() => ProductDetails(
                                                    product: _productController
                                                        .vehicleList[index],
                                                  ));
                                            },
                                            child: ProductWidget(
                                                title: item['title'],
                                                category: 'Cars',
                                                price: item['price']['amount']
                                                    .toString(),
                                                product: item));
                                      }),
                        )
                      : tab == 'electronics'
                          ? Obx(
                              () => _productController.isFetchingProducts.isTrue
                                  ? const Loader()
                                  : _productController.productList.isEmpty
                                      ? empty('electronics')
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
                                                  childAspectRatio: 1 / 2.2,
                                                  mainAxisSpacing: 0,
                                                  crossAxisSpacing: 5),
                                          itemCount: _productController
                                              .productList.length,
                                          itemBuilder: (context, index) {
                                            var item = _productController
                                                .productList[index];
                                            return InkWell(
                                                onTap: () {
                                                  Get.to(() => ProductDetails(
                                                        product:
                                                            _productController
                                                                    .productList[
                                                                index],
                                                      ));
                                                },
                                                child: ProductWidget(
                                                    title: item['title'],
                                                    price: item['price']
                                                            ['amount']
                                                        .toString(),
                                                    category: 'Electronics',
                                                    product: item));
                                          }),
                            )
                          : tab == 'dacha'
                              ? Obx(
                                  () => _productController
                                          .isFetchingDacha.isTrue
                                      ? const Loader()
                                      : _productController.dachaList.isEmpty
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
                                                              0.50,
                                                      childAspectRatio: 1 / 2.2,
                                                      mainAxisSpacing: 0,
                                                      crossAxisSpacing: 5),
                                              itemCount: _productController
                                                  .dachaList.length,
                                              itemBuilder: (context, index) {
                                                var item = _productController
                                                    .dachaList[index];
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ApartmentDetails(
                                                              apartment:
                                                                  _productController
                                                                          .dachaList[
                                                                      index],
                                                            ));
                                                  },
                                                  child: ProductWidget(
                                                      title: item['title'],
                                                      category:
                                                          item['apartmentType'],
                                                      price: item['rentPrice']
                                                              ['month']
                                                          .toString(),
                                                      product: item),
                                                );
                                              }),
                                )
                              : tab == 'house'
                                  ? Obx(
                                      () => _productController
                                              .isFetchingHouse.isTrue
                                          ? const Loader()
                                          : _productController.houseList.isEmpty
                                              ? empty(tab)
                                              : GridView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.50,
                                                          childAspectRatio:
                                                              1 / 2.2,
                                                          mainAxisSpacing: 0,
                                                          crossAxisSpacing: 5),
                                                  itemCount: _productController
                                                      .houseList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item =
                                                        _productController
                                                            .houseList[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            ApartmentDetails(
                                                              apartment:
                                                                  _productController
                                                                          .houseList[
                                                                      index],
                                                            ));
                                                      },
                                                      child: ProductWidget(
                                                          title: item['title'],
                                                          category: item[
                                                              'apartmentType'],
                                                          price:
                                                              item['rentPrice']
                                                                      ['month']
                                                                  .toString(),
                                                          product: item),
                                                    );
                                                  }),
                                    )
                                  : Obx(
                                      () => _productController
                                              .isFetchingApartments.isTrue
                                          ? const Loader()
                                          : _productController
                                                  .apartmentList.isEmpty
                                              ? empty(tab)
                                              : GridView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.50,
                                                          childAspectRatio:
                                                              1 / 2.2,
                                                          mainAxisSpacing: 0,
                                                          crossAxisSpacing: 5),
                                                  itemCount: _productController
                                                      .apartmentList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var item =
                                                        _productController
                                                                .apartmentList[
                                                            index];
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            ApartmentDetails(
                                                              apartment:
                                                                  _productController
                                                                          .apartmentList[
                                                                      index],
                                                            ));
                                                      },
                                                      child: ProductWidget(
                                                          title: item['title'],
                                                          category: item[
                                                              'apartmentType'],
                                                          price:
                                                              item['rentPrice']
                                                                      ['month']
                                                                  .toString(),
                                                          product: item),
                                                    );
                                                  }),
                                    ),
                ],
              ),
            )

            // Container(
            //   height: 276.w,
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.only(bottom: 20.w),
            //   child: PageView(
            //     children: [
            //       Image.asset(
            //         "assets/images/cokeAd.png",
            //         fit: BoxFit.fitWidth,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //     ],
            //   ),
            // ),
            // GridView.builder(
            //     primary: false,
            //     shrinkWrap: true,
            //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            //       childAspectRatio: 1 / 2,
            //       mainAxisSpacing: 0,
            //       crossAxisSpacing: 0,
            //     ),
            //     itemCount: 10,
            //     itemBuilder: (context, c) {
            //       return  ProductWidget();
            //     }),
            // Container(
            //   height: 276.w,
            //   width: MediaQuery.of(context).size.width,
            //   margin: EdgeInsets.only(bottom: 20.w),
            //   child: PageView(
            //     children: [
            //       Image.asset(
            //         "assets/images/house.png",
            //         fit: BoxFit.fitWidth,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //       Image.asset(
            //         "assets/images/logoFrame.png",
            //         fit: BoxFit.fill,
            //       ),
            //     ],
            //   ),
            // ),
            // GridView.builder(
            //     primary: false,
            //     shrinkWrap: true,
            //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //       maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            //       childAspectRatio: 1 / 2,
            //       mainAxisSpacing: 0,
            //       crossAxisSpacing: 0,
            //     ),
            //     itemCount: 10,
            //     itemBuilder: (context, c) {
            //       return ProductWidget();
            //     }),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.w),
        borderSide: const BorderSide(color: Colors.white));
  }
}

class ProductWidget extends StatelessWidget {
  String title, category;
  var product;
  String price;

  final UserController _userController = Get.find();

  ProductWidget(
      {Key? key,
      this.title = "",
      this.price = "",
      required this.product,
      this.category = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.48,
          width: MediaQuery.of(context).size.width * 0.48,
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
              color: const Color(0xFFDAE5F2),
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(-3, -6), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width * 0.480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/${category == "Electronics" ? 'electronics' : category == "Cars" ? 'cars' : 'house'}.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.w),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.455,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: SizedBox(
                        height: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 12.w,
                                      color: const Color(0xFF334669),
                                      fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                RatingBar(
                                    initialRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 18.w,
                                    ignoreGestures: true,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.orange),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Colors.orange,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.grey,
                                        )),
                                    onRatingUpdate: (value) {}),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "259 reviews.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 10.w,
                                          color: const Color(0xFF334669)
                                              .withOpacity(0.6),
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Obx(() =>
                                _userController.isFetchingUserLocation.isFalse
                                    ? Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          // ${distanceInKm(
                                          //   _userController.userCurrentPosition!.value.latitude,
                                          //   _userController.userCurrentPosition!.value.longitude,
                                          //   location['location']['latitude'],
                                          //   location['location']['longitude'],
                                          // ).toString()}
                                          Text(
                                            "124Km",
                                            style: TextStyle(
                                                fontSize: 11.w,
                                                color: const Color(0xFF334669)
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      )
                                    : tiny5Space()),
                            Row(
                              children: [
                                const Icon(Icons.fire_truck),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Free Shipping",
                                  style: TextStyle(
                                      fontSize: 12.w,
                                      color: const Color(0xFF0F7D46),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text(
                        "$price so’m",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15.w,
                            color: const Color(0xFFCE242B),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 7,
          right: 20,
          child: InkWell(
            onTap: () {
              product['isLiked']
                  ? _userController.deleteItemFromWishList(
                      _userController.getToken(), product['id'], category)
                  : _userController.addItemToWishList(
                      _userController.getToken(), product['id'], category);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: product['isLiked']
                      ? const Color(0xFFFA4788)
                      : Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Obx(
                  () => (_userController.isLoadingLikes.isTrue &&
                          _userController.selectedId.value == product['id'])
                      ? const Center(
                          child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator.adaptive(),
                        ))
                      : Icon(
                          product['isLiked']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product['isLiked'] ? white : kTextBlackColor,
                          size: 23,
                        ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Center empty(title) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      verticalSpace(0.1),
      Image.asset(
        'assets/images/icons/empty-cart.png',
        color: grey,
      ),
      smallSpace(),
      Text(
        'There are no $title listed yet',
        style: const TextStyle(color: grey, fontSize: 14),
      ),
    ],
  ));
}
