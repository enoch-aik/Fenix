import 'dart:async';
import 'dart:convert';

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
import 'package:fenix/screens/home/search_and_history.dart';
import 'package:fenix/screens/products/product_details.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/chat_controller.dart';
import '../../controller/map_controller.dart';
import '../../controller/payment_controller.dart';
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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';



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


  int _currentPage = 0;

  Timer? _timer;

  PageController _pageController = PageController(
    initialPage: 0,
  );


  final searchWordController = TextEditingController();
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.put(StoreController());
  final AccountController _accountController = Get.put(AccountController());
  final ChatController _chatController = Get.put(ChatController());
  final ProductController _productController = Get.find();
  final MapController _mapController = Get.put(MapController());
  final PaymentController _paymentController = Get.put(PaymentController());

  final ScrollController homeScrollController = ScrollController();

  Position? _currentPosition;
  final focus = FocusNode();
  List suggestions = [];

  @override
  void initState() {
    // TODO: implement initState
    boot();
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration:  const Duration(milliseconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }




  boot() async {
    token = _userController.getToken();
    storeId = _storeController.getDefaultStoreId();
    _userController.getWishList(token);
    _mapController.getApartments(token,
        longitude: -88.14801, latitude: 36.74582);
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


  pickFilter(var list, String title, {onSelect}) {
    print(list);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.4,
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

  saveRecentlyViewed(itemType, itemId) async{
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> viewedItem = {
      "type": itemType,
      "id": itemId,
    };

    String encodedMap = json.encode(viewedItem);
    print(encodedMap);

    prefs.setString('timeData', encodedMap);

    // Set<String> recentlyViewed =
    //     pref.getStringList("recentlyViewedItems")?.toSet() ?? {};
    //
    // allSearches = {searchText, ...allSearches};
    // prefs.setStringList("recentlyViewedItems", allSearches.toList());
  }

  List slides = [
    'Apartment',
    'Apple',
    'Car',
    'Dacha',
    'Electronics',
    'HeadPhones',
    'HealthCare',
    'House',
    'Mac',
    'Samsung',
    'SmartWatches',
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() => _productController.isSearchEnabled.value == false ?
    Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.170),
        child: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
          padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    homeScrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeOut);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/fenixmall_white.png",
                      color: white,
                      height: height() * 0.070,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.w),

              //Home Page Search Bar
              TextField(
                controller: searchWordController,
                onTap: (){
                  _productController.isSearchEnabled.value = true;
                },
                decoration: InputDecoration(
                  enabledBorder: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  hintText: AppLocalizations.of(context)!.searchFenix,
                  hintStyle:
                  TextStyle(fontSize: 15.w, color: Colors.grey.shade500),

                  suffixIcon: searchWordController.text.isEmpty
                      ? const Icon(Icons.search)
                      : (searchWordController.text.isNotEmpty && _productController.isSearching == true)
                      ? Padding(
                    padding: EdgeInsets.all(10.w),
                    child: const CircularProgressIndicator.adaptive(),
                  )
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

              //HomePage Menu
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
                          title: AppLocalizations.of(context)!.dacha,
                          color: tab == 'dacha' ? white : light,
                          onTap: () => setState(() {
                            tab = 'dacha';
                            _productController.getDacha();
                          }),
                        ),
                        smallHSpace(),
                        MenuTitle(
                          icon: CustomIconsFenix.house,
                          title: AppLocalizations.of(context)!.house,
                          color: tab == 'house' ? white : light,
                          onTap: () => setState(() {
                            tab = 'house';
                            _productController.getHouse();
                          }),
                        ),
                        smallHSpace(),
                        MenuTitle(
                          icon: CustomIconsFenix.apartment,
                          title: AppLocalizations.of(context)!.apartment,
                          color: tab == 'apartment' ? white : light,
                          onTap: () => setState(() {
                            tab = 'apartment';
                            _productController.getApartments();
                          }),
                        ),
                        smallHSpace(),
                        MenuTitle(
                          icon: FontAwesomeIcons.car,
                          title: AppLocalizations.of(context)!.car,
                          color: tab == 'car' ? white : light,
                          onTap: () => setState(() {
                            tab = 'car';
                            _productController.getVehicle();
                          }),
                        ),
                        smallHSpace(),
                        MenuTitle(
                          icon: FontAwesomeIcons.television,
                          title: AppLocalizations.of(context)!.electronics,
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
          controller: homeScrollController,
          children: [

            Container(
                height: 30.w,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  gradient: gradient(
                    const Color(0xFF691232),
                    const Color(0xFF1770A2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 17.w, color: white),
                    tinyHSpace(),
                    SizedBox(
                      width: width() * 0.88,
                      child: Obx(() => Text(_userController.currentAddress.value,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 13.w,
                          color: white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),),
                    )
                  ],
                )),

            SizedBox(
              height: height() * 0.35,
              width: MediaQuery.of(context).size.width,
              child: PageView(
               controller: _pageController,
                physics:  const NeverScrollableScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/banner/Banner1.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/banner/Banner2.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/banner/Banner3.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/banner/Banner4.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/banner/Banner5.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),

              kSpacing,
              SizedBox(
                height: 152.w,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Get.to(() => const ProductDetails());
                      },
                      child: Container(
                        width: 114.w,
                        height: 152.w,
                        margin: EdgeInsets.all(4.5.w),

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13.w),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/slides/${slides[index]}.png"
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                        // child: Image.asset(
                        //   "assets/images/slides/${slides[index]}.png",
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 57.w,
                  margin: EdgeInsets.symmetric(vertical: 17.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F4167),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF1F4167),
                          Color(0xFF125EB7),
                          Color(0xFF0777FB),
                        ],
                        stops: [
                          0.0,
                          0.5,
                          1.0
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        tileMode: TileMode.repeated),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 5.w),
                          child: Icon(
                            CustomIcons.crown_badge,
                            color: const Color(0xFFFCC70A),
                            size: 42.w,
                          )),
                      Text(
                        "Top 10 Rated Items",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
        Obx(
              () => _productController
              .isFetchingApartments.isTrue
              ? const Loader()
              : _productController
              .apartmentList.isEmpty
              ? empty(tab)
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                          Get.to(() => ApartmentDetails(
                            apartment: _productController.apartmentList[index],
                          ));
                      },
                        child: RatedItemsWidget(apartment: _productController.apartmentList[index],),
                    );
                  }),),

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
                    "Recently Viewed Items",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                height: 160.w,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const RecentlyViewed();
                    }),
              ),
              SizedBox(
                height: 160.w,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const RecentlyViewed();
                    }),
              ),
              Divider(
                color: const Color(0xFF1994F5).withOpacity(0.22),
                thickness: 5,
                height: 50.w,
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 57.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 17.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1F4167),
                      gradient: gradient(
                          const Color(0xFF1F4167), const Color(0xFF0777FB))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomIcons.best_selling,
                            color: const Color(0xFFE48C24),
                            size: 37.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Best Selling Items",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18.w,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => DealsDetails(title: "Best Selling Items", item: _productController.apartmentList));
                        },
                        child: Container(
                          height: 24.w,
                          width: 75.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "More",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.menu,
                                color: kTextBlackColor,
                                size: 15.w,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
        Obx(
              () => _productController
              .isFetchingApartments.isTrue
              ? const Loader()
              : _productController
              .apartmentList.isEmpty
              ? empty(tab)
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[1],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[1]['title'],
                        category: _productController.apartmentList[1][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[1]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[1]
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[2],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[2]['title'],
                        category: _productController.apartmentList[2][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[2]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[2]
                    ),
                  ),
                ],
              ),),

              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 57.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 17.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1F4167),
                      gradient: gradient(
                          const Color(0xFF1F4167), const Color(0xFF0777FB))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomIcons.top_deals,
                            color: const Color(0xFFE48C24),
                            size: 33.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Top Deals",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18.w,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => DealsDetails(
                            title: "Top Deals",
                              item: _productController.apartmentList
                          ));
                        },
                        child: Container(
                          height: 24.w,
                          width: 75.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "More",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.menu,
                                color: kTextBlackColor,
                                size: 15.w,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
        Obx(
              () => _productController
              .isFetchingApartments.isTrue
              ? const Loader()
              : _productController
              .apartmentList.isEmpty
              ? empty(tab)
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[1],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[1]['title'],
                        category: _productController.apartmentList[1][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[1]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[1]
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[2],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[2]['title'],
                        category: _productController.apartmentList[2][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[2]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[2]
                    ),
                  ),
                ],
              ),),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 57.w,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 17.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1F4167),
                      gradient: gradient(
                          const Color(0xFF1F4167), const Color(0xFF0777FB))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CustomIcons.recommended_deals,
                            color: const Color(0xFFE48C24),
                            size: 33.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Recommended Deals",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 18.w,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => DealsDetails(
                            title: "Recommended Deals",
                              item: _productController.apartmentList
                          ));
                        },
                        child: Container(
                          height: 24.w,
                          width: 75.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "More",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.menu,
                                color: kTextBlackColor,
                                size: 15.w,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
        Obx(
              () => _productController
              .isFetchingApartments.isTrue
              ? const Loader()
              : _productController
              .apartmentList.isEmpty
              ? empty(tab)
              :  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[1],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[1]['title'],
                        category: _productController.apartmentList[1][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[1]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[1]
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => ApartmentDetails(
                        apartment: _productController.apartmentList[2],
                      ));
                    },
                    child: ProductWidget(
                        title: _productController.apartmentList[2]['title'],
                        category: _productController.apartmentList[2][
                        'apartmentType'],
                        price:
                        _productController.apartmentList[2]['rentPrice']
                        ['month']
                            .toString(),
                        product: _productController.apartmentList[2]
                    ),
                  ),
                ],
              ),),

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
                  AppLocalizations.of(context)!.regularSellingItems,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )),

            SizedBox(
              height: 152.w,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Get.to(() => const ProductDetails());
                    },
                    child: Container(
                      width: 114.w,
                      height: 152.w,
                      margin: EdgeInsets.all(4.5.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.w),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/slides/${slides[index]}.png"
                              ),
                              fit: BoxFit.fitWidth
                          )
                      ),
                      // child: Image.asset(
                      //   "assets/images/slides/${slides[index]}.png",
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  );
                },
              ),
            ),

            kSpacing,

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
                                0.51,
                            childAspectRatio: 1 / 2.2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
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
                                0.51,
                            childAspectRatio:
                            1 / 2.2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
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
                                0.51,
                            childAspectRatio:
                            1 / 2.2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
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
    ) : SearchAndHistory());
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


  RxBool liked = false.obs;

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
          width: MediaQuery.of(context).size.width * 0.495,
          margin: EdgeInsets.symmetric(horizontal: 0.w),
          decoration: BoxDecoration(
              color: const Color(0xFFDAE5F2),
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  // changes position of shadow
                ),
                BoxShadow(
                  color:  Colors.white.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(-1, 0), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width * 0.495,
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
                width: MediaQuery.of(context).size.width * 0.495,
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

                                          Text(
                                            "${distanceInKm(
                                              _userController.userCurrentPosition!.value.latitude,
                                              _userController.userCurrentPosition!.value.longitude,
                                              product['location']['latitude'].runtimeType == double ? product['location']['latitude'] : double.parse(product['location']['latitude']),
                                              product['location']['longitude'].runtimeType == double ? product['location']['longitude'] : double.parse(product['location']['longitude']),
                                            ).toString()}km",
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
            onTap: () async{

              if(product['isLiked'] == true){
                liked.value = false;
                _userController.deleteItemFromWishList(
                    _userController.getToken(), product['id'], category);
              }
              else if(product['isLiked']  == true || liked.value == true){
                liked.value = false;
                _userController.deleteItemFromWishList(
                    _userController.getToken(), product['id'], category);
              }
              else{
                liked.value = true;
                _userController.addItemToWishList(
                    _userController.getToken(), product['id'], category);
              }
            },
            child: Obx(() => (liked.value == true || product['isLiked']  == true) ? Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFFA4788),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child:  Icon(Icons.favorite,
                  color: white,
                  size: 23,
                ),

              ),
            ) : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.favorite_border,
              color: kTextBlackColor,
              size: 23,
              ),
            ),)
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
