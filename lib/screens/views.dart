
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
      _tabController!.index = _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4EFF9),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
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
        child: SizedBox(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined,color: Colors.white.withOpacity(0.44), size: 35.w,),
                activeIcon: Icon(Icons.map,color: Colors.white, size: 35.w,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,color: Colors.white.withOpacity(0.44), size: 35.w,),
                activeIcon: Icon(Icons.home,color: Colors.white, size: 35.w,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 30.w, color: Colors.white.withOpacity(0.44),),
                activeIcon: Icon(Icons.account_circle, size: 30.w, color: Colors.white,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CustomIcons.hammer,color: Colors.white.withOpacity(0.44),size: 30.w),
                activeIcon: Icon(CustomIcons.hammer,color: Colors.white, size: 30.w),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined,color: Colors.white.withOpacity(0.44), size: 30.w,),
                activeIcon:  Icon(Icons.menu,color: Colors.white, size: 30.w,),
                label: '',
              ),
            ], // This trailing comma makes auto-formatting nicer for build methods.
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class MenuTitle extends StatelessWidget {
  void Function()? onTap;
  String icon;
  String title;
  Color? color;

  MenuTitle({
    Key? key, required this.title, required this.icon,this.color,this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(right: 24.w),
        child: Row(
          children: [
            Image.asset("assets/images/icons/$icon",height: 24.w,color: color??black),
            SizedBox(width: 5.w,),
            Text(title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 19.w,
              fontWeight: FontWeight.w600
                ,color: color??black
            ),),
          ],
        ),
      ),
    );
  }
}
