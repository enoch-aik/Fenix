
import 'package:fenix/const.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/helpers/icons/custom_icons_icons.dart';
import 'package:fenix/helpers/icons/profile_icon_black_icons.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home/home.dart';
import 'package:fenix/screens/map.dart';
import 'package:fenix/screens/categories/menu_category.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/product_controller.dart';
import '../theme.dart';
import 'data_Screen/chart_Screen.dart';

class Views extends StatefulWidget {
  const Views({Key? key}) : super(key: key);

  @override
  State<Views> createState() => _HomeState();
}

class _HomeState extends State<Views> with TickerProviderStateMixin {
  int _selectedIndex = 1;
  final UserController userController = Get.put(UserController());
  TabController? _tabController;

  final ProductController _productController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
      initialIndex: 1,
      length: 5,
      vsync: this,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if(index == 1 &&  _productController.isSearchEnabled.value == true ){
        _productController.isSearchEnabled.value = false;
      }
      _tabController!.index = _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4EFF9),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        // swipe navigation handling is not supported
        controller: _tabController,
        children: [
          Map(),
          Home(),
          UserProfile(),
          Charts(),
          MenuCategory(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 7.w),
        decoration: BoxDecoration(
          gradient: gradientInverted(
            const Color(0xFF691232),
            const Color(0xFF1770A2),
          ),
        ),
        child: BottomNav()
      ),
    );
  }

  Widget BottomNav(){
    return  Container(
      decoration: BoxDecoration(
          color: Colors.red,
          gradient: gradientInverted(
          const Color(0xFF691232),
          const Color(0xFF1770A2),
          ),),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25, 00, 25, 23),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _onItemTapped(0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.map_outlined,
                  color:
                  _selectedIndex == 0 ? white : white.withOpacity(0.44),
                  size: 35.w,
                ),
              ),
            ),
            InkWell(
              onTap: () => _onItemTapped(1),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child:  Icon(
                  Icons.home_outlined,
                  color:
                  _selectedIndex == 1 ? white : white.withOpacity(0.44),
                  size: 35.w,
                ),
              ),
            ),
            InkWell(
              onTap: () => _onItemTapped(2),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  color:  _selectedIndex == 2 ? white : white.withOpacity(0.44),
                  size: 35.w,
                ),
              ),
            ),
            InkWell(
              onTap: () => _onItemTapped(3),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  CustomIcons.hammer,
                  color:  _selectedIndex == 3 ? white : white.withOpacity(0.44),
                  size: 30.w,
                ),
              ),
            ),

            InkWell(
              onTap: () => _onItemTapped(4),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.menu_outlined,
                  color:  _selectedIndex == 4 ? white : white.withOpacity(0.44),
                  size: 35.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
}
}


class MenuTitle extends StatelessWidget {
  void Function()? onTap;
  IconData icon;
  String title;
  Color color;

  MenuTitle({
    Key? key, required this.title, required this.icon,this.color=Colors.transparent,this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Row(
          children: [
            Icon(icon,size: 24.w, color: color),
            SizedBox(width: 10.w,),
            Text(title,
            style: GoogleFonts.roboto(
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
                color: color
            ),),
          ],
        ),
      ),
    );
  }
}
