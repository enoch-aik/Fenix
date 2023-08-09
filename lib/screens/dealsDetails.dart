import 'package:fenix/helpers/widgets/recently_viewed_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../helpers/icons/custom_icons_icons.dart';
import '../helpers/widgets/top_rated_Items.dart';
import 'home/search.dart';
import 'onboarding/constants.dart';

class DealsDetails extends StatefulWidget {
  String? title;

  DealsDetails({Key? key, this.title}) : super(key: key);

  @override
  State<DealsDetails> createState() => _DealsDetailsState();
}

class _DealsDetailsState extends State<DealsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.123),
        child: Container(
          decoration: new BoxDecoration(
            gradient:  gradient(const Color(0xFF1A9AFF), const Color(0xFF54FADC),),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: Image.asset("assets/images/fenixWhite2.png",fit: BoxFit.fill,),
                ),
              ),

              const SizedBox(width: 10,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                      child: const Icon(Icons.arrow_back_ios,  color: Colors.white,)),
                  InkWell(
                    // onTap: ()=>Get.to(()=>const SearchScreen()),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.w),
                        color: Colors.white,
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16.w,
                        ),
                        enabled: false,

                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: MediaQuery.of(context).size.height * 0.015),
                          hintText: "Search Fenix",
                          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15.w,
                              color: Colors.grey.shade500
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(
                height: MediaQuery.of(context).size.height * 0.010,
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
            height: 276.w,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              children: [
                Image.asset("assets/images/card.png",fit: BoxFit.fitWidth,),
                Image.asset("assets/images/cokeAd.png",fit: BoxFit.fitWidth,),
                Image.asset("assets/images/logoFrame.png",fit: BoxFit.fill,),
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
                      Get.to(() => DealsDetails());
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
                childAspectRatio: 1 / 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: 10,
              itemBuilder: (context, c){
                return const ProductWidget();
              }),

        ],
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.42,
          width: MediaQuery.of(context).size.width * 0.452,
          margin: EdgeInsets.symmetric(horizontal: 9.w),
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
              ]
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.455,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  image: const DecorationImage(image: AssetImage("assets/images/house.png"), fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: 10.w,),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.455,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: SizedBox(
                        height:100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery info will  be here dg likseller offer sajncnask...",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 12.w,
                                  color: const Color(0xFF334669),
                                  fontWeight: FontWeight.w700
                              ),),
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
                                        full: const Icon(Icons.star, color: Colors.orange),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Colors.orange,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.grey,
                                        )),
                                    onRatingUpdate: (value) {

                                    }),
                                SizedBox(width: 10.w,),
                                Text("259 reviews.",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 10.w,
                                      color: const Color(0xFF334669).withOpacity(0.6),
                                      fontWeight: FontWeight.w500
                                  ),),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                SizedBox(width: 10.w,),
                                Text("United State, Florida 3340",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 11.w,
                                      color: const Color(0xFF334669).withOpacity(0.6),
                                      fontWeight: FontWeight.w400
                                  ),),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.fire_truck),
                                SizedBox(width: 10.w,),
                                Text("Free Shipping",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 12.w,
                                      color: const Color(0xFF0F7D46),
                                      fontWeight: FontWeight.w500
                                  ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),


                    Text("17,000   so’m",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15.w,
                          color: const Color(0xFFCE242B),
                          fontWeight: FontWeight.w800
                      ),),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 7,
          right: 20,
          child: Icon(FontAwesomeIcons.heart, color: kTextBlackColor,),
        )
      ],
    );
  }
}

