import 'package:fenix/const.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/typography.dart';
import '../onboarding/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String tab = 'Recent';
  bool enableFilter = false;

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
                      color: tab == title ? primary : lightGrey.withOpacity(0.5),
                      width: 3))),
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: articleFontMedium2(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4F0FA),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            height() * 0.18),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient(
              const Color(0xFF691232),
              const Color(0xFF1770A2),
            ),
          ),
          padding: EdgeInsets.only(top: 55.h, left: 12.w, right: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: Image.asset(
                    "assets/images/fenixWhite2.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.050,
                    width: MediaQuery.of(context).size.width * 0.85,
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
                        hintText: "Search Fenix",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                                fontSize: 15.w, color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search),
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    tabSwitch('Recent'),
                    tabSwitch('Saved'),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () => setState(() => enableFilter = !enableFilter),
                            child: Image.asset(
                              "assets/images/icons/more.png",
                              height: 28,
                            )),
                      ],
                    ))
                  ],
                ),
              ),
              Divider(
                thickness: 4,
                color: lightGrey.withOpacity(0.4),
              )
            ],
          ),
          if (enableFilter)
            Padding(
              padding: const EdgeInsets.fromLTRB(15,80,15,0),
              child: Container(
                height: height() * 0.3,
                width: width(),
                decoration: BoxDecoration(
                    color: dark, borderRadius: BorderRadius.circular(10)),
              ),
            )
        ],
      ),
    );
  }
}
