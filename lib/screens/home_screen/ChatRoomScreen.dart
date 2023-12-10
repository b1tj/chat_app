import 'package:chat_app/Screens/home_screen/NewMessageScreen.dart';
import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/ChatRoomModel.dart';
import 'package:chat_app/models/MessageModel.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  // final User firebaseUser;

  const ChatRoomScreen({
    super.key,
    required this.targetUser,
    required this.chatroom,
    required this.userModel,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();
  

  void sendMessage() async {
  String msg = messageController.text.trim();
  messageController.clear();

  if (msg.isNotEmpty) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: GlobalData.uid,
        timeStamp: DateTime.now(),
        text: msg,
        seenStatus: false,
      );

      await FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(widget.chatroom.chatRoomId)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      // Update lastMessage field in the chat room
      widget.chatroom.lastMessage = msg;

      // Update the chat room in Firestore
      await FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(widget.chatroom.chatRoomId)
          .update({
        'lastMessage': msg,
        // Add any other fields you want to update
        'lastTime': DateTime.now()
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  NetworkImage(widget.targetUser.profilePic.toString()),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              widget.targetUser.fullName.toString(),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Column(children: [
          // tin nhắn
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatRooms")
                    .doc(widget.chatroom.chatRoomId)
                    .collection("messages")
                    .orderBy("timeStamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                          reverse: true,
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                dataSnapshot.docs[index].data()
                                    as Map<String, dynamic>);

                            return Row(
  mainAxisAlignment:
      (currentMessage.sender == GlobalData.uid)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
  children: [
    Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7, // Set a maximum width
      ),
      decoration: BoxDecoration(
        color: (currentMessage.sender == GlobalData.uid)
            ? Colors.blue
            : Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        currentMessage.text.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        softWrap: true, // Allow text to wrap to the next line
        maxLines: null, // Unlimited number of lines
      ),
    ),
  ],
);

                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("An error! Check your internet"),
                      );
                    } else {
                      return Center(
                        child: Text("Say hi to your new friends"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Flexible(
                    child: TextField(
                  controller: messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter message...",
                      hintStyle: TextStyle(color: Colors.black)),
                )),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.send, color: Colors.lightBlue))
              ],
            ),
          )
        ]),
      )),
    );
  }
}
