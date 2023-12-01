import 'package:chat_app/globals/global_data.dart';
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
        GlobalData.userData = docSnapshot.data() as Map<String, dynamic>;
      }
    });
  }
}
