import 'package:fenix/const.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../onboarding/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF1F4167),
            gradient: gradient(
                const Color(0xFF1F4167), const Color(0xFF0777FB))),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: white,
                      ),
                    ),
                    const Text(
                      'Danny Hopkins',
                      style: TextStyle(color: white),
                    ),
                    Image.asset(
                      'assets/images/icons/Ellipse 1.png',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
              tinySpace(),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,

                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50)),
                      color: const Color(0xFF1F4167),
                      gradient: gradient(const Color(0xFF000000),
                          const Color(0xFF182845))),
                  child: Column(
                    children: [
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
                            borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(15)),
                            gradient:
                            gradient(const Color(0xFF1F4167), const Color(0xFF000000))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: white),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.camera_alt_outlined, size: 20),
                                  )),
                              tinyHSpace(),
                              Expanded(
                                child: TextFormField(

                                  decoration: InputDecoration(
                                      contentPadding:EdgeInsets.zero,
                                      suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.send_outlined)),
                                      fillColor: white,
                                      filled: true,

                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: white))),
                                ),
                              ),                  tinyH5Space(),

                              const Icon(
                                Icons.mic_none_outlined,
                                color: white,
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
                                padding:
                                const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                margin: const EdgeInsets.only(right: 30),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'I commented on Figma, I want to add some fancy icons. Do you have any icon set?',
                                  style: TextStyle(
                                      color: light, fontSize: 14, height: 1.5),
                                ));
  }
  Container outgoing() {
    return Container(
                                padding:
                                const EdgeInsets.fromLTRB(25, 10, 25, 10),
                                margin: const EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                    color: lightGrey.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'I commented on Figma, I want to add some fancy icons. Do you have any icon set?',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: light, fontSize: 14, height: 1.5),
                                ));
  }
}
