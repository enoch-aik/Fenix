import 'package:fenix/const.dart';
import 'package:fenix/screens/profile/create_apartment.dart';
import 'package:fenix/screens/profile/create_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme.dart';
import '../onboarding/constants.dart';

class SellingPost extends StatefulWidget {
  const SellingPost({Key? key}) : super(key: key);

  @override
  State<SellingPost> createState() => _SellingPostState();
}

class _SellingPostState extends State<SellingPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.08),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              Color(0xFF1A9AFF),
              Color(0xFF54FADC),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical:
                            MediaQuery.of(context).size.height * 0.015),
                        hintText: "Search Fenix",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            fontSize: 15.w, color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.qr_code_scanner,color: primary,),
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(children: [

          InkWell(
            onTap: (){
              Get.to(() => CreateApartment(storeId: "1",));
            },
            child: SellingPostCard(
              title: "Apartment",
              icon:'assets/images/icons/apartment.png',
              backgroundImage: 'assets/images/apartment 1.png',
            ),
          ),
          smallSpace(),
          
          InkWell(
            onTap: (){
              Get.to(() => CreateProduct(storeId: "1",));
            },
            child: SellingPostCard(
              title: "Product",
              icon:'assets/images/icons/carRental.png',
              backgroundImage: 'assets/images/apartment 1.png',
            ),
          ),
        ],),
      ),
    );
  }
}

class SellingPostCard extends StatelessWidget {

  String? title;
  String? icon;
  String? backgroundImage;

  SellingPostCard({
    Key? key, this.title, this.icon, this.backgroundImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.w),
            color: Colors.red,
            image: DecorationImage(image: AssetImage(backgroundImage!), fit: BoxFit.fill)
          ),
        ),

        Positioned(
          bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.070,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal:12.w, vertical: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  color: background,
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(icon!, scale: 0.6,),
                        smallHSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title!,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.5.w,
                              ),),
                            tiny5Space(),
                            Text("Create Rent/Selling Post",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10.5.w
                              ),)
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_forward_ios, color: blue, size: 20.w,))
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}
