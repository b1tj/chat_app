class UserModel {
  late String uid;
  late String fullName;
  late String email;
  late String profilePic;

  UserModel(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.profilePic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uId"];
    fullName = map["fullName"];
    email = map["email"];
    profilePic = map["profilePic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uId": uid,
      "fullName": fullName,
      "email": email,
      "profilePic": profilePic
    };
  }
}
