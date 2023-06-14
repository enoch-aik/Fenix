import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../theme.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF151522),
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.all(25.w),
      child: Stack(
        children: [

          Positioned(
            right: -35,
            child: Image.asset("assets/images/fenixlogobird.png", color: Colors.white.withOpacity(0.15), height: height() * 0.17,),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/icons/chip.png"),
              verticalSpace(0.04),
              Text("**** **** **** 0777",
                style: GoogleFonts.aBeeZee(
                    fontSize: 22.w,
                    color: white,
                    textStyle: TextStyle(
                        letterSpacing: 2.5.w
                    ),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400
                ),),

              verticalSpace(0.04),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ism Familiya",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 11.w,
                            color: Color(0xFF999999),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400
                        ),),
                      tinySpace(),
                      Text("Khasan Akmalov",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 11.w,
                            color: white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400
                        ),),
                    ],
                  ),

                  horizontalSpace(0.12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Muddati",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 11.w,
                            color: Color(0xFF999999),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400
                        ),),
                      tinySpace(),
                      Text("07/07",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 11.w,
                            color: white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400
                        ),),
                    ],
                  )

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
