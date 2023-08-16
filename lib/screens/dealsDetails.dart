import 'dart:async';

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/recently_viewed_widget.dart';
import 'package:fenix/screens/products/apartment_details.dart';
import 'package:fenix/screens/profile/subscribe/subscribe.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../controller/user_controller.dart';
import '../helpers/distance_calculator.dart';
import '../helpers/icons/custom_icons_icons.dart';
import '../helpers/widgets/top_rated_Items.dart';
import '../theme.dart';
import 'home/search.dart';
import 'onboarding/constants.dart';

class DealsDetails extends StatefulWidget {
  String? title;
  var item;

  DealsDetails({Key? key, this.title, this.item}) : super(key: key);

  @override
  State<DealsDetails> createState() => _DealsDetailsState();
}

class _DealsDetailsState extends State<DealsDetails> {

  PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  Timer? _timer;

   @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.06),
        child: Container(
          decoration: new BoxDecoration(
            gradient:  appBarGradient,
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  backArrow(),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
              width:MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
              decoration: BoxDecoration(
                  color: const Color(0xFF1F4167),
                  gradient: gradient(const Color(0xFF1F4167), const Color(0xFF0777FB))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      (widget.title! == "Best Selling Items") ? Icon(CustomIcons.best_selling, color: const Color(0xFFE48C24), size: 37.w,)
                      : (widget.title! == "Top Deals") ?  Icon(CustomIcons.top_deals, color: const Color(0xFFE48C24), size: 33.w,)
                      :  Icon(CustomIcons.recommended_deals, color: const Color(0xFFE48C24), size: 33.w,),



                      SizedBox(width: 10.w,),
                      Text(widget.title!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),
                    ],
                  ),

                ],
              )
          ),

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

          Container(
              width:MediaQuery.of(context).size.width,
              height:57.w,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 17.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
              decoration: BoxDecoration(
                  color: const Color(0xFF1F4167),
                  gradient: gradient(const Color(0xFF1F4167), const Color(0xFF0777FB))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Buy some spot for your post",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),),
                  InkWell(
                    onTap: (){
                      Get.to(() => Subscribe());
                    },
                    child: Container(
                      height: 24.w,
                      width: 95.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCE9F4),
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Center(
                        child: Text("Buy",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 13.w,
                              fontWeight: FontWeight.w700
                          ),),
                      ),
                    ),
                  )
                ],
              )
          ),


          GridView.builder(
              primary: false,
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                childAspectRatio: 1 / 2.2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: widget.item.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Get.to(() => ApartmentDetails(
                      apartment: widget.item[index],
                    ));
                  },
                  child: ProductWidget(
                      title: widget.item[index]['title'],
                      category: widget.item[index]['apartmentType'],
                      price: widget.item[index]['rentPrice']['month']
                          .toString(),
                      product: widget.item[index]
                  ),
                );
              }),

        ],
      ),
    );
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
