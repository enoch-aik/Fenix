import 'dart:async';

import 'package:fenix/controller/chat_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/api_docs.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  const Chat({Key? key, this.userId, this.id, this.name}) : super(key: key);
  final String? userId, id, name;

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final TextEditingController _messageController = TextEditingController();
  UserController userController = Get.find();
  ChatController chatController = Get.put(ChatController());
  String token = '';
  String userId = '';
  String userName = '';
  String recipient = '';

  IO.Socket? socket;

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    _messageController.text = '';
    if (messageText != '') {
      var messagePost = {
        'content': messageText,
      };
      socket!.emit('message', messagePost);
      print('message');

      socket!.on('message', (data) => print('sent --- $data'));
      getChat();
    }
  }

  void _joinChat() {
    socket!.emit('join-room', []);
    print('join');
    socket!.on('join-room', (data) => print('==> join $data'));
  }

  @override
  void initState() {
    super.initState();
    boot();
  }

  getChat() async {
    if (widget.userId != null) {
      chatController.getVendorChats(widget.userId);
    }
    if (widget.id != null) {
      chatController.getChatsById(widget.id);
    }
  }

  boot() async {
    token = userController.getToken();
    userId = userController.getUser()!.userId.toString();
    userName = userController.getUser()!.username.toString();
    print('my user $userId');
    getChat();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (chatController.chatId.isNotEmpty) {
        timer.cancel();
        var roomId = chatController.chatId.obs.string;
        initSocket(roomId);
        recipient = chatController.vendorName.obs.string;
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

    socket!.connect();
    socket!.onConnect((data) {
      print('Success --- $data');
      _joinChat();
    });


    print(socket!.opts);

    socket!.onError((data) => print('Error --- $data'));
    socket!.onDisconnect((data) => print('Disconnect --- $data'));

    socket!.on('join-room', (data) {
      print(data);
    });

    socket!.on('message', (messages) {
      print('messages ===> $messages');
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    socket!.disconnect();
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
                      Expanded(
                        child: Center(
                          child: Obx(
                            () => chatController.isLoadingChats.isTrue
                                ? Text(
                                    userId,
                                    softWrap: false,
                                    style: const TextStyle(color: white),
                                  )
                                : Text(
                                    widget.name ?? recipient,
                                    softWrap: false,
                                    style: const TextStyle(color: white),
                                  ),
                          ),
                        ),
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
                                            color: white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  groupSeparatorBuilder:
                                      (String groupByValue) => smallSpace(),
                                  itemBuilder: (context, dynamic message) {
                                    return (message['sender'] == userName)
                                        ? outgoing('${message['text']}', message['createdAt'])
                                        : incoming('${message['text']}', message['createdAt']);
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
                                          onFieldSubmitted: (v) {
                                            _sendMessage();
                                          },
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _sendMessage();
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

  Widget incoming(message, timeSent) {
    return Align(
      alignment: Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 10, 20.w, 10),
            margin: EdgeInsets.only(left: 12.w,bottom: 20),
            constraints: BoxConstraints(
                maxWidth: Get.width * 0.78
            ),
            decoration: BoxDecoration(
                color: Color(0xFF373E4E),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: GoogleFonts.poppins().copyWith(color: white, fontSize: 14, height: 1.5,),
                ),
                tiny5Space(),
                Text(DateFormat("hh:mm a").format(DateTime.parse(timeSent)),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins().copyWith(color: white, fontSize: 9.w, fontWeight: FontWeight.w500, height: 1.5,),
                ),
              ],
            )),
      ),
    );
  }

  Widget outgoing(message, timeSent) {
    return Align(
      alignment: Alignment.centerRight,
      child: UnconstrainedBox(
        child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 10, 20.w, 10),
            margin: EdgeInsets.only(right: 12.w, bottom: 20),
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.78
            ),
            decoration: BoxDecoration(
                color: Color(0xFF7A8194), borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins().copyWith(color: white, fontSize: 14, height: 1.5,),
                ),
                tiny5Space(),
                Text(DateFormat("hh:mm a").format(DateTime.parse(timeSent)),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins().copyWith(color: white, fontSize: 9.w, fontWeight: FontWeight.w500, height: 1.5,),
                ),
              ],
            )),
      ),
    );
  }
}
