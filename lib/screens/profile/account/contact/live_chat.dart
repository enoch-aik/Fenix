import 'package:fenix/const.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../onboarding/constants.dart';


class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF1F4167),
            gradient:
            gradient(const Color(0xFF1F4167), const Color(0xFF0777FB))),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(50)),
                      color: const Color(0xFFD5E8FC),
                     ),
                  child: Column(
                    children: [
                      mediumSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: primary.withOpacity(0.7),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/Ellipse 1.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    smallHSpace(),
                                    Icon(Icons.arrow_back, color: primary.withOpacity(0.7),),
                                    Icon(Icons.arrow_forward, color: primary.withOpacity(0.7),),
                                    smallHSpace(),
                                    Image.asset(
                                      'assets/images/icons/Ellipse 1.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ],
                                ),
                              SizedBox()
                              ],
                            ),
                            mediumSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Online",
                                style: TextStyle(
                                  fontSize: 12.w,
                                ),),
                                tinyH5Space(),
                                Container(
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                      color: Color(0xFF15801F)
                                  ),
                                )
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              smallSpace(),
                              incoming(),
                              tinySpace(),
                              outgoing(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F4167),
                            gradient: gradient(const Color(0xFF64A4F3).withOpacity(0.6),
                                const Color(0xFF71D2E7).withOpacity(0.78))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.attachment_outlined,
                                    color: primary,
                                    size: 22.w),
                              ),
                              tinyHSpace(),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon:
                                          const Icon(Icons.send_outlined)),
                                      fillColor: white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          borderSide:
                                          BorderSide(color: white))),
                                ),
                              ),
                              tinyH5Space(),
                              const Icon(
                                Icons.mic_none_outlined,
                                color: primary,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container incoming() {
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        margin: const EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
            color: Color(0xFF5BAE59),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          'I commented on Figma, I want to add some fancy icons. Do you have any icon set?',
          style: TextStyle(color: white, fontSize: 14, height: 1.5),
        ));
  }

  Container outgoing() {
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        margin: const EdgeInsets.only(left: 30),
        decoration: BoxDecoration(
            color: Color(0xFF4C8EF4),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          'I commented on Figma, I want to add some fancy icons. Do you have any icon set?',
          textAlign: TextAlign.end,
          style: TextStyle(color: white, fontSize: 14, height: 1.5),
        ));
  }
}
