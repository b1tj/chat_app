class MessageModel {
  String? sender;
  String? text;
  bool? seenStatus;
  DateTime? timeStamp;

  MessageModel({this.sender, this.text, this.seenStatus, this.timeStamp});

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map["sender"];
    text = map["text"];
    seenStatus = map["seenStatus"];
    timeStamp = map["timeStamp"];
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "text": text,
      "seenStatus": seenStatus,
      "timeStamp": timeStamp,
    };
  }
}
