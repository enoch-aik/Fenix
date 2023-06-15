import 'package:fenix/screens/profile/purchase_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../theme.dart';

class PlanWidget extends StatelessWidget {

  Widget? icon;
  String? title;
  String? plan;
  String? duration;
  String? target;
  String? price;

  PlanWidget({
    Key? key,this.price, this.duration, this.plan, this.target, this.title, this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: light.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.w),
          ),
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title!,
                style: GoogleFonts.roboto(
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700
                ),),
             mediumSpace(),
              Row(
                children: [
                  Image.asset('assets/images/icons/checkBadge.png', scale: 4,),
                  tinyH5Space(),
                  Text("24/7 Active",
                    style: GoogleFonts.roboto(
                        fontSize: 13.w,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
              smallSpace(),
              Row(
                children: [
                  Image.asset('assets/images/icons/checkBadge.png', scale: 4,),
                  tinyH5Space(),
                  Text(target!,
                    style:  GoogleFonts.roboto(
                        fontSize: 13.w,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
              smallSpace(),
              Row(
                children: [
                  Image.asset('assets/images/icons/checkBadge.png', scale: 4,),
                  tinyH5Space(),
                  Text(plan!,
                    style:  GoogleFonts.roboto(
                        fontSize: 13.w,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
              tinySpace(),

              Text(duration!,
                style:  GoogleFonts.roboto(
                    fontSize: 13.w,
                    color: blue,
                    fontWeight: FontWeight.w700
                ),),
              tinySpace(),
              Text("$price So'm",
                style:  GoogleFonts.roboto(
                    fontSize: 13.w,
                    color: red,
                    fontWeight: FontWeight.w700
                ),),

            ],
          ),
        ),
        tinySpace(),
        InkWell(
          onTap: (){
            Get.to(() => PurchaseDetails(
              plan: title,
              price: price,
              target: target,
              duration: duration,
            ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 15.w),
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(7.w)
            ),
            child: Text("Buy Now",
              style: GoogleFonts.roboto(
                  fontSize: 13.w,
                  color: white,
                  fontWeight: FontWeight.w700
              ),),
          ),
        )
      ],
    );
  }
}
