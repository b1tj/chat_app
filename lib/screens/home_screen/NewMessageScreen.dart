// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:chat_app/Screens/home_screen/ChatRoomScreen.dart';
import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/ChatRoomModel.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class NewMessageScreen extends StatefulWidget {
  final UserModel userModel;
  final User? firebaseUser;
  final ChatRoomModel? chatroom;
  const NewMessageScreen({
    super.key,
    required this.userModel,
    this.firebaseUser, this.chatroom,
  });

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    if (widget.userModel == null) {
      print("Error: widget.userModel is null");
      return null;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .where("participants.${GlobalData.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      // fetch the existing one
      print("Room đã tồn tại");
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      // create a new one
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          GlobalData.uid: true,
          targetUser.uid!: true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());

      chatRoom = newChatRoom;
      print("Created a new room!");
    }

    return chatRoom; // Make sure to return chatRoom here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: Text("New message"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                CupertinoTextField(
                  controller: searchController,
                  placeholder: 'Email address',
                  prefix: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child:
                        Icon(Icons.email, color: Color.fromARGB(66, 0, 0, 0)),
                  ),
                  placeholderStyle:
                      TextStyle(color: Color.fromARGB(66, 0, 0, 0)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.none,
                    ),
                    color: Color.fromARGB(255, 235, 234, 234),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Display item after searching
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: searchController.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;
                      if (dataSnapshot.docs.length > 0) {
                        Map<String, dynamic> userMap =
                            dataSnapshot.docs[0].data() as Map<String, dynamic>;

                        UserModel searchedUser = UserModel.fromMap(userMap);

                        return ListTile(
                          onTap: () async {
                            
                            ChatRoomModel? chatroomModel =
                                await getChatRoomModel(searchedUser);
                            if (chatroomModel != null) {
                             
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoomScreen(
                                    targetUser: searchedUser,
                                    userModel: widget.userModel,
                                    chatroom: chatroomModel,
                                  ),
                                ),
                              );

                              
                            } else {
                              // Handle the case where getChatRoomModel returns null
                              print("ChatRoomModel is null");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Failed to create or retrieve chat room."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          leading: CircleAvatar(
                            backgroundImage: searchedUser.profilePic != null
                                ? NetworkImage(searchedUser.profilePic!)
                                : AssetImage("assets/default_profile_pic.png")
                                    as ImageProvider<Object>,
                            backgroundColor: Colors.grey[500],
                          ),
                          title: Text(searchedUser.fullName ?? ""),
                          subtitle: Text(searchedUser.email ?? ""),
                          trailing: Icon(Icons.keyboard_arrow_right_outlined),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Đã có lỗi xảy ra!");
                      } else {
                        return Text("Không tìm thấy user!");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
