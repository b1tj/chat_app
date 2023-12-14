import 'package:chat_app/models/chat_room_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreen();
}

class _ContactScreen extends State<ContactScreen> {
  List<UserEntity> users = [];

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firebase
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> dataSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      if (dataSnapshot.docs.isNotEmpty) {
        List<UserEntity> unsortedUsers = dataSnapshot.docs.map((doc) {
          Map<String, dynamic> userMap = doc.data()!;
          return UserEntity(
            uid: userMap['uId'],
            avatar: userMap['profilePic'],
            userName: userMap['fullName'],
            email: userMap['email'],
            status: userMap['status'],
          );
        }).toList();

        unsortedUsers.sort((a, b) => a.userName!.compareTo(b.userName!));
        setState(() {
          users = unsortedUsers;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void handleUserSelection(UserEntity selectedUser) {
    print('Selected User Information:');
    print('UID: ${selectedUser.uid}');
    print('Username: ${selectedUser.userName}');
    print('Email: ${selectedUser.email}');
    print('Avatar: ${selectedUser.avatar}');
    print('Status: ${selectedUser.status}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottomOpacity: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 13),
          child: Text('Suggestion'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: ListView.separated(
          itemCount: users.length,
          padding: const EdgeInsets.only(top: 16),
          separatorBuilder: (context, index) {
            return Container(
              color: Color(0xFFEDEDED),
              height: 1,
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
            );
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
                left: 24,
                right: 24,
              ),
              child: InkWell(
                onTap: () {
                  // Call the function to handle user selection
                  handleUserSelection(users[index]);
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                      ),
                      child: SizedBox(
                        height: 56,
                        width: 56,
                        child: Center(
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(users[index].avatar ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          users[index].userName ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          users[index].email ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserEntity {
  final String? uid;
  final String? avatar;
  final String? userName;
  final String? email;
  final String? status;

  UserEntity({
    this.uid,
    this.status,
    this.avatar,
    this.userName,
    this.email,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      uid: map['uid'],
      avatar: map['profilePic'],
      userName: map['fullName'],
      email: map['email'],
      status: map['status'],
    );
  }
}
