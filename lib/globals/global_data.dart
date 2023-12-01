import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class GlobalData {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static late String uid;
  static User? user;
  static Map<String, dynamic>? userData;
}
