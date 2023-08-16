import 'dart:io';
import 'package:fenix/const.dart';
import 'package:fenix/controller/product_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/onboarding/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../controller/map_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../theme.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/typography.dart';
import '../../helpers/widgets/text.dart';
import '../../neumorph.dart';
import '../home/home.dart';
import '../home/widgets/loader.dart';
import '../profile/product_list_widget.dart';


class VendorDetails extends StatefulWidget {

  var vendor;
  var storeId;
  var vendorId;
  var rating;


  VendorDetails(
      {Key? key, this.vendor, this.storeId, this.vendorId, this.rating})
      : super(key: key);

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  PageController pageController = PageController();
  final UserController _userController = Get.find();
  final MapController _mapController = Get.find();
  final StoreController _storeController = Get.find();
  final ProductController _productController = Get.find();
  final _formKey = GlobalKey<FormState>();

  FocusNode _focusNode = FocusNode();

  TextEditingController reviewController = TextEditingController();
  String tab = 'Shop';

  var vendor;
  var storeId;

  var rate = 0.0;

  RxList vendorApartments = [].obs;

  @override
  void initState() {
    super.initState();
    setState(() => vendor = widget.vendor);
    setState(() => storeId = widget.storeId);
   Future.delayed(Duration(milliseconds: 500), (){
     _storeController.getStoreById(_userController.getToken(), widget.storeId);
     _storeController.getApartments(_userController.getToken(), widget.storeId);
     vendorApartments.value = _storeController.apartmentList
         .where((e) => e['apartmentType'] == 'apartment')
         .toList();
     _productController.feedbacks.value = _productController.vendor['feedbacks'];

   });
  }


