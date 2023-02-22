import 'package:fenix/const.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';

import '../../neumorph.dart';
import '../../theme.dart';
import 'account_creation_success.dart';
import 'constants.dart';
import 'loading.dart';

class Agreement extends StatelessWidget {
  Agreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F0FA),
      body: ListView(
        children: [
          WidgetsPad(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Image.asset("assets/images/logoFrame.png",
                          fit: BoxFit.fill),
                    ),
                    kSpacing,
                    Text(
                      "Agreement and Terms Condition",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 21,
                          color: const Color(0xFF1784DB),
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 1),
                                blurRadius: 4)
                          ]),
                    ),
                    kSpacing,
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      padding:
                          EdgeInsets.symmetric(vertical: 12.w, horizontal: 5.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF18849B).withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Text(
                        "vnsdkjvsdjv hdvbsjhdvbshjdhvsdsss"
                        "snjkvnsdkvnskjdv jshdvhjds vhjsvsvs"
                        "kdnckdnscjkndkdsjncjksdnvjknsdjvns"
                        "vskdnvkldsnvklsdnklvnskldnvklsdnvk"
                        "vskdnvkldsnvklsdnklvnskldnvklsdnvk"
                        "sdvnlkdsnvklnsdlkvnsdklvnklsdnvklsndvk"
                        "sdvnlkdsnvklnsdlkvnsdklvnklsdnvklsndvk"
                        "sdvnlkdsnvklnsdlkvnsdklvnklsdnvklsndvk"
                        "sdvnlkdsnvklnsdlkvnsdklvnklsdnvklsndvk"
                        "vknsdklvnskldnvklsdnvklnsdlkvnskldnvklsd"
                        "vnsdkvnsdkjvnkjsdnvkjsndvkjsndvkjnsdkjv"
                        "vknsdkvnkjsdvnkjsdnvkjsdnvjknsjdkvnjksd",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 15.w),
                      ),
                    ),
                    kSpacing,
                    kSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: depressNeumorph(),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                      Colors.transparent, // Your color
                                ),
                                child: Checkbox(
                                  value: false,
                                  onChanged: (v) {},
                                ),
                              ),
                            )),
                        tinyHSpace(),
                        Container(
                          decoration: depressNeumorph().copyWith(
                              border:
                                  Border.all(color: white.withOpacity(0.1))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                            child: Text(
                              "Agree to Terms and Conditions",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const Loading(
                          navigateScreen: AcctCreationSuccess(),
                        ));
                  },
                  child: ButtonWidget(title: "Next"),
                ),
              ],
            ),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SwipeToggleButton(
                    child: const Icon(Icons.arrow_back_ios_outlined)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
