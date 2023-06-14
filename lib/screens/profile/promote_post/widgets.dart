import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const.dart';
import '../../../theme.dart';
import '../../onboarding/constants.dart';

class PromotedPostWidget extends StatelessWidget {
  const PromotedPostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        children: [
          SizedBox(
            width:  width() * 0.49,
            height: height() * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Start Date :",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15.w,
                          color: darkgreen,
                          fontWeight: FontWeight.w600
                      ),),
                    smallHSpace(),
                    Text("06/06/23",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15.w,
                          color: darkgreen,
                          fontWeight: FontWeight.w600
                      ),),
                  ],
                ),
                smallSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("End Date :",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15.w,
                          color: red,
                          fontWeight: FontWeight.w600
                      ),),

                    Text("  06/06/23",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15.w,
                          color: red,
                          fontWeight: FontWeight.w600
                      ),),
                  ],
                ),
                smallSpace(),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 9.w),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Center(
                        child: Text("Re-Purchase",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 16.w,
                              color: white,
                              fontWeight: FontWeight.w600
                          ),),
                      )
                  ),
                ),
                kSpacing,
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 9.w),
                    decoration: BoxDecoration(
                      color: blue.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Center(
                      child: Text("23 : 58 : 35",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 16.w,
                            color: red,
                            fontWeight: FontWeight.w600
                        ),),
                    )
                ),
              ],
            ),
          ),
          smallHSpace(),
          Container(
            width: width() * 0.30,
            height: height() * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(image: AssetImage("assets/images/cars.png"),fit: BoxFit.fitHeight,)
            ),
          )

        ],
      ),
    );
  }
}