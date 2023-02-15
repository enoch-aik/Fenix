
import 'package:fenix/helpers/icons/custom_icons_icons.dart';
import 'package:fenix/helpers/icons/profile_icon_black_icons.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/home.dart';
import 'package:fenix/screens/map.dart';
import 'package:fenix/screens/categories/menu_category.dart';
import 'package:fenix/screens/onboarding/constants.dart';
import 'package:fenix/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class Views extends StatefulWidget {
  const Views({Key? key}) : super(key: key);

  @override
  State<Views> createState() => _HomeState();
}

class _HomeState extends State<Views> with TickerProviderStateMixin {
  int _selectedIndex = 1;

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
          UserProfile(),
          MenuCategory(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 7.w),
        decoration: BoxDecoration(
          gradient: invertedGradient,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map,color: Colors.black.withOpacity(0.38), size: 40,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,color: Colors.black.withOpacity(0.38), size: 37,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(ProfileIconBlack.vector__1_, size: 27.w, color: Colors.black.withOpacity(0.38),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.hammer,color: Colors.black.withOpacity(0.38),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu,color: Colors.black.withOpacity(0.38), size: 37,),
              label: '',
            ),
          ], // This trailing comma makes auto-formatting nicer for build methods.
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          selectedLabelStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class MenuTitle extends StatelessWidget {

  String icon;
  String title;

  MenuTitle({
    Key? key, required this.title, required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 24.w),
      child: Row(
        children: [
          Image.asset("assets/images/icons/$icon",fit: BoxFit.fill,),
          SizedBox(width: 5.w,),
          Text(title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: 15.w,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),),
        ],
      ),
    );
  }
}
