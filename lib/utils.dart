import 'package:chat_app/globals/global_data.dart';
import 'package:chat_app/models/UsersModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Utils {
  static getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static getUserData(uid) {
    GlobalData.db
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> map = docSnapshot.data() as Map<String, dynamic>;
        GlobalData.userData = UserModel(
            uid: map['uId'],
            fullName: map['fullName'],
            email: map['email'],
            profilePic: map['profilePic']);
      }
    });
  }

  static updateUserName(uid, newName) {
    GlobalData.db
        .collection('users')
        .doc(uid)
        .update({'fullName': newName})
        .then((value) => print('User updated'))
        .catchError((err) => print(err));
  }
}
