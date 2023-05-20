import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import '../models/services/api_docs.dart';
class Websocket extends StatefulWidget {
  const Websocket({Key? key}) : super(key: key);

  @override
  State<Websocket> createState() => _WebsocketState();
}

class _WebsocketState extends State<Websocket> {
  final TextEditingController _controller = TextEditingController();
  String token ='';



  final _channel =
  IOWebSocketChannel.connect(chatUrl, headers: {
    HttpHeaders.authorizationHeader: 'Bearer token',
  }); //channel IP : Port

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("widget.title")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              ),
            ),
            const SizedBox(height: 24),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
                onFieldSubmitted: (v) => v.isNotEmpty ? _sendMessage() : null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}