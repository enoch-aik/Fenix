import 'dart:io';

import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/widgets/loader.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/product_controller.dart';
import '../../controller/user_controller.dart';
import '../../helpers/typography.dart';
import '../onboarding/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchAndHistory extends StatefulWidget {


  SearchAndHistory({Key? key,}) : super(key: key);

  @override
  State<SearchAndHistory> createState() => _SearchAndHistoryState();
}

class _SearchAndHistoryState extends State<SearchAndHistory> {

  bool enableFilter = false;
  final focus = FocusNode();
  RxList suggestions = [].obs;

  RxList filter = [].obs;
  RxBool enabled = false.obs;

  final searchWordController = TextEditingController();

  final ProductController _productController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _productController.isSearching.value = false;
    _getRecentSearches();
  }


  saveSearch(searchText)async{
    if (searchText == null) return; //Should not be null
    final pref = await SharedPreferences.getInstance();

    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  _getRecentSearches() async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    setState(() {
      suggestions.value = allSearches!;
      filter.value = suggestions;
    });
    print(allSearches);
  }



  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(13.w),
        borderSide: const BorderSide(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height() * 0.09),

        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF691232),
              const Color(0xFF1770A2),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _productController.isSearchEnabled.value = false;
                },
                icon: (Platform.isIOS)
                    ? Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 29.w,
                )
                    : Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 29.w,
                ),
              ),

              Container(
                width: width() * 0.82,
                padding: EdgeInsets.only(bottom: 10.h),
                child: TextField(
                  autofocus: true,
                  onChanged: (query) {
                    filter.value = suggestions
                        .where((element) =>
                        element.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  },
                  controller: searchWordController,
                  onTap: (){
                    print(_productController.searchList);
                  },
                  onSubmitted: (v) {
                    setState(() {
                      saveSearch(v);
                    });
                    _productController.searchStore(v);
                  },
                  onTapOutside: (v) {
                    FocusScope.of(context).unfocus();
                  },
                  style: GoogleFonts.roboto(
                    fontSize: 15.w,
                    fontWeight: FontWeight.w400
                  ),
                  decoration: InputDecoration(
                    enabledBorder: buildOutlineInputBorder(),
                    focusedBorder: buildOutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    hintText: AppLocalizations.of(context)!.searchFenix,
                    hintStyle: TextStyle(fontSize: 15.w, color: Colors.grey.shade500),
                    suffixIcon: searchWordController.text.isEmpty
                        ? const Icon(Icons.search)
                        : IconButton(
                      onPressed: () {
                        searchWordController.text = '';
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Obx(() => ListView.separated(
            itemCount: filter.length,
            itemBuilder: (context, index) =>  InkWell(
              onTap: (){
                _productController.searchStore(filter[index]);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history, color: grey, size: 18.w,),
                        tinyHSpace(),
                        Text(filter[index],
                            style: GoogleFonts.lato(
                                fontSize: 14.w,
                                fontWeight: FontWeight.w500,
                                color: dark
                            )),
                      ],
                    ),
                    InkWell(
                      onTap: () async{
                        final pref = await SharedPreferences.getInstance();
                        filter.removeAt(index);
                        setState(() {
                          _getRecentSearches();
                        });
                      },
                        child: Icon(Icons.close, color: dark, size: 18.w,),
                    ),
                  ],
                ),
              ),
            ),
        separatorBuilder: (_, __) => Divider(),),),
      )

    );
  }
}


class ProductWidget extends StatelessWidget {
  String title, category;
  var product;
  String price;

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
                                // ${distanceInKm(
                                //   _userController.userCurrentPosition!.value.latitude,
                                //   _userController.userCurrentPosition!.value.longitude,
                                //   location['location']['latitude'],
                                //   location['location']['longitude'],
                                // ).toString()}
                                Text(
                                  "124Km",
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
            onTap: () {
              product['isLiked']
                  ? _userController.deleteItemFromWishList(
                  _userController.getToken(), product['id'], category)
                  : _userController.addItemToWishList(
                  _userController.getToken(), product['id'], category);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: product['isLiked']
                      ? const Color(0xFFFA4788)
                      : Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Obx(
                      () => (_userController.isLoadingLikes.isTrue &&
                      _userController.selectedId.value == product['id'])
                      ? const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator.adaptive(),
                      ))
                      : Icon(
                    product['isLiked']
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: product['isLiked'] ? white : kTextBlackColor,
                    size: 23,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
