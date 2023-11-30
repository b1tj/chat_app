import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: SafeArea(
          child: Container(
        child: Column(children: [
          // tin nhắn
          Expanded(child: Container()),

          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),

            child: Row(
              children: [
                Flexible(child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter message...",
                    hintStyle: TextStyle(color: Colors.black)
                  ),
                )),

                IconButton(onPressed: () {}, icon: Icon(Icons.send, color: Colors.lightBlue))
              ],
            ),
          )
        ]),
      )),
    );
  }
}
