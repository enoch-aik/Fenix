import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/widgets/loader.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/product_controller.dart';
import '../../controller/user_controller.dart';
import '../../helpers/typography.dart';
import '../onboarding/constants.dart';

class SearchScreen extends StatefulWidget {

  var searchText;
  var carResult;
  var apartmentResult;
  var productResult;

   SearchScreen({Key? key, this.carResult, this.apartmentResult, this.productResult, this.searchText}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool enableFilter = false;


  final ProductController _productController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _productController.isSearching.value = false;
  }



  InkWell tabSwitch(title) {
    return InkWell(
      onTap: () {
        setState(() {
          _productController.tab = title;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color:
                      _productController.tab == title ? primary : lightGrey.withOpacity(0.5),
                      width: 3))),
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: articleFontMedium2(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.08),

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: gradient(
                  const Color(0xFF691232),
                  const Color(0xFF1770A2),
                ),
              ),
              padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w, bottom: 7.w),
              child: Row(
                children: [
                  backArrow(),
                ],
              ),
            ),
            Obx(() => (_productController.isSearching.value == false) ? const SizedBox() :  const LineLoader(),)
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(() => (_productController.isSearching.value == false) ? Column(
                    children: [
                      (_productController.vehicleList.isEmpty &&
                          _productController.apartmentList.isEmpty &&
                          _productController.productList.isEmpty) ? SizedBox() : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            if(_productController.vehicleList.isNotEmpty)
                              tabSwitch("Cars"),
                            if(_productController.apartmentList.isNotEmpty)
                              tabSwitch("Apartments"),
                            if(_productController.productList.isNotEmpty)
                              tabSwitch("Products")

                          ],
                        ),
                      ),
                      (_productController.vehicleList.isEmpty &&
                          _productController.apartmentList.isEmpty &&
                          _productController.productList.isEmpty) ? SizedBox() : Divider(
                        thickness: 4,
                        color: lightGrey.withOpacity(0.4),
                      ),

                      if(_productController.vehicleList.isEmpty &&
                          _productController.apartmentList.isEmpty &&
                          _productController.productList.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: SizedBox(
                            width: width(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("No results for '${widget.searchText}'.",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                ),),
                                Text("Try checking your spelling or use more general terms",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w400,
                                  ),),
                                Padding(
                                  padding: EdgeInsets.all(30.w),
                                  child: Image.asset("assets/images/EmptyPage.png"),
                                ),
                                smallSpace(),
                                Text("Related searches",
                                  style: GoogleFonts.roboto(
                                    fontSize: 17.w,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                tinySpace(),
                                GridView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent:
                                        MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.5,
                                        childAspectRatio: 1 / 0.30,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return  Container(
                                          width: width() * 0.47,
                                          padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30),
                                          margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 2.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 0.2, color: grey),
                                              borderRadius: BorderRadius.circular(3.w)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.search, size: 18,),
                                              smallHSpace(),
                                              Text("ceramic planter",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12.w,
                                                  fontWeight: FontWeight.w500,
                                                ),),],
                                          )
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),

                      if(_productController.tab == "Cars")
                        GridView.builder(
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
                            itemCount: _productController.vehicleList.length,
                            itemBuilder: (context, index) {
                              var item = _productController.vehicleList[index];
                              return InkWell(
                                  onTap: () {
                                    // Get.to(() => ProductDetails(
                                    //   product:
                                    //   _productController
                                    //       .productList[
                                    //   index],
                                    // ));
                                  },
                                  child: ProductWidget(
                                      title: item['title'],
                                      price: item['price']
                                          .toString(),
                                      category: 'Electronics',
                                      product: item));
                            }),

                      if(_productController.tab == "Apartments")
                        GridView.builder(
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
                            itemCount: _productController.apartmentList.length,
                            itemBuilder: (context, index) {
                              var item = _productController.apartmentList[index];
                              return InkWell(
                                  onTap: () {
                                    // Get.to(() => ProductDetails(
                                    //   product:
                                    //   _productController
                                    //       .productList[
                                    //   index],
                                    // ));
                                  },
                                  child: ProductWidget(
                                      title: item['title'],
                                      price: item['price']
                                          .toString(),
                                      category: 'Electronics',
                                      product: item));
                            }),

                      if(_productController.tab == "Products")
                        GridView.builder(
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
                            itemCount: _productController.productList.length,
                            itemBuilder: (context, index) {
                              var item = _productController.productList[index];
                              return InkWell(
                                  onTap: () {
                                    // Get.to(() => ProductDetails(
                                    //   product:
                                    //   _productController
                                    //       .productList[
                                    //   index],
                                    // ));
                                  },
                                  child: ProductWidget(
                                      title: item['title'],
                                      price: item['price']
                                          .toString(),
                                      category: 'Electronics',
                                      product: item));
                            }),

                    ],
                  ) :  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Loader(),
                  ),)
          ),
          // if (enableFilter)
          //   Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 80, 15, 0),
          //     child: Container(
          //       height: height() * 0.3,
          //       width: width(),
          //       decoration: BoxDecoration(
          //           color: dark.withOpacity(0.95), borderRadius: BorderRadius.circular(10)),
          //     ),
          //   )
        ],
      ),
    );
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
              SizedBox(
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
