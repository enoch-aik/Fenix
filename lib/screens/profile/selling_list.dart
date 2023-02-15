import 'package:fenix/screens/profile/product_list_widget.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../onboarding/constants.dart';

class SellingList extends StatefulWidget {
  const SellingList({Key? key}) : super(key: key);

  @override
  State<SellingList> createState() => _SellingListState();
}

class _SellingListState extends State<SellingList> {

  List title = [
    "Your Account",
    "Your Message",
    "Create Selling Post",
    "Subscribe",
    "Your Wishlist",
    "Your Selling",
    "Language",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 46.h,
            child: Image.asset("assets/images/fenixWhite2.png",fit: BoxFit.fill,),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width * 0.15, ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    ),
                    Text("Your Selling List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.w,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(color: Colors.black.withOpacity(0.2), offset: Offset(2,2))
                          ]
                      ),),
                  ],
                )
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          // actions: [
          //   SizedBox(
          //     width: MediaQuery.of(context).size.width * 0.4,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Icon(Icons.notifications_none, color: Colors.white, size: 27.w,),
          //         Icon(Icons.search, color: Colors.white, size: 27.w,),
          //         Icon(Icons.logout, color: Colors.white, size: 27.w,),
          //       ],
          //     ),
          //   ),
          // ],
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2(Color(0xFF46E0C4),
                Color(0xFF59B5C0),),
            ),
          )),
      body: Container(
        color: Color(0xFFE4EFF9),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: 20.w,),

            GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate:
                SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  childAspectRatio: 1 / 2.7,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                itemCount: 10,
                itemBuilder: (context, c){
                  return ProductListWidget();
                }),



            SizedBox(height: 20.w,),


            Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Post List",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.w,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Text("See all",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.w,
                        fontWeight: FontWeight.w400,
                      ),)
                  ],
                )
            ),


            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.3 / 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount:9,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: [
                      Container(
                        height: 66.w,
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                        decoration: BoxDecoration(
                          color: Color(0xFFE4EFF9),
                          borderRadius: BorderRadius.circular(17.w),
                          border: Border.all(color: Color(0xFf334669), width: 0.1),
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xFFDBE6F2).withOpacity(0.2),
                                Color(0xFF8F9FAE).withOpacity(0.2),
                              ],
                              stops: [0.0,0.5, 1.0],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              tileMode: TileMode.repeated
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(1, 0), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(1, 1), // changes position of shadow
                            ),


                          ],
                        ),
                      ),
                      Text("great house for...",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 11.w,
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                        ),),
                    ],
                  );
                }),

          ],
        ),
      ),
    );
  }
}
