import 'package:chat_app/Screens/home_screen/ChatRoomScreen.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  TextEditingController searchController = TextEditingController();

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
                    setState(() {
                      
                    });
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // hiển thị item sau khi search
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("email", isEqualTo: searchController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                        if(dataSnapshot.docs.length > 0) {
                          

                          Map<String, dynamic> userMap = dataSnapshot.docs[0].data() as  Map<String, dynamic>;

                          UserModel searchedUser = UserModel.fromMap(userMap);

                          return ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ChatRoomScreen();
                              }));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(searchedUser.profilePic!),
                              backgroundColor: Colors.grey[500],
                            ),
                            title: Text(searchedUser.fullName!),
                            subtitle: Text(searchedUser.email!),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined),
                          );
                        }
                        else if (snapshot.hasError) 
                        {
                          return Text("Đã có lỗi xảy ra!");
                        }
                        else {
                          return Text("Không tìm thấy user!");
                        }
                      } 
                      else {
                        return CircularProgressIndicator();
                      }
                    })
              ],
            )),
          ),
        ));
  }
}
