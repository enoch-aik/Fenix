import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/api_docs.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../const.dart';

class MessagesModel {
  static final List<dynamic> messages = [];

  static updateMessages(dynamic message) async {
    messages.add(message);
  }
}

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  TextEditingController _messageController = TextEditingController();
  UserController userController = Get.find();
  String token = '';
  String roomId = '';
  late ScrollController _controller;
  late IO.Socket socket;

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    _messageController.text = '';
    print(messageText);
    if (messageText != '') {
      var messagePost = {
        'message': messageText,
        'sender': 'Dammy',
        'recipient': 'chat',
        'time': DateTime.now().toUtc().toString().substring(0, 16)
      };
      socket.emit('chat', messagePost);
    }
  }


  @override
  void initState() {
    super.initState();
    token = userController.getToken();
    _messageController = TextEditingController();
    _controller = ScrollController();
    initSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _controller.animateTo(
            0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          )
        });
  }

  Future<void> initSocket() async {
    print('Connecting to chat service');
    socket = IO.io(ChatServices.getChatUrl(roomId), <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      "Authorization": 'Bearer $token'
    });
    // IO.OptionBuilder()
    //     .setTransports(['websocket']) // for Flutter or Dart VM
    //     .disableAutoConnect()
    //     .setAuth(
    //         {"Authorization": 'Bearer $token'}) // disable auto-connection
    //     .build());

    socket.connect();
    socket.on('connect', (_) => print('connect: ${socket.id}'));
    socket.on('connect_error', (_) => print('connect_error: ${socket.opts}'));

    // socket.on('newChat', (message) {
    //   print(message);
    //   setState(() {
    //     MessagesModel.messages.add(message);
    //   });
    // });
    // socket.on('allChats', (messages) {
    //   print(messages);
    //   setState(() {
    //     MessagesModel.messages.addAll(messages);
    //   });
    // });
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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            socket.disconnect();

            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width() * 0.60,
              child: const Text(
                'Chat',
                style: TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 60,
            width: width(),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              reverse: true,
              cacheExtent: 1000,
              itemCount: MessagesModel.messages.length,
              itemBuilder: (BuildContext context, int index) {
                var message = MessagesModel
                    .messages[MessagesModel.messages.length - index - 1];
                return (message['sender'] == 'Dammy')
                    ? Container(
                        constraints: BoxConstraints(maxWidth: width() * 0.7),
                        decoration:
                            const BoxDecoration(color: Colors.greenAccent),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('@${message['time']}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10)),
                            Text('${message['message']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16))
                          ],
                        ),
                      )
                    : Container(
                        constraints: BoxConstraints(maxWidth: width() * 0.7),
                        decoration:
                            const BoxDecoration(color: Colors.purpleAccent),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${message['sender']} @${message['time']}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10)),
                            Text('${message['message']}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16))
                          ],
                        ),
                      );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width() * 0.80,
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: TextField(
                      controller: _messageController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        counterText: '',
                      ),
                      style: const TextStyle(fontSize: 15),
                      keyboardType: TextInputType.text,
                      maxLength: 500,
                    ),
                  ),
                  SizedBox(
                    width: width() * 0.20,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.redAccent),
                      onPressed: () {
                        _sendMessage();
                      },
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
}
