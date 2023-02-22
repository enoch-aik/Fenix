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




          ],
        ),
      ),
    );
  }
}
