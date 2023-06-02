import 'package:fenix/const.dart';
import 'package:fenix/controller/chat_controller.dart';
import 'package:fenix/helpers/widgets.dart';
import 'package:fenix/screens/chat.dart';
import 'package:fenix/screens/profile/chat_screen.dart';
import 'package:fenix/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/user_controller.dart';
import '../onboarding/constants.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String selectedTab = 'chat';
  final TextEditingController _controller = TextEditingController();
  String token = '';
  final UserController _userController = Get.find();
  final ChatController _chatController = Get.find();

  @override
  void initState() {
    token = _userController.getToken();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0777FB),
      body: Column(
        children: [
          selectedTab == 'chat'
              ? Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF1F4167),
                        gradient: gradient(
                            const Color(0xFF1F4167), const Color(0xFF0777FB))),
                    child: SafeArea(
                        bottom: false,
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            backArrow(),
                                            Text(
                                              'Messages',
                                              style: TextStyle(
                                                  color: white, fontSize: 23.w),
                                            ),
                                            const SizedBox(width: 5)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height: 90,
                                          child: Obx(
                                            () => _chatController
                                                    .isLoadingAllChats.isTrue
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : ListView.separated(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    itemCount: _chatController
                                                        .allChats.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (c, i) =>
                                                        userAvatar(
                                                            _chatController
                                                                .allChats[i]),
                                                    separatorBuilder: (c, i) =>
                                                        smallHSpace(),
                                                  ),
                                          )),
                                    ],
                                  ),
                                  tinySpace(),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 5.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(50)),
                                          color: const Color(0xFF1F4167),
                                          gradient: gradient(
                                              const Color(0xFF000000),
                                              const Color(0xFF182845))),
                                      child: ListView(
                                        children: [
                                          smallSpace(),
                                          Obx(
                                            () => _chatController
                                                    .isLoadingAllChats.isTrue
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : ListView.separated(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: _chatController
                                                        .allChats.length,
                                                    shrinkWrap: true,
                                                    itemBuilder: (c, i) =>
                                                        chatUser(_chatController
                                                            .allChats[i]),
                                                    separatorBuilder: (c, i) =>
                                                        const Divider(
                                                            color: grey,
                                                            thickness: 0.1),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                )
              : selectedTab == 'notification'
                  ? Expanded(
                      child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF1F4167),
                          gradient: gradient(const Color(0xFF000000),
                              const Color(0xFF182845))),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                backArrow(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  : Expanded(
                      child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF1F4167),
                          gradient: gradient(const Color(0xFF000000),
                              const Color(0xFF182845))),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                backArrow(),
                                Text('Edit',
                                    style: TextStyle(
                                        color: white, fontSize: 22.w)),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/icons/Ellipse 1.png',
                            height: 128,
                            width: 128,
                          ),
                          smallSpace(),
                          const Center(
                              child: Text(
                            'Khasan Akmalov',
                            style: TextStyle(color: Colors.white),
                          )),
                          verticalSpace(0.08),
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF1F4167),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                    child: Text(
                                  'Fenix Message Center',
                                  style: TextStyle(color: Color(0xFF0777FB)),
                                )),
                              )),
                          mediumSpace(),
                          userDetail('First Name:', 'Barry'),
                          smallSpace(),
                          userDetail('Last Name:', 'Manchez'),
                          smallSpace(),
                          userDetail('Phone Number:', '+(988) 97 7712002'),
                          smallSpace(),
                          userDetail('Email:', 'barrymachez@gmail.com'),
                        ],
                      ),
                    )),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFF1F4167),
                gradient:
                    gradient(const Color(0xFF1F4167), const Color(0xFF0777FB))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => setState(() => selectedTab = 'notification'),
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedTab == 'notification'
                                ? const Color(0xFF1F4167)
                                : null),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.notifications_active_outlined,
                            color:
                                selectedTab == 'notification' ? green : white,
                            size: 35,
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () => setState(() => selectedTab = 'chat'),
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedTab == 'chat'
                                ? const Color(0xFF1F4167)
                                : null),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/icons/chat.png',
                            width: 30,
                            color: selectedTab == 'chat' ? green : white,
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () => setState(() => selectedTab = 'setting'),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedTab == 'setting'
                              ? const Color(0xFF1F4167)
                              : null),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.settings,
                          color: selectedTab == 'setting' ? green : white,
                          size: 35,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container userDetail(title, desc) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF1F4167),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: const TextStyle(color: lightGrey, fontSize: 17),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  desc,
                  style: const TextStyle(color: lightGrey, fontSize: 17),
                )),
          ],
        ),
      ),
    );
  }

  Padding chatUser(user) {
    print(user);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Get.to(() => Chat(
              id: user['id'],
              name: user['username'],
            )),
        child: Row(
          children: [
            const Stack(
              children: [
                CircleAvatar(radius: 30, backgroundColor: grey),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.circle, color: Colors.green))
              ],
            ),
            smallHSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${user['username']}',
                          softWrap: false,
                          style: const TextStyle(color: white),
                        ),
                      ),
                      smallHSpace(),
                      const Text(
                        '08:45',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  tiny5Space(),
                  Text(
                    '${user['lastMessage']}',
                    style: const TextStyle(color: light, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column userAvatar(user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: grey,
              child: Image.asset(
                'assets/images/icons/Ellipse 1.png',
              ),
            ),
            const Positioned(
                bottom: 0,
                right: 0,
                child: Icon(Icons.circle, color: Colors.green))
          ],
        ),
        tiny5Space(),
        Text(
          user['username'].toString().length > 10
              ? user['username'].toString().substring(0, 10)
              : user['username'].toString(),
          style: const TextStyle(color: white, fontSize: 14),
        )
      ],
    );
  }
}
