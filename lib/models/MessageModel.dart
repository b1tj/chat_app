import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seenStatus;
  DateTime? timeStamp;

  MessageModel({this.messageId, this.sender, this.text, this.seenStatus, this.timeStamp});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map["messageId"];
    sender = map["sender"];
    text = map["text"];
    seenStatus = map["seenStatus"];
    timeStamp = (map["timeStamp"] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "sender": sender,
      "text": text,
      "seenStatus": seenStatus,
      "timeStamp": timeStamp,
    };
  }

  
}
