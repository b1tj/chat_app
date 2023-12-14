import 'package:chat_app/Screens/home_screen/chat_room_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/Screens/home_screen/new_message_screen.dart';
import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel user = UserModel(
    uid: "your_uid",
    fullName: "John Doe",
    email: "john.doe@example.com",
    profilePic: "url_to_profile_pic",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Chats'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        NewMessageScreen(userModel: user),
                  ),
                );
              },
              child: SvgPicture.asset('assets/vectors/ic_new_message.svg'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Container(
              height: 58,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: CupertinoTextField(
                placeholder: 'Search',
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(Icons.search, color: Color.fromARGB(66, 0, 0, 0)),
                ),
                placeholderStyle: TextStyle(color: Color.fromARGB(66, 0, 0, 0)),
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.none,
                  ),
                  color: Color.fromARGB(255, 235, 234, 234),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const Divider(),

            // List item chat
            // List item chat
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatRooms")
                    .where("participants.${GlobalData.uid}", isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot chatRoomSnapshot =
                          snapshot.data as QuerySnapshot;

                      List<ChatRoomModel> chatRooms = chatRoomSnapshot.docs
                          .map((doc) => ChatRoomModel.fromMap(
                              doc.data() as Map<String, dynamic>))
                          .toList();

                      // Sắp xếp danh sách chat rooms theo thời gian gần nhất
                      chatRooms.sort(ChatRoomModel.lastTimeComparator);

                      return ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          ChatRoomModel chatRoomModel = chatRooms[index];
                          Map<String, dynamic> participants =
                              chatRoomModel.participants!;
                          List<String> participantKeys =
                              participants.keys.toList();
                          participantKeys.remove(GlobalData.uid);

                          return FutureBuilder(
                            future: FirebaseHelper.getUserModelById(
                                participantKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel targetUser =
                                      userData.data as UserModel;

                                  // Kiểm tra lastMessage có rỗng không
                                  if (chatRoomModel.lastMessage
                                      .toString()
                                      .isNotEmpty) {
                                    return GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ChatRoomScreen(
                                                targetUser: targetUser,
                                                chatroom: chatRoomModel,
                                                userModel: targetUser,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            targetUser.profilePic.toString(),
                                          ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              targetUser.fullName.toString(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 3),
                                              child: Text(
                                                formatLastTime(
                                                    chatRoomModel.lastTime),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          chatRoomModel.lastMessage ??
                                              '', // Tránh lỗi nếu lastMessage là null
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Nếu lastMessage rỗng, trả về Container để ẩn
                                    return Container();
                                  }
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Text("No chats"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatLastTime(DateTime? lastTime) {
  if (lastTime == null) {
    return '';
  }

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(Duration(days: 1));

  if (lastTime.isAfter(today)) {
    // Nếu là hôm nay, hiển thị giờ
    return DateFormat('HH:mm').format(lastTime);
  } else if (lastTime.isAfter(yesterday)) {
    // Nếu là hôm qua, hiển thị 'Yesterday'
    return 'Yesterday';
  } else {
    // Nếu không phải hôm nay hoặc hôm qua, hiển thị ngày/tháng
    return DateFormat('dd/MM/yyyy').format(lastTime);
  }
}
