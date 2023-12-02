import 'package:chat_app/Screens/home_screen/ChatRoomScreen.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:chat_app/Screens/home_screen/NewMessageScreen.dart';
import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/ChatRoomModel.dart';
import 'package:chat_app/models/FirebaseHelper.dart';
import 'package:chat_app/screens/home_screen/chat_detail_screen.dart';
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

  List<String> people = [
    'Messi',
    'Vinh',
    'Ronaldo',
    'Sarah',
    'Natasha',
    'Robert',
    'Thomas',
    'Natasha',
    'Claire',
    'Olivia',
    'Emma',
    'Amelia',
    'Liam',
    'William',
    'Lucas',
    'Henry',
    'Mia',
    'Ava',
    'Evelyn',
    'Luna',
  ];

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
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: people.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int i) {
                  bool isOnline = true;

                  return InkWell(
                    onTap: () {
                      // Navigate to chat detail screen when user is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ChatDetailsScreen(i + 1, people[i]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/${i + 1}.png',
                                    ),
                                    scale: 10,
                                    fit: BoxFit.contain,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        isOnline ? Colors.green : Colors.grey,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            people[i],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                    .orderBy("lastTime", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot chatRoomSnapshot =
                          snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        itemCount: chatRoomSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                              chatRoomSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

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
                                                chatRoomModel.lastTime != null
                                                    ? DateFormat('HH:mm')
                                                        .format(chatRoomModel
                                                            .lastTime!)
                                                    : '',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(chatRoomModel.lastMessage
                                            .toString()),
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
