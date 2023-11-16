import 'package:chat_app/foundation/message_widget/other_message_widget.dart';
import 'package:chat_app/foundation/message_widget/own_message_widget.dart';
import 'package:chat_app/pages/group/msg_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/resource/my_color.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io' show Platform;

class GroupPage extends StatefulWidget {
  const GroupPage({super.key, required this.name, required this.userId});

  final String name;
  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _GroupPageState();
  }
}

class _GroupPageState extends State<GroupPage> {
  IO.Socket? socket;

  List<MessageModel> listMessage = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // var localhost;

    // if (Platform.isAndroid) {
    //   localhost = "http://10.0.2.2:3000/";
    // } else {
    //   localhost = "http://localhost:3000/";
    // }
    socket = IO.io("http://192.168.185.94:9999", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket!.connect();
    if (kDebugMode) {
      print('we are here');
    }
    socket!.onConnect((_) {
      if (kDebugMode) {
        print('connect');
        socket!.on("sendMsgServer", (data) {
          final message = data['data'];
          print(message);

          setState(() {
            listMessage.add(
              MessageModel(
                  type: message["type"],
                  message: message["msg"],
                  sender: message["sender"],
                  userId: message["userId"]),
            );
          });
        });
      }
    });
  }

  void sendMessage(String message, String sender) {
    MessageModel ownMessage = MessageModel(
        type: "ownMsg",
        message: message,
        sender: sender,
        userId: widget.userId);
    setState(() {});
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": message,
      "sender": sender,
      "userId": widget.userId,
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String userId = widget.userId;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                customeOrange,
                customePurple,
              ],
            ),
          ),
        ),
        title: const Text('TMA IOT '),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: listMessage.length,
              itemBuilder: (context, index) {
                MessageModel currentMessage = listMessage[index];
                if (currentMessage.userId == userId) {
                  return OwnMessageWidget(
                      message: currentMessage.message,
                      sender: currentMessage.sender);
                } else {
                  return OtherMessageWidget(
                      message: currentMessage.message,
                      sender: currentMessage.sender);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Type message here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(width: 2),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          String message = _messageController.text;
                          if (message.isNotEmpty) {
                            sendMessage(_messageController.text, name);
                            _messageController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: customePurple,
                        ),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    controller: _messageController,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
