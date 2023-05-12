import 'dart:math' as math;

import 'package:fenix/helpers/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../helpers/icons/custom_icons_icons.dart';
import '../../helpers/widgets/slider.dart';
import '../../neumorph.dart';
import '../../theme.dart';
import '../home/search.dart';
import '../onboarding/constants.dart';

class ApartmentDetails extends StatefulWidget {
  const ApartmentDetails({Key? key, this.apartment}) : super(key: key);
  final apartment;

  @override
  State<ApartmentDetails> createState() => _ApartmentDetailsState();
}

class _ApartmentDetailsState extends State<ApartmentDetails>
    with TickerProviderStateMixin {
  int temperature = 0;
  int currentIn = 0;
  ValueNotifier<bool> ac = ValueNotifier(false);

  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.apartment);
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery
            .of(context)
            .size
            .width,
            MediaQuery
                .of(context)
                .size
                .height * 0.13),
        child: Container(
          decoration:  BoxDecoration(
            gradient: gradient(
              const Color(0xFF1A9AFF),
              const Color(0xFF54FADC),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,
                  child: Image.asset(
                    "assets/images/fenix_c.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => const SearchScreen()),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.050,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.85,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.015),
                          hintText: "Search Fenix",
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              fontSize: 15.w, color: Colors.grey.shade500),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.010,
              )
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              SizedBox(
                  height: height() * 0.5,
                  width: width(),
                  child: PageView.builder(
                    onPageChanged: (v) {
                      setState(() {
                        currentIn = v;
                      });
                    },
                    itemBuilder: (c, i) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "assets/images/house.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    itemCount: 3,
                  )),
              Positioned(
                  right: 20,
                  top: 20,
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: black),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: white,
                        ),
                      ))),

              Positioned(
                right: 10,
                left: 10,
                bottom: 20,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                            (i) =>
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: currentIn == i? 18:10,
                                width: currentIn == i? 18:10,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/icons/dot.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle),
                              ),
                            ))),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  widget.apartment['title'] ?? "Brand Apple",
                  color: const Color(0xFF0B85E6),
                  fontWeight: FontWeight.w700,
                  fontSize: 19.w,
                ),
                SizedBox(
                  height: 3.w,
                ),
                KText(
                  widget.apartment['description'] ??
                      "Iphone 14 pro max Bsf sddsef cajcas dcsdc sd Optio out there fcjabc cahsccbaccdcdcd gdf dgdgdrg dg",
                  fontWeight: FontWeight.w500,
                  fontSize: 15.w,
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 7.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      "${widget.apartment['rentPrice']['night'] ?? ' 87,000'} so'm",
                      fontWeight: FontWeight.w700,
                      fontSize: 22.w,
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      children: [
                        KText(
                          "Last Price",
                          color: const Color(0xFF93A6BA),
                          fontWeight: FontWeight.w700,
                          fontSize: 15.w,
                        ),
                        SizedBox(width: 11.w),
                        KText(
                          "95,700  so'm",
                          color: const Color(0xFF93A6BA),
                          fontWeight: FontWeight.w700,
                          fontSize: 15.w,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 32.w,
                  padding:
                  EdgeInsets.symmetric(horizontal: 19.w, vertical: 5.w),
                  decoration: shadow(),
                  child: KText(
                    "-10 %",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.6,
                  padding:
                  EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.w),
                  decoration: shadow(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        "Colors:  ${widget.apartment['specifics']['color']}",
                        fontSize: 15.w,
                        fontWeight: FontWeight.w500,
                      ),
                      Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: kTextBlackColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 32.w,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.22,
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.w),
                  decoration: shadow(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        "Qty:    ${widget.apartment['specifics']['quantity']}",
                        fontSize: 15.w,
                        fontWeight: FontWeight.w500,
                      ),
                      // Icon(
                      //   Icons.arrow_drop_down,
                      //   color: kTextBlackColor,
                      //   size: 20,
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: kTextBlackColor,
                    labelStyle:
                    TextStyle(fontSize: 18.w, fontWeight: FontWeight.w500),
                    tabs: const [
                      Tab(
                        text: "Delivery",
                      ),
                      Tab(
                        text: "Pick Up",
                      )
                    ],
                  ),
                ),
                tinySpace(),
                SizedBox(
                  height: 147.w,
                  child: TabBarView(
                    // swipe navigation handling is not supported
                    controller: _tabController,
                    children: [
                      Container(
                          child: KText(
                            "Delivery info will  be here like seller offer to shvbhjsbvj vsdhvsdvvhsdjbvhjsdbvjhsdbvhsdbvjhsbdjvhbsdjvbsdjhvbjhbvjsddhvbshdbhjvbsjhdbvjhsdbvjhsdbvjhsdbvjhsdbvjhsdbvjhsdbvjhs"
                                "delivry, day took for delivery and so on hsdbvjhbsdvjhshjvsdhjvhs",
                            fontSize: 13.w,
                            fontWeight: FontWeight.w500,
                          ),
                          height: 147.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.w, vertical: 5.w),
                          margin: EdgeInsets.all(4.w),
                          decoration: depressNeumorph()),
                      Container(
                          child: KText(
                            "Delivery info will  be here like seller offer to shvbhjsbvj vsdhvsdvvhsdjbvhjsdbvjhsdbvhsdbvjhsbdjvhbsdjvbsdjhvbjhbvjsddhvbshdbhjvbsjhdbvjhsdbvjhsdbvjhsdbvjhsdbvjhsdbvjhsdbvjhs"
                                "delivry, day took for delivery and so on hsdbvjhbsdvjhshjvsdhjvhs",
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                          ),
                          height: 147.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.w, vertical: 5.w),
                          margin: EdgeInsets.all(4.w),
                          decoration: depressNeumorph()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 50.w,
            color: const Color(0xFF1994F5).withOpacity(0.22),
            thickness: 10.w,
          ),
          Buttons(
            child: Center(
              child: KText(
                "Pay Cash",
                color: const Color(0xFFE86709),
                fontWeight: FontWeight.w700,
                fontSize: 18.w,
              ),
            ),
          ),
          Buttons(
            child: Center(
              child: KText(
                "Message Seller",
                color: const Color(0xFF1994F5),
                fontWeight: FontWeight.w700,
                fontSize: 18.w,
              ),
            ),
          ),
          Buttons(
            child: Center(
              child: KText(
                "Add to Wishlist",
                color: const Color(0xFF2E476E),
                fontWeight: FontWeight.w500,
                fontSize: 18.w,
              ),
            ),
          ),
          Buttons(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CustomIcons.crown_badge,
                  color: const Color(0xFF2E476E),
                  size: 30.w,
                ),
                KText(
                  "Report Issue",
                  color: const Color(0xFF2E476E),
                  fontWeight: FontWeight.w700,
                  fontSize: 18.w,
                ),
                const SizedBox(),
              ],
            ),
          ),
          // Divider(
          //   height: 50.w,
          //   color: const Color(0xFF1994F5).withOpacity(0.22),
          //   thickness: 10.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 14.w),
          //   child: KText(
          //     "apartment Details",
          //     color: kTextBlackColor,
          //     fontWeight: FontWeight.w900,
          //     fontSize: 22.w,
          //   ),
          // ),
          // ProductDetailProperty(
          //   property: "Condition: ${widget.apartment['specifics']['condition']}",
          // ),
          // ProductDetailProperty(
          //   property: "Quantity: ${widget.apartment['specifics']['quantity']}",
          // ),
          // ProductDetailProperty(
          //   property: "Item Number: 5",
          // ),
          // ProductDetailProperty(
          //   property: "Material: ${widget.apartment['specifics']['material']}",
          // ),
          // ProductDetailProperty(
          //   property: "Brand: ${widget.apartment['specifics']['brand']}",
          // ),
          // ProductDetailProperty(
          //   property: "Size: ${widget.apartment['specifics']['size']}",
          // ),
          // ProductDetailProperty(
          //   property: "Features: ${widget.apartment['specifics']['features']}",
          // ),
          // ProductDetailProperty(
          //   property: "Category: ${widget.apartment['specifics']['category']['name']}",
          // ),
          // ProductDetailProperty(
          //   property: "Color: ${widget.apartment['specifics']['color']}",
          // ),
          // ProductDetailProperty(
          //   property: "Network: ${widget.apartment['specifics']['condition']}",
          // ),
          // ProductDetailProperty(
          //   property: "Carrier: ${widget.apartment['specifics']['condition']}",
          // ),
          // ProductDetailProperty(
          //   property: "Storage Capacity: ${widget.apartment['specifics']['storageCapacity']}",
          // ),
          // Divider(
          //   height: 50.w,
          //   color: const Color(0xFF1994F5).withOpacity(0.22),
          //   thickness: 7.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
          //   child: KText(
          //     "More Info Description",
          //     fontSize: 15.w,
          //     color: kTextBlackColor,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: KText(
          //     "${widget.apartment['specifics']['condition']} ${widget.apartment['title']}, ${widget.apartment['specifics']['category']['name']}, ${widget.apartment['specifics']['category']['subcategory']}, ${widget.apartment['description']}",
          //     fontSize: 15.w,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
          //   child: KText(
          //     "Show More >",
          //     fontSize: 15.w,
          //     color: kTextBlackColor,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          // Divider(
          //   height: 50.w,
          //   color: const Color(0xFF1994F5).withOpacity(0.22),
          //   thickness: 7.w,
          // ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.star,
          //       color: kTextBlackColor,
          //     ),
          //     KText(
          //       "4.79   16 reviews",
          //       fontWeight: FontWeight.w700,
          //       fontSize: 20.w,
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: MediaQuery
          //       .of(context)
          //       .size
          //       .height * 0.30,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: 30,
          //       itemBuilder: (context, index) {
          //         return Container(
          //           width: MediaQuery
          //               .of(context)
          //               .size
          //               .width * 0.8,
          //           padding:
          //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 19.w),
          //           margin:
          //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 19.w),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(15.w),
          //             border: Border.all(color: Colors.blue),
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 children: [
          //                   CircleAvatar(
          //                     radius: 20.w,
          //                     backgroundColor: Colors.grey.shade600,
          //                     child: const Icon(
          //                       Icons.person,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 5.w,
          //                   ),
          //                   Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       KText(
          //                         "Logan. M",
          //                         fontSize: 17.w,
          //                         color: kTextBlackColor,
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                       SizedBox(
          //                         height: 4.w,
          //                       ),
          //                       KText(
          //                         "5 hours ago",
          //                         fontSize: 10.w,
          //                         color: kTextBlackColor.withOpacity(0.6),
          //                         fontWeight: FontWeight.w700,
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 20.w,
          //               ),
          //               KText(
          //                 "Great thank you so much !!!",
          //                 fontSize: 10.w,
          //                 color: kTextBlackColor.withOpacity(0.6),
          //                 fontWeight: FontWeight.w700,
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          // ),
          // Buttons(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Icon(
          //         CustomIcons.crown_badge,
          //         color: const Color(0xFF2E476E),
          //         size: 30.w,
          //       ),
          //       KText(
          //         "Show all 16 Review",
          //         color: const Color(0xFF2E476E),
          //         fontWeight: FontWeight.w700,
          //         fontSize: 18.w,
          //       ),
          //       const SizedBox(),
          //     ],
          //   ),
          // ),
          // Divider(
          //   height: 50.w,
          //   color: const Color(0xFF1994F5).withOpacity(0.22),
          //   thickness: 7.w,
          // ),
          // Padding(
          //   padding: EdgeInsets.all(20.w),
          //   child: KText(
          //     "Seller Information",
          //     fontWeight: FontWeight.w900,
          //     color: kTextBlackColor,
          //     fontSize: 19.w,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(20.w),
          //   child: Container(
          //     height: MediaQuery
          //         .of(context)
          //         .size
          //         .width * 0.3,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   decoration: BoxDecoration(boxShadow: <BoxShadow>[
          //                     BoxShadow(
          //                         color: white.withOpacity(0.2),
          //                         offset: const Offset(4, 4),
          //                         blurRadius: 2,
          //                         spreadRadius: 1),
          //                     BoxShadow(
          //                         color: white.withOpacity(0.2),
          //                         offset: const Offset(-4, -4),
          //                         blurRadius: 2,
          //                         spreadRadius: 1),
          //                   ], color: white, shape: BoxShape.circle),
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Container(
          //                       decoration: const BoxDecoration(
          //                           color: grey, shape: BoxShape.circle),
          //                       child: const Padding(
          //                         padding: EdgeInsets.all(8.0),
          //                         child: Icon(
          //                           Icons.person,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 8.w,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     KText(
          //                       "Alex Richardson",
          //                       fontSize: 17.w,
          //                       color: const Color(0xFFE23F0A),
          //                       fontWeight: FontWeight.w900,
          //                     ),
          //                     SizedBox(
          //                       height: 15.w,
          //                     ),
          //                     KText(
          //                       "75% Positive Feedback",
          //                       fontSize: 12.w,
          //                       color: const Color(0xFF8F9FAE),
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                     SizedBox(
          //                       height: 4.w,
          //                     ),
          //                     KText(
          //                       "Since 2022",
          //                       fontSize: 12.w,
          //                       color: const Color(0xFF8F9FAE),
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ],
          //                 )
          //               ],
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Container(
          //                   decoration: shadow().copyWith(
          //                       gradient: gradient(Color(0xFFFFFFFF),
          //                           Color(0xFF8F9FAE).withOpacity(0.1))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          //                     child: Row(
          //                       children: [
          //                         Icon(
          //                           Icons.info_outline,
          //                           color: kTextBlackColor,
          //                           size: 20,
          //                         ),
          //                         tinyH5Space(),
          //                         KText(
          //                           "Report Seller",
          //                           fontSize: 12.w,
          //                           color: kTextBlackColor,
          //                           fontWeight: FontWeight.w700,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 19.w,
          //                 ),
          //                 Container(
          //                   decoration: shadow().copyWith(
          //                       gradient: gradient(Color(0xFFFFFFFF),
          //                           Color(0xFF8F9FAE).withOpacity(0.1))),
          //                   child: Padding(
          //                     padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           decoration: BoxDecoration(
          //                               shape: BoxShape.circle, color: grey),
          //                           child: Padding(
          //                             padding: const EdgeInsets.all(3.0),
          //                             child: Icon(
          //                               Icons.favorite_outline_sharp,
          //                               color: white.withOpacity(0.4),
          //                               size: 16,
          //                             ),
          //                           ),
          //                         ),
          //                         tinyH5Space(),
          //                         KText(
          //                           "Report Seller",
          //                           fontSize: 12.w,
          //                           color: kTextBlackColor,
          //                           fontWeight: FontWeight.w700,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             )
          //           ],
          //         ),
          //         SizedBox(
          //           height: 20.w,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ACControl(
          //         acState: ac,
          //         onTempChanged: (angle) {
          //           temperature = ((angle / (math.pi * 2)) * 100).toInt();
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //     smallSpace(),
          //     Expanded(
          //       child: ACControl(
          //         acState: ac,
          //         onTempChanged: (angle) {
          //           temperature = ((angle / (math.pi * 2)) * 100).toInt();
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          // Container(
          //     width: MediaQuery
          //         .of(context)
          //         .size
          //         .width,
          //     height: 40.w,
          //     alignment: Alignment.centerLeft,
          //     margin: EdgeInsets.symmetric(vertical: 17.w),
          //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
          //     decoration: BoxDecoration(
          //         color: const Color(0xFF1F4167),
          //         gradient: gradient(
          //             const Color(0xFF1F4167), const Color(0xFF0777FB))),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: 10.w,
          //             ),
          //             Text(
          //               "You Might Also Like",
          //               style: Theme
          //                   .of(context)
          //                   .textTheme
          //                   .bodyText1!
          //                   .copyWith(
          //                   fontSize: 18.w,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ],
          //         ),
          //       ],
          //     )),
          // SizedBox(
          //   height: MediaQuery
          //       .of(context)
          //       .size
          //       .height * 0.45,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: 30,
          //       itemBuilder: (context, index) {
          //         return const ProductWidget();
          //       }),
          // ),
          // SizedBox(
          //   height: MediaQuery
          //       .of(context)
          //       .size
          //       .height * 0.45,
          //   child: ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: 30,
          //       itemBuilder: (context, index) {
          //         return const ProductWidget();
          //       }),
          // ),
          // Container(
          //     width: MediaQuery
          //         .of(context)
          //         .size
          //         .width,
          //     height: 40.w,
          //     alignment: Alignment.centerLeft,
          //     margin: EdgeInsets.symmetric(vertical: 17.w),
          //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
          //     decoration: BoxDecoration(
          //         color: const Color(0xFF1F4167),
          //         gradient: gradient(
          //             const Color(0xFF1F4167), const Color(0xFF0777FB))),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SizedBox(
          //               width: 10.w,
          //             ),
          //             Text(
          //               "Most Viewed Items",
          //               style: Theme
          //                   .of(context)
          //                   .textTheme
          //                   .bodyText1!
          //                   .copyWith(
          //                   fontSize: 18.w,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ],
          //         ),
          //       ],
          //     )),
          // SizedBox(
          //   height: 152.w,
          //   width: MediaQuery
          //       .of(context)
          //       .size
          //       .width,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 7,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {},
          //         child: Container(
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
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: 152.w,
          //   width: MediaQuery
          //       .of(context)
          //       .size
          //       .width,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 7,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {},
          //         child: Container(
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
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // GridView.builder(
          //     primary: false,
          //     shrinkWrap: true,
          //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //       maxCrossAxisExtent: MediaQuery
          //           .of(context)
          //           .size
          //           .width * 0.5,
          //       childAspectRatio: 1 / 2,
          //       mainAxisSpacing: 0,
          //       crossAxisSpacing: 0,
          //     ),
          //     itemCount: 10,
          //     itemBuilder: (context, c) {
          //       return const ProductWidget();
          //     }),
          // SizedBox(
          //   height: 276.w,
          //   width: MediaQuery
          //       .of(context)
          //       .size
          //       .width,
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
        ],
      ),
    );
  }
}

