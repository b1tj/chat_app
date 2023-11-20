import 'package:chat_app/Screens/auth_screen/SignInScreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key});

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen1()),
      (route) => false,
    );
  }

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

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
          child: Text('More'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFFECECEC),
                  ),
                  child: SvgPicture.asset(
                    'assets/vectors/ic_user_avatar.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: _userStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Connection error!");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          }

                          var querySnapshot = snapshot.data
                              as QuerySnapshot<Map<String, dynamic>>?;

                          if (querySnapshot != null &&
                              querySnapshot.docs.isNotEmpty) {
                            var userData = querySnapshot.docs.first.data();
                            var fullName = userData['fullName'] ?? 'No Name';

                            return Text(
                              fullName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const Text("No user data");
                          }
                        },
                      ),
                      SizedBox(height: 8),
                      Text(
                        user.email!,
                        style: TextStyle(
                          color: Color(0xFFADB5BD),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                Container(
                  child: SvgPicture.asset('assets/vectors/ic_arrow_right.svg'),
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            for (int i = 0; i < itemList.length; i++) ...[
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          itemList[i].icon ?? '',
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(itemList[i].title ?? ''),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      SvgPicture.asset('assets/vectors/ic_arrow_right.svg'),
                    ],
                  ),
                ),
              )
            ],
            SizedBox(height: 12),
            Divider(
              thickness: 1.2,
            ),
            SizedBox(height: 8),
            for (int i = 0; i < partialItemList.length; i++) ...[
              InkWell(
                onTap: () {
                  if (partialItemList[i].title == 'Logout') {
                    widget.signUserOut(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          partialItemList[i].icon ?? '',
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(partialItemList[i].title ?? ''),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      SvgPicture.asset('assets/vectors/ic_arrow_right.svg')
                    ],
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}

class ItemEntity {
  final String icon;
  final String title;

  ItemEntity({required this.icon, required this.title});
}

List<ItemEntity> itemList = [
  ItemEntity(
    icon: 'assets/vectors/ic_user_avatar.svg',
    title: 'Account',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_chat_small.svg',
    title: 'Chats',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_appearance.svg',
    title: 'Appearance',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_notification.svg',
    title: 'Notification',
  ),
];

List<ItemEntity> partialItemList = [
  ItemEntity(
    icon: 'assets/vectors/ic_envelop.svg',
    title: 'Invite your friends',
  ),
  ItemEntity(
    icon: 'assets/vectors/ic_logout.svg',
    title: 'Logout',
  ),
];
