import 'package:fenix/const.dart';
import 'package:fenix/screens/profile/create_selling_post/create_apartment.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/store_controller.dart';
import '../../controller/user_controller.dart';
import '../../helpers/widgets/top_rated_Items.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';
import 'search.dart';

class HouseRents extends StatefulWidget {
  const HouseRents({Key? key}) : super(key: key);

  @override
  State<HouseRents> createState() => _HouseRentsState();
}

class _HouseRentsState extends State<HouseRents> {
  String token = '';
  String storeId = '';
  final UserController _userController = Get.find();
  final StoreController _storeController = Get.put(StoreController());

  @override
  void initState() {
    // TODO: implement initState
    boot();
    super.initState();
  }

  boot() async {
    token = _userController.getToken();
  await  _storeController.getStores(token);
    storeId = _storeController.storeList[0]['id'].toString();
    _storeController.getApartments(token, storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.183),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF6CFFE5),
              const Color(0xFF639EF6),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/fenix_c.png"),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => Get.to(() => const SearchScreen()),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.050,
                  width: MediaQuery.of(context).size.width,
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
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      hintText: "Search Fenix",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontSize: 15.w, color: Colors.grey.shade500),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.052,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    MenuTitle(
                        icon: "Dacha.png",
                        title: "Dacha",
                        onTap: () => Get.back()),
                    MenuTitle(icon: "houseRental.png", title: "House Rental"),
                    MenuTitle(icon: "apartment.png", title: "Apartment"),
                    MenuTitle(icon: "carRental.png", title: "Car Rental"),
                    MenuTitle(icon: "storeRental.png", title: "Store Rental"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              height: 30.w,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                gradient: gradient(
                  const Color(0xFF6CFFE5),
                  const Color(0xFF639EF6),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 17.w, color: white),
                  Text(
                    " Deliver to chicago,iL 5932 ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.w,
                          color: black,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              )),
          Expanded(
            child: Obx(() => _storeController.isFetchingApartments.isTrue
                ? const Center(child: CircularProgressIndicator())
                : _storeController.apartmentList.isEmpty
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: BODY_PADDING),
                        child: InkWell(
                          onTap: () => Get.to(() => CreateApartment(
                                storeId: storeId,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_box, size: 30),
                              smallSpace(),
                              const Text('You do not have any apartment for rent yet'),
                            ],
                          ),
                        ),
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.only(top: BODY_PADDING),
                        itemBuilder: (c, i) {
                          var item = _storeController.apartmentList[i];
                          return const RatedItemsWidget(actionText: 'More');
                        },
                        separatorBuilder: (c, i) => smallSpace(),
                        shrinkWrap: true,
                        itemCount: _storeController.apartmentList.length)),
          ),
          // Expanded(
          //   child: ListView(
          //     children: [
          //       mediumSpace(),
          //       ListView.separated(
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemCount: 8,
          //           shrinkWrap: true,
          //           separatorBuilder: (c,i)=>smallSpace(),
          //           itemBuilder: (c, i) {
          //             return const RatedItemsWidget(actionText:'More');
          //           }),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
