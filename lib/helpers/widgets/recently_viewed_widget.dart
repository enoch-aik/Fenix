
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138.w,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                image: DecorationImage(image: AssetImage("assets/images/house.png"), fit: BoxFit.fill,)),
          ),
          SizedBox(width: 10.w,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery info will  be here dg likseller offer sajncnask...",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 12.w,
                            color: Color(0xFF334669),
                            fontWeight: FontWeight.w700
                        ),),
                      Row(
                        children: [
                          RatingBar(
                              initialRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18.w,
                              ignoreGestures: true,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star, color: Colors.orange),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.orange,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: Colors.grey,
                                  )),
                              onRatingUpdate: (value) {

                              }),
                          SizedBox(width: 10.w,),
                          Text("259 reviews.",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 10.w,
                                color: Color(0xFF334669).withOpacity(0.6),
                                fontWeight: FontWeight.w500
                            ),),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 10.w,),
                          Text("United State, Florida 3340",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 11.w,
                                color: Color(0xFF334669).withOpacity(0.6),
                                fontWeight: FontWeight.w400
                            ),),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.fire_truck),
                          SizedBox(width: 10.w,),
                          Text("Free Shipping",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 12.w,
                                color: Color(0xFF0F7D46),
                                fontWeight: FontWeight.w500
                            ),)
                        ],
                      ),
                    ],
                  ),
                ),


                Text("17,000   so’m",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.w,
                      color: Color(0xFF1994F5),
                      fontWeight: FontWeight.w800
                  ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
