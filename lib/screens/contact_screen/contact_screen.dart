import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      QuerySnapshot<Map<String, dynamic>> dataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uId',)
          .get();

      if (dataSnapshot.docs.isNotEmpty) {
        // User data found, populate the list
        setState(() {
          users = dataSnapshot.docs.map((doc) {
            Map<String, dynamic> userMap = doc.data()!;
            return UserEntity(
              avatar: userMap['profilePic'],
              userName: userMap['fullName'],
              email: userMap['email'],
              status: userMap['status'],
            );
          }).toList();
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Contact', style: TextStyle(color: Colors.black)),
        centerTitle: true,
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
            );
          },
        ),
      ),
    );
  }
}

class UserEntity {
  final String? avatar;
  final String? userName;
  final String? email;
  final String? status;

  UserEntity({
    this.status,
    this.avatar,
    this.userName,
    this.email,
  });
}
