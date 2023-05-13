import 'package:fenix/helpers/widgets/recently_viewed_widget.dart';
import 'package:fenix/screens/categories/sub_sub_category.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../helpers/widgets/text.dart';
import '../../helpers/widgets/top_rated_Items.dart';
import '../onboarding/constants.dart';

class SubCategory extends StatefulWidget {

  List? category;


  SubCategory({this.category, Key? key}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    print(widget.category);
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.155),
        child: Container(
          decoration: BoxDecoration(
            gradient:  gradient(
              const Color(0xFF691232),
              const Color(0xFF1770A2),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 46.h,
                  child: Image.asset("assets/images/fenixWhilte.png",fit: BoxFit.fill,),
                ),
              ),

              SizedBox(width: 10,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  ),
                  Container(
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
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: MediaQuery.of(context).size.height * 0.015),
                        hintText: "Search Fenix",
                        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15.w,
                            color: Colors.grey.shade500
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15.w, right: 15.w, left: 25.w,),
        child: ListView.builder(
          itemCount: widget.category!.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Get.to(() => SubSubCategory(category: widget.category![index]["products"],));
              },
              child: Row(
                children: [
                  Container(
                    height: 64.w,
                    width: 87.w,
                    padding: EdgeInsets.all(3.w),
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/categoryCard.png"),fit: BoxFit.scaleDown)
                    ),
                  ),
                  SizedBox(width: 18.w,),

                  KText(widget.category![index]['name'],
                    fontSize: 15.w,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            );
          },
        ),
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
          width: MediaQuery.of(context).size.width * 0.455,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
              color: Color(0xFFDAE5F2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(-3, -6), // changes position of shadow
                ),
              ]
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.455,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/house.png"), fit: BoxFit.fill,),
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
                    SizedBox(
                      height:100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery info will  be here dg likseller offer sajncnask...",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 12.w,
                                color: Color(0xFF334669),
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
                                    color: Color(0xFF334669).withOpacity(0.6),
                                    fontWeight: FontWeight.w500
                                ),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 10.w,),
                              Text("United State, Florida 3340",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 11.w,
                                    color: Color(0xFF334669).withOpacity(0.6),
                                    fontWeight: FontWeight.w400
                                ),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.fire_truck),
                              SizedBox(width: 10.w,),
                              Text("Free Shipping",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12.w,
                                    color: Color(0xFF0F7D46),
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ],
                      ),
                    ),


                    Text("17,000   so’m",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15.w,
                          color: Color(0xFFCE242B),
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
          right: 15,
          child: Icon(FontAwesomeIcons.heart, color: kTextBlackColor,),
        )
      ],
    );
  }
}

