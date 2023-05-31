import 'dart:async';

import 'package:fenix/controller/chat_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/api_docs.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../const.dart';
import '../theme.dart';
import 'onboarding/constants.dart';

class MessagesModel {
  static final List<dynamic> messages = [];

  static updateMessages(dynamic message) async {
    messages.add(message);
  }
}

class Chat extends StatefulWidget {
  const Chat({Key? key, this.userId}) : super(key: key);
  final String? userId;

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  UserController userController = Get.find();
  ChatController chatController = Get.put(ChatController());
  String token = '';
  String userId = '';

  late IO.Socket socket;

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    _messageController.text = '';
    if (messageText != '') {
      var messagePost = {
        'content': messageText,
      };
      socket.emit('message', messagePost);
      print('message');

      socket.on('message', (data) => print('sent --- $data'));
      chatController.getChats(widget.userId);
    }
  }

  void _joinChat() {
    socket.emit('join-room', []);
    print('join');
    socket.on('join-room', (data) => print('==> join $data'));
  }

  @override
  void initState() {
    super.initState();
    boot();
  }

  boot() async {
    token = userController.getToken();
    userId = userController.getUser()!.userId.toString();
    chatController.getChats(widget.userId??userId);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (chatController.chatId.isNotEmpty) {
        timer.cancel();
        var roomId = chatController.chatId.obs.string;
        setState(() {});
        initSocket(roomId);
      }
    });
  }

  Future<void> initSocket(roomId) async {
    print('Connecting to chat service');
    String url = ChatServices.getChatUrl(roomId);
    print(url);
    socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders(
                {"Authorization": "Bearer $token"}) // disable auto-connection
            .build());

    socket.connect();
    socket.onConnect((data) {
      print('Success --- $data');
      _joinChat();
    });

    print(socket.opts);

    socket.onError((data) => print('Error --- $data'));
    socket.onDisconnect((data) => print('Disconnect --- $data'));

    socket.on('join-room', (data) {
      print(data);
    });

    socket.on('message', (messages) {
      print('messages ===> $messages');
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    socket.disconnect();
    super.dispose();
  }

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
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50)),
                color: const Color(0xFF1F4167),
                gradient:
                    gradient(const Color(0xFF000000), const Color(0xFF182845))),
            child: Column(
              children: [
                mediumSpace(),
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
                Expanded(
                  child: Obx(
                    () => chatController.isLoadingChats.isTrue
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Expanded(
                                child: GroupedListView<dynamic, String>(
                                  elements: chatController.chats.value,
                                  padding: const EdgeInsets.all(0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  groupBy: (item) => DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(
                                          item['createdAt'].toString()))
                                      .toString(),
                                  groupHeaderBuilder: (item) => Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 8),
                                    child: Center(
                                      child: Text(
                                        DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.parse(
                                                        item['createdAt']
                                                            .toString()))
                                                    .toString() ==
                                                DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now())
                                                    .toString()
                                            ? 'Today'
                                            : DateFormat.MMMEd().format(
                                                DateTime.parse(item['createdAt']
                                                    .toString())),
                                        style: const TextStyle(
                                          fontSize: 13,
                                            color: white,fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  groupSeparatorBuilder:
                                      (String groupByValue) => smallSpace(),
                                  itemBuilder: (context, dynamic message) {
                                    print(message);
                                    print(userId);
                                    return (message['senderId'] == userId)
                                        ? outgoing('${message['text']}')
                                        : incoming('${message['text']}');
                                  },
                                  order: GroupedListOrder.ASC, // optional
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF1F4167),
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    gradient: gradient(const Color(0xFF1F4167),
                                        const Color(0xFF000000))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 17),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: white),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 20),
                                          )),
                                      tinyHSpace(),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _messageController,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _sendMessage();
                                                    // _joinChat();
                                                  },
                                                  icon: const Icon(
                                                      Icons.send_outlined)),
                                              fillColor: white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: const BorderSide(
                                                      color: white))),
                                        ),
                                      ),
                                      tinyH5Space(),
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
      ),
    );
  }

  Container incoming(message) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        margin: const EdgeInsets.only(right: 30),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          message,
          style: const TextStyle(color: white, fontSize: 14, height: 1.5),
        ));
  }

  Container outgoing(message) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        margin: const EdgeInsets.only(left: 30,bottom: 20),
        decoration: BoxDecoration(
            color: lightGrey, borderRadius: BorderRadius.circular(20)),
        child: Text(
          message,
          textAlign: TextAlign.end,
          style: const TextStyle(color: white, fontSize: 14, height: 1.5),
        ));
  }
}
