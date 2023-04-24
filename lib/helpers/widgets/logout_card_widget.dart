import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';
import '../../controller/user_controller.dart';
import '../../theme.dart';


class LogoutCard extends StatefulWidget {
   LogoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutCard> createState() => _LogoutCardState();
}

class _LogoutCardState extends State<LogoutCard> {

   String token = '';
   final AccountController _accountController = Get.find();
   final UserController _userController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    boot();
    super.initState();
  }

   boot()async{
     token =  _userController.getToken();
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      color: background,
      padding: EdgeInsets.all(25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.door_back_door,
            color: primary,
            size: MediaQuery.of(context).size.width * 0.22,
          ),
          SizedBox(
            height: 30.w,
          ),
          Text(
            "Please don't leave 😭",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 14.w, color: primary),
          ),
          SizedBox(
            height: 50.w,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      height: 45.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primary)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: primary,
                              fontSize: 14.w
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    _accountController.signOut(token);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      height: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: red,
                      ),
                      child: Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 14.w
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
