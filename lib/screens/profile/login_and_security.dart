import 'package:fenix/const.dart';
import 'package:fenix/neumorph.dart';
import 'package:fenix/screens/profile/account_info.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../onboarding/constants.dart';
import 'edit_profile.dart';

class LoginAndSecurity extends StatelessWidget {
   LoginAndSecurity({Key? key}) : super(key: key);

   final UserController _userController = Get.find();
   final firstNameController = TextEditingController();
   final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = _userController.getUser();
    print('user - ${_userController.getUser()}');
    if (user != null) {
      firstNameController.text = user.firstName.toString();
      lastNameController.text = user.lastName.toString();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      appBar: AppBar(
          title: SizedBox(
            height: 46.h,
            child: Image.asset(
              "assets/images/fenixWhite2.png",
              fit: BoxFit.fill,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: gradient2(
                const Color(0xFF46E0C4),
                const Color(0xFF59B5C0),
              ),
            ),
          )),
      body: Column(
        children: [
          Container(
            height: 50.w,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 20.w),
            decoration: BoxDecoration(
              gradient: gradient2(
                const Color(0xFF41F0D1),
                const Color(0xFF4A9A9E),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                ),
                Text(
                  "Login & Security",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.w,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2))
                      ]),
                ),
                SizedBox(),
              ],
            ),
          ),
          Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  verticalSpace(0.05),
                  Icon(Icons.account_circle_outlined,size: 50.w, color: dark.withOpacity(0.5),),
                  tiny5Space(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(firstNameController.text,
                        style: TextStyle(
                          fontSize: 14,
                        ),),
                      tinyH5Space(),
                      Text(lastNameController.text,
                        style: TextStyle(
                          fontSize: 14,
                        ),)
                    ],
                  ),
                  mediumSpace(),

                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.w),
                      border: Border.all(color: dark.withOpacity(0.7)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reset Password",
                            style: TextStyle(
                              fontSize: 15.w,
                              fontWeight: FontWeight.w500,
                            ),),
                            Icon(Icons.arrow_forward,)
                          ],
                        ),
                        Divider(thickness: 1, height: 25.w, color: dark.withOpacity(0.4),),
                        verticalSpace(0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delete Account",
                              style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.w500,
                                color: red
                              ),),
                            Icon(Icons.arrow_forward,)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  InkWell accountContainer(title, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration:
        depressNeumorph().copyWith(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    title,
                    style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  )),
              const Icon(Icons.arrow_forward, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
