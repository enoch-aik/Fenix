import 'package:fenix/const.dart';
import 'package:fenix/helpers/categories.dart';
import 'package:fenix/helpers/icons/custom_icons_fenix_icons.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/profile/create_selling_post/create_apartment.dart';
import 'package:fenix/screens/profile/create_selling_post/create_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../theme.dart';
import '../../onboarding/constants.dart';
import 'create_car.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellingPost extends StatefulWidget {
  SellingPost(
      {Key? key,
      required this.storeId,
      required this.storeName,
      required this.storeLocation})
      : super(key: key);
  final String storeId, storeName, storeLocation;

  @override
  State<SellingPost> createState() => _SellingPostState();
}

class _SellingPostState extends State<SellingPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            height() * 0.1),
        child: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  backArrow(),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.050,
                    width: MediaQuery.of(context).size.width * 0.80,
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
                        hintText: AppLocalizations.of(context)!.searchFenix,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: 17.w, color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search, size: 30.w,),
                        suffixIcon: Icon(
                          Icons.qr_code_scanner,
                          color: primary,
                          size: 26.w,
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => CreateApartment(
                    storeId: widget.storeId,
                    apartmentType: Category().property[1]));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.apartment,
                subtitle: "Create Rent/Selling Post",
                icon: Icon(CustomIconsFenix.apartment, size: 30.w,),
                backgroundImage: 'assets/images/apartment 1.png',
              ),
            ),
            smallSpace(),
            InkWell(
              onTap: () {
                Get.to(() => CreateApartment(
                    storeId: widget.storeId,
                    apartmentType: Category().property[2]));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.house,
                subtitle: "Create House Rent/Selling Post",
                icon: Icon(CustomIconsFenix.house, size: 30.w,),
                backgroundImage: 'assets/images/house.png',
              ),
            ),
            smallSpace(),
            InkWell(
              onTap: () {
                Get.to(() => CreateApartment(
                      storeId: widget.storeId,
                      apartmentType: Category().property[0],
                    ));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.dacha,
                subtitle: "Create Dacha Rent/Selling Post",
                icon: Icon(CustomIconsFenix.dacha,  size: 30.w,),
                backgroundImage: 'assets/images/house.png',
              ),
            ),
            smallSpace(),
            InkWell(
              onTap: () {
                Get.to(() => CreateCar(
                      storeId: widget.storeId,
                    ));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.car,
                subtitle: "Sell Cars",
                icon: Icon(FontAwesomeIcons.car, size: 25.w,),
                backgroundImage: 'assets/images/cars.png',
              ),
            ),
            smallSpace(),
            InkWell(
              onTap: () {
                Get.to(() => CreateProduct(
                      storeId: widget.storeId,
                      type: "",
                    ));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.electronics,
                subtitle: "Sell Electronics",
                icon: Icon(Icons.tv,  size: 27.w,),
                backgroundImage: 'assets/images/electronicslisting.png',
              ),
            ),
            smallSpace(),
            InkWell(
              onTap: () {
                Get.to(() => CreateProduct(
                  storeId: widget.storeId,
                  type: "Other",
                ));
              },
              child: SellingPostCard(
                title: AppLocalizations.of(context)!.others,
                subtitle: "Sell Other Products",
                icon: Icon(FontAwesomeIcons.cartShopping,  size: 25.w,),
                backgroundImage: 'assets/images/clothing.png',
              ),
            ),

            smallSpace(),
          ],
        ),
      ),
    );
  }
}

class SellingPostCard extends StatelessWidget {
  String? title;
  String? subtitle;
  Widget? icon;
  String? backgroundImage;

  SellingPostCard(
      {Key? key, this.title, this.subtitle, this.icon, this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.w),
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(backgroundImage!), fit: BoxFit.fill)),
        ),
        Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.070,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  color: background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        icon!,
                        smallHSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13.5.w,
                              ),
                            ),
                            tiny5Space(),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 10.5.w),
                            )
                          ],
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: blue,
                          size: 20.w,
                        ))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
