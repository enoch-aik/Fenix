import 'package:fenix/helpers/categories.dart';
import 'package:fenix/helpers/widgets/recently_viewed_widget.dart';
import 'package:fenix/screens/categories/sub_categories.dart';
import 'package:fenix/screens/categories/sub_sub_category.dart';
import 'package:fenix/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../helpers/widgets/top_rated_Items.dart';
import '../../theme.dart';
import '../onboarding/constants.dart';

class MenuCategory extends StatefulWidget {
  const MenuCategory({Key? key}) : super(key: key);

  @override
  State<MenuCategory> createState() => _MenuCategoryState();
}

class _MenuCategoryState extends State<MenuCategory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,  height() * 0.053),
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
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/fenixmall_white.png",
                    color: white,
                  ),
                ),
              ),

             tinySpace(),


            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15.w, right: 15.w, left: 15.w,),
        
        child: ListView(
          children: [
            Text("Menu Category",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 22.w,
            color: kTextBlackColor,
            fontWeight: FontWeight.w700
        ),),

            SizedBox(height: 25.w,),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child:   GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1 / 1.2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 4,
                  ),
                  itemCount: Category().allCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: (){
                        Get.to(() => SubCategory(
                            category: index == 0 ? Category().propertyCategory
                            : index == 3  ? Category().clothing
                            : index == 5  ? Category().healthCare
                            : index == 1  ? Category().carCategories
                            : index == 4  ? Category(). healthCare
                            : index == 2  ? Category().electronics
                            : index == 6  ? Category().kids
                            : index == 7  ? Category().tools
                                : Category().carCategories,
                          title:Category().allCategories[index]['name'],
                        )
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/images/menu/categorybackground.png"),fit: BoxFit.contain)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Image.asset("assets/images/${Category().images[index]}",fit: BoxFit.fill,),
                            ),
                          ),

                          Text(Category().allCategories[index]['name']),
                        ],

                      ),
                    );
                  }),
            ),


          ],
        ),
      ),
    );
  }
}