  rateSeller() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Obx(() => _storeController.isReviewDone.value == true
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: green, size: 120.w,),
              kSpacing,
              Text("Your Review was sent!"),
            ],
          )
              : Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    closeButton(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text('Rate Seller',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)))),

                    mediumSpace(),

                    Text('How was your experience with this Seller?',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    smallSpace(),



                    RatingBar(
                        initialRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 48.w,
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
                        onRatingUpdate: (value) {
                          rate = value;
                        }),

                    mediumSpace(),

                    Text('Describe your experience with this Seller?',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    smallSpace(),

                    TextFieldWidget(
                      textController: reviewController,
                      hint: "Describe your experience",
                      maxLine: 6,
                    ),

                    kLargeSpacing,

                    Center(
                      child: Obx(() => _storeController.isReviewLoading.value == true ? CircularProgressIndicator(strokeWidth: 2,)
                          : InkWell(
                        onTap: (){
                          _storeController.writeFeedback(
                            _userController.getToken(),
                            message: reviewController.text,
                            rate: rate.toInt(),
                            userId: widget.vendorId.toString(),
                          );
                          _productController.getVendorDetails(vendor['id']);
                          _storeController.getApartments(_userController.getToken(), storeId);
                        },
                        child: Card(
                          color: green,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                            child: Text("Submit",
                              style: GoogleFonts.lato(fontSize: 13.w),),
                          ),
                        ),
                      ),),
                    )

                  ]),
                ),
              ),)
        ));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.w),
                color: const Color(0xFFDAE5F2),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: white.withOpacity(0.2),
                                  offset: const Offset(4, 4),
                                  blurRadius: 2,
                                  spreadRadius: 1),
                              BoxShadow(
                                  color: white.withOpacity(0.2),
                                  offset: const Offset(-4, -4),
                                  blurRadius: 2,
                                  spreadRadius: 1),
                            ], color: white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white, shape: BoxShape.circle),
                                child:  Container(
                                  height: 55.w,
                                  width: 55.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: vendor['picture'] != null
                                          ? DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: NetworkImage(vendor['picture']),)
                                          : const DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              'assets/images/icons/person.png'))),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText("${vendor['firstName']} ${vendor['lastName']}",
                                fontSize: 17.w,
                                color: const Color(0xFFE23F0A),
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(
                                height: 15.w,
                              ),
                              widget.rating == "NaN" ? Text("0 feedback",
                                style: GoogleFonts.roboto(fontSize: 12.w,
                                  color: const Color(0xFF8F9FAE),
                                  fontWeight: FontWeight.w500,),) :  KText(
                                "${double.parse(widget.rating).toStringAsFixed(1)} % Positive Feedback",
                                fontSize: 12.w,
                                color: const Color(0xFF8F9FAE),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 4.w,
                              ),
                              KText(timeago.format(DateTime.parse(vendor['joinedAt'])),
                                fontSize: 12.w,
                                color: const Color(0xFF8F9FAE),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.favorite_border_outlined, color: dark,),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 18.w),
              child: Row(
                children: [
                  tabSwitch('Shop'),
                  smallHSpace(),
                  tabSwitch('About'),
                  smallHSpace(),
                  tabSwitch('Feedback'),
                ],
              ),
            ),

            if(tab == "Shop")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Seller's apartment post"),
                    tinySpace(),
                    Obx(
                          () => _storeController.isFetchingApartments.isTrue || vendorApartments.isEmpty
                          ? const Loader()
                          : vendorApartments.isEmpty
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
                                  0.5,
                              childAspectRatio: 1 / 2.7,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0),
                          itemCount: vendorApartments.length,
                          itemBuilder: (context, i) {
                            var item = vendorApartments[i];
                            return InkWell(
                              onTap: () {
                                print(item['media'][0]['url']);
                                // Get.to(() => ApartmentDetails(
                                //     apartment: item));
                              },
                              child: ProductListWidget(
                                  product: item,
                                  isNetwork: item['media'].isNotEmpty,
                                  image: item['media'].isNotEmpty
                                      ? item['media'][0]['url']
                                      : "assets/images/cars.png"),
                            );
                          }),
                    ),

                  ],
                ),
              ),

            if(tab == "About")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About Us"),

                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(15.w)
                      ),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                 color: Color(0xFFE4F0FA),
                                  borderRadius: BorderRadius.circular(15.w)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Row(
                                children: [
                                  Text("Location: ${_storeController.store['location']}",
                                  style: GoogleFonts.lato(
                                      fontSize: 14.w,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                ],
                              ),
                              Text("Member since: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(_storeController.store['date_created']))}",
                                style: GoogleFonts.lato(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500,
                                ),),
                              Text("Store name: ${_storeController.store['name']}",
                                style: GoogleFonts.lato(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500,
                                ),),
                            ],
                          )),
                          tinySpace(),
                          Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE4F0FA),
                                  borderRadius: BorderRadius.circular(15.w)
                              ),
                              child: Row(
                                children: [
                                  Text(_storeController.store['description'],
                                  style: GoogleFonts.lato(
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w500
                                  ),),
                                ],
                              ),
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),

            if(tab == "Feedback")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Seller's Rating",
                        style: GoogleFonts.lato(),),

                        InkWell(
                          onTap: (){
                            _storeController.isReviewLoading.value = false;
                            _storeController.isReviewDone.value = false;
                            rateSeller();
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 10.w),
                              child: Text("Rate Seller",
                              style: GoogleFonts.lato(fontSize: 13.w),),
                            ),
                          ),
                        )
                      ],
                    ),
                    tinySpace(),
                    Text("Last 12 Months",
                    style: GoogleFonts.lato(
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600
                    ),),

                    kLargeSpacing,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Positive",
                              style: GoogleFonts.lato(
                                  fontSize: 15.w,
                              ),),
                            tinySpace(),
                            Text(vendor['positiveRating'].toString(),
                              style: GoogleFonts.lato(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500
                              ),),
                            tinySpace(),
                            Container(
                              height: 10,
                              width: width() * 0.35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(color: darkgreen, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 10,
                                width:vendor['positiveRating'] == 0 ? 0 : width() * 0.35 * (vendor['positiveRating'] / (vendor['negativeRating'] + vendor['positiveRating'])),
                                decoration: BoxDecoration(
                                  color: darkgreen,
                                  border: Border.all(color: darkgreen, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          ],
                        ),



                        Column(
                          children: [
                            Text("Negative",
                              style: GoogleFonts.lato(
                                fontSize: 15.w,
                              ),),
                            tinySpace(),
                            Text(vendor['negativeRating'].toString(),
                              style: GoogleFonts.lato(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500
                              ),),
                            tinySpace(),
                            Container(
                              height: 10,
                              width: width() * 0.35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border.all(color: red, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 10,
                                width: vendor['negativeRating'] == 0 ? 0 : width() * 0.35 * (vendor['negativeRating'] / (vendor['negativeRating'] + vendor['positiveRating'])),
                                decoration: BoxDecoration(
                                  color: red,
                                  border: Border.all(color: red, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    mediumSpace(),

                    Text("Seller's Feedback"),

                    mediumSpace(),

                    Obx(() => _productController.feedbacks.isEmpty ? Text("No feedback yet",
                    style: GoogleFonts.roboto(fontSize: 12.w),) : ListView.builder(
                      itemCount: _productController.feedbacks.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index)
                      => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.w),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(10.w),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                gradient: gradient2(Color(0xFFC2DAED), Color(0xFFFAECE4))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person),
                                        Text("******${_productController.feedbacks[index]['firstName']} ${_productController.feedbacks[index]['lastName']}",
                                          style: GoogleFonts.lato(
                                              fontSize: 13.w,
                                              color: Color(0xFF2E476E).withOpacity(0.7)
                                          ),),
                                        mediumHSpace(),
                                        Text(timeago.format(DateTime.parse(_productController.feedbacks[index]['createdAt'])),
                                          style: GoogleFonts.lato(
                                              fontSize: 10.w,
                                              color: Color(0xFF2E476E).withOpacity(0.7)
                                          ),),
                                      ],
                                    ),
                                    tinySpace(),
                                    Text(_productController.feedbacks[index]['message'],
                                      style: GoogleFonts.lato(
                                        fontSize: 13.w,
                                      ),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    double.parse(_productController.feedbacks[index]['rating']) > 2.5 ? Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: darkgreen,
                                    ) : double.parse(_productController.feedbacks[index]['rating']) == 2.5 ? Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.yellow,
                                    ) : Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: red,
                                    ),

                                    Text(_productController.feedbacks.value[index]['rating'],
                                      style: GoogleFonts.lato(
                                        fontSize: 13.w,
                                      ),),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    )

                  ],
                ),
              )
          ],
        ),
      )
    );
  }



  InkWell tabSwitch(title) {
    return InkWell(
      onTap: () {
        setState(() {
          tab = title;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color:
                      tab == title ? primary : Colors.transparent,
                      width: 3))),
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: articleFontMedium2(),
          )),
    );
  }


  Row title(String title) {
    return Row(
      children: [
        Image.asset(
          'assets/images/icons/check.png',
          height: 20,
        ),
        tinyH5Space(),
        Text(title),
      ],
    );
  }

  Widget gender(BuildContext context, icon, title) {
    print(_userController.gender.value);

    return Expanded(
      child: InkWell(
        onTap: () {
          _userController.gender(title);
        },
        child: Obx(
              () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.w),
              color: (_userController.gender.value == title ||
                  (_userController.getUser() != null &&
                      _userController.getUser()!.gender == title))
                  ? const Color(0xFFE4F0FA).withOpacity(0.8)
                  : const Color(0xFFE4F0FA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  spreadRadius: -3,
                  blurRadius: 3,
                  offset: const Offset(3, 6), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.w,
                      color: (_userController.gender.value == title ||
                          (_userController.getUser() != null &&
                              _userController.getUser()!.gender ==
                                  title))
                          ? Colors.black
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_userController.gender.value == title ||
                            (_userController.getUser() != null &&
                                _userController.getUser()!.gender == title))
                            ? light.withOpacity(0.5)
                            : Colors.transparent),
                    child: Icon(
                      icon,
                      color: (_userController.gender.value == title ||
                          (_userController.getUser() != null &&
                              _userController.getUser()!.gender == title))
                          ? kTextBlackColor
                          : Colors.blueGrey,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget imageSelect({icon, onTap, image}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: light),
          borderRadius: BorderRadius.circular(10)),
      child: image != null
          ? Image.file(
        image,
        width: 82,
        height: 82,
        fit: BoxFit.cover,
      )
          : Padding(
        padding: const EdgeInsets.all(30.0),
        child: Icon(icon ?? Icons.photo_camera, color: lightGrey),
      ),
    ),
  );
}


Text smallText(String title) => Text(
  title,
  style: const TextStyle(
      fontWeight: FontWeight.w300, color: grey, fontSize: 13),
);

Text subText(title) {
  return Text(
    title,
    style:
    const TextStyle(color: blue, fontWeight: FontWeight.w500, fontSize: 18),
  );
}


