import 'dart:math' as math;

import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/helpers/widgets/text.dart';
import 'package:fenix/screens/products/reportSeller.dart';
import 'package:fenix/screens/products/vendor_details.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fenix/screens/profile/create_selling_post/create_apartment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart';
import '../../controller/map_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/user_controller.dart';
import '../../helpers/icons/custom_icons_icons.dart';
import '../../helpers/widgets/slider.dart';
import '../../neumorph.dart';
import '../../theme.dart';
import '../chat.dart';
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
  var apartment;
  var currentAddress;
  var vendor;


  RxBool liked = false.obs;

  List amenities = [];

  final UserController _userController = Get.find();
  final ProductController _productController = Get.find();
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    setState(() => apartment = widget.apartment);
    if(apartment['vendor'] != null)
    _productController.getVendorDetails(apartment['vendor']['id']);
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    await placemarkFromCoordinates(
        apartment['location']['latitude'], apartment['location']['longitude'])
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress = " ${place.name}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.isoCountryCode}";
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  @override
  Widget build(BuildContext context) {
    print(apartment);
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.06),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF691232),
              const Color(0xFF1770A2),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30.w,
                ),
              ),

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
                    itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          "assets/images/house.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    itemCount: 3,
                  )),
              if(apartment['vendor'] != null)
              Positioned(
                  right: 20,
                  top: 20,
                  child: InkWell(
                    onTap: (){
                      if(widget.apartment['isLiked'] == true){
                        liked.value = false;
                        _userController.deleteItemFromWishList(
                            _userController.getToken(), widget.apartment['id'], widget.apartment['apartmentType']);
                      }
                      else if(widget.apartment['isLiked']  == true || liked.value == true){
                        liked.value = false;
                        _userController.deleteItemFromWishList(
                            _userController.getToken(), widget.apartment['id'], widget.apartment['apartmentType']);
                      }
                      else{
                        liked.value = true;
                        _userController.addItemToWishList(
                            _userController.getToken(), widget.apartment['id'], widget.apartment['apartmentType']);
                      }
                    },
                    child: Obx(() => (liked.value == true || widget.apartment['isLiked']  == true) ? Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFA4788),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Icon(Icons.favorite,
                          color: white,
                          size: 23,
                        ),

                      ),
                    ) : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: apartment['isLiked'] ? white : black),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              apartment['isLiked']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: apartment['isLiked'] ? red : white,
                              size: 20,
                            )

                          // Icon(
                          //   Icons.favorite_border,
                          //   color: white,
                          // ),
                        )),),
                  )),
              Positioned(
                right: 10,
                left: 10,
                bottom: 20,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (i) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: currentIn == i ? 18 : 10,
                                width: currentIn == i ? 18 : 10,
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
                SizedBox(height: 3.w),
                KText(apartment['title'],
                    fontWeight: FontWeight.w700, fontSize: 19.w),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.star, size: 15),
                tinyH5Space(),
                const Text(
                  '4.75',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
              smallHSpace(),
                const Text(
                  '105 reviews',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)
                ),
                smallHSpace(),

               if(currentAddress != null) Expanded(
                  child: Text(
                    '${currentAddress}',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if(apartment['vendor'] != null)
                       Text(
                        "Entire home hosted by\n${apartment['vendor']['firstName']} ${apartment['vendor']['lastName']}",
                        style: TextStyle(fontSize: 15),
                      ),
                      tinySpace(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${apartment['rules']['occupant']} guests',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '${apartment['specifics']['bedroom']} Bedroom',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '${apartment['specifics']['floor']} floors',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '${apartment['specifics']['bathroom']} bathroom',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                smallHSpace(),
                if(apartment['vendor'] != null)
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown, width: 2),
                      shape: BoxShape.circle),
                  child: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: apartment['vendor']['picture'].isNotEmpty
                            ? DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(apartment['vendor']['picture']),)
                            : const DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage(
                                'assets/images/icons/person.png'))),
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${apartment['rentPrice']['salePrice'] ?? apartment['rentPrice']['night']} So\'m',
                            style: const TextStyle(color: blue, fontSize: 23)),
                        Text(
                            apartment['rentPrice']['salePrice'] != null
                                ? 'Sale'
                                : '1/Per Night',
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const Text(
                  'Property Availability',
                  style: TextStyle(fontSize: 15),
                ),
                tiny15Space(),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                    ),
                    tinyHSpace(),
                    const Text(
                      'Free Cancellation for 48 hours',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                tinySpace(),
                Row(
                  children: [
                    const Icon(
                      Icons.sensor_door_outlined,
                      size: 18,
                    ),
                    tinyHSpace(),
                    const Text(
                      'Self-checkin',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                smallSpace(),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Availability From',
                        style: TextStyle(
                            color: blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    smallHSpace(),
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
                    tinyH5Space(),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(
                                '${apartment['rentAvailability']['startDate']}'))
                            .toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                tinySpace(),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Availability To',
                        style: TextStyle(
                            color: blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    smallHSpace(),
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                    ),
                    tinyH5Space(),
                    Expanded(
                      flex: 3,
                      child: Text(
                        DateFormat.yMMMMd()
                            .format(DateTime.parse(
                                '${apartment['rentAvailability']['endDate']}'))
                            .toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if(apartment['vendor'] != null)
          InkWell(
            onTap: ()=>Get.to(()=>Chat(userId: apartment['vendor']['id'], name: "${apartment['vendor']['firstName']} ${apartment['vendor']['lastName']}",)),
            child: Buttons(
              child: Center(
                child: KText(
                  "Message Seller",
                  color: const Color(0xFF1994F5),
                  fontWeight: FontWeight.w700,
                  fontSize: 18.w,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              Uri phoneno = Uri.parse('tel:+97798345348734');
              if (await launchUrl(phoneno)) {
              }else{
              }
            },
            child: Buttons(
              child: Center(
                child: KText(
                  "Call Seller",
                  color: const Color(0xFF1994F5),
                  fontWeight: FontWeight.w700,
                  fontSize: 18.w,
                ),
              ),
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 15),
                ),
                tiny15Space(),
                KText(
                  apartment['description'],
                  fontWeight: FontWeight.w500,
                  fontSize: 15.w,
                ),
              ],
            ),
          ),
          divider(),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('You will get', style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                imageOption('${apartment['specifics']['bedroom']}',
                    Icons.hotel_outlined),
                const SizedBox(width: 12),
                imageOption('${apartment['specifics']['bathroom']}',
                    Icons.bathtub_outlined),
                const SizedBox(width: 12),
                imageOption('${apartment['specifics']['shower']}',
                    Icons.shower_outlined),
                const SizedBox(width: 12),
                imageOption('${apartment['specifics']['toilet']}',
                    Icons.flight_class_outlined),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (apartment['rules']['pet'].toString() == 'true')
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.w),
                    decoration: shadow().copyWith(color: Colors.redAccent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pets,
                          color: white,
                          size: 20,
                        ),
                        smallHSpace(),
                        Expanded(
                          child: KText(
                            "Pets are not allowed in this property",
                            fontSize: 15.w,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (apartment['rules']['pet'].toString() == 'true')
                  smallSpace(),
                if (apartment['rules']['smoke'].toString() == 'true')
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.w),
                    decoration: shadow().copyWith(color: Colors.redAccent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.smoke_free,
                          color: white,
                          size: 20,
                        ),
                        smallHSpace(),
                        Expanded(
                          child: KText(
                            "Smoking not allowed in this property",
                            fontSize: 15.w,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('What this place offers', style: TextStyle(fontSize: 16)),
                    tiny15Space(),
                    Wrap(
                      children: List.generate(
                          apartment['specifics']['amenities'].length,
                              (index) => Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: amenitiesButton(apartment['specifics']['amenities'][index]),
                              )),
                    ),

                  ],
                ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: SizedBox(
              height: height() * 0.5,
              child: GoogleMap(
                mapType: MapType.satellite,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(apartment['latitude'].toDouble(), apartment['longitude'].toDouble()),
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("apartmentlocation"),
                    position: LatLng(apartment['latitude'].toDouble(), apartment['longitude'].toDouble()),
                  )
                },
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: false,
              ),
            ),
          ),

          divider(),
          // Buttons(
          //   child: Center(
          //     child: KText(
          //       "Pay Cash",
          //       color: const Color(0xFFE86709),
          //       fontWeight: FontWeight.w700,
          //       fontSize: 18.w,
          //     ),
          //   ),
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
          //         "Report Issue",
          //         color: const Color(0xFF2E476E),
          //         fontWeight: FontWeight.w700,
          //         fontSize: 18.w,
          //       ),
          //       const SizedBox(),
          //     ],
          //   ),
          // ),
          // divider(),

          if(apartment['vendor'] != null)
            Column(
              children: [
                Padding(
                padding: EdgeInsets.all(20.w),
                child: KText(
                  "Seller Information",
                  fontWeight: FontWeight.w900,
                  color: kTextBlackColor,
                  fontSize: 19.w,
                ),
          ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10,15, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Get.to(() => VendorDetails(
                                vendor: _productController.vendor,
                                rating: apartment['vendor']['positiveRating'],
                                storeId: apartment['storeId'],
                                vendorId: apartment['vendor']['id'],
                              ));
                            },

                            child: Row(
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
                                          color: white, shape: BoxShape.circle),
                                      child:  Container(
                                        height: 55.w,
                                        width: 55.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: apartment['vendor']['picture'].isNotEmpty
                                                ? DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(apartment['vendor']['picture']),)
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
                                    KText("${apartment['vendor']['firstName']} ${apartment['vendor']['lastName']}",
                                      fontSize: 17.w,
                                      color: const Color(0xFFE23F0A),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    KText(
                                      "${double.parse(apartment['vendor']['positiveRating']).toStringAsFixed(1)}% Positive Feedback",
                                      fontSize: 12.w,
                                      color: const Color(0xFF8F9FAE),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: 4.w,
                                    ),
                                    KText(timeago.format(DateTime.parse(apartment['vendor']['joinedAt'])),
                                      fontSize: 12.w,
                                      color: const Color(0xFF8F9FAE),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  _productController.isReportSent.value = false;
                                  Get.to(() => ReportSeller(
                                    vendorId: apartment['vendor']['id'],
                                  ));
                                },
                                child: Container(
                                  decoration: shadow().copyWith(
                                      gradient: gradient(Color(0xFFFFFFFF),
                                          Color(0xFF8F9FAE).withOpacity(0.1))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: kTextBlackColor,
                                          size: 20,
                                        ),
                                        tinyH5Space(),
                                        KText(
                                          "Report Seller",
                                          fontSize: 12.w,
                                          color: kTextBlackColor,
                                          fontWeight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                kSpacing,
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Positive feedback",
                            style: TextStyle(color: darkgreen, fontSize: 15.w),),
                          tinySpace(),
                          if(apartment['vendor']['positiveRating'] != "NaN")
                            Text("${double.parse(apartment['vendor']['positiveRating']).toStringAsFixed(1)}",
                              style: TextStyle(color: darkgreen, fontSize: 15.w),),
                          tinySpace(),
                          if(apartment['vendor']['positiveRating'] != "NaN")
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
                                width: width() * 0.35 * (double.parse((apartment['vendor']['positiveRating']))/100),
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
                          Text("Negative feedback",
                            style: TextStyle(color: red, fontSize: 15.w),),
                          tinySpace(),
                          if(apartment['vendor']['negativeRating'] != "NaN")
                            Text("${double.parse(apartment['vendor']['negativeRating']).toStringAsFixed(1)}",
                              style: TextStyle(color: red, fontSize: 15.w),),
                          tinySpace(),
                          if(apartment['vendor']['positiveRating'] != "NaN")
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
                                width: width() * 0.35 * (double.parse((apartment['vendor']['negativeRating']))/100),
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
                ),

              ],
            ),

          kLargeSpacing,

        ],
      ),
    );
  }


  Widget amenitiesButton(title) {
    return Container(
      decoration: depressNeumorph()
          .copyWith(color: amenities.contains(title) ? blue : null),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 21.w),
      child: Image.asset('assets/images/apartmentIcons/$title.png', scale: height()/38, color: amenities.contains(title) ? white : dark.withOpacity(0.7)),
    );
  }

  Widget imageOption(String title, IconData icon) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.blueGrey,
                size: 35,
              ),
              tinySpace(),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.blueGrey,
                    fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  final MapController _mapController = Get.find();

  void _onMapCreated(GoogleMapController controller) {
    _mapController.googleMapController = controller;
    controller.dispose();
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
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.455,
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
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.455,
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
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "United State, Florida 3340",
                                  style: Theme.of(context)
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
                                  style: Theme.of(context)
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
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