class ProductDetailProperty extends StatelessWidget {
  String property;

  ProductDetailProperty({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.w),
      padding: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EDF7),
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
            offset: const Offset(6, 3),
            blurRadius: 16,
            color: const Color(0xFF88A5BF).withOpacity(0.48),
          ),
          const BoxShadow(
            offset: Offset(-6, -2),
            blurRadius: 16,
            color: Colors.white,
          ),
        ],
      ),
      child: KText(
        property,
        color: kTextBlackColor,
        fontSize: 17.w,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Widget child;

  Buttons({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE3EDF7),
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              offset: const Offset(6, 3),
              blurRadius: 16,
              color: const Color(0xFF88A5BF).withOpacity(0.48),
            ),
            const BoxShadow(
              offset: Offset(-6, -2),
              blurRadius: 16,
              color: Colors.white,
            ),
          ],
        ),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 7.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: const Color(0xFFE3EDF7),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.5, 0),
                  blurRadius: 1,
                  color: const Color(0xFF88A5BF).withOpacity(0.48),
                ),
                const BoxShadow(
                  offset: Offset(-2, 0),
                  blurRadius: 1,
                  color: Colors.white,
                ),
              ],
            ),
            child: child),
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
          height: MediaQuery
              .of(context)
              .size
              .height * 0.42,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.452,
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
              ]),
          child: Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.455,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/house.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 10.w,
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.455,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              "Delivery info will  be here dg likseller offer sajncnask...",
                              style: Theme
                                  .of(context)
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
                                  style: Theme
                                      .of(context)
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
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "United State, Florida 3340",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontSize: 11.w,
                                      color: const Color(0xFF334669)
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.fire_truck),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Free Shipping",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
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
                    Text(
                      "17,000   so’m",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          fontSize: 15.w,
                          color: const Color(0xFFCE242B),
                          fontWeight: FontWeight.w800),
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
          child: Icon(
            FontAwesomeIcons.heart,
            color: kTextBlackColor,
          ),
        )
      ],
    );
  }
}
