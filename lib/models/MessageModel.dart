class MessageModel {
  String? sender;
  String? text;
  bool? seenStatus;
  DateTime? createDon;

  MessageModel({this.sender, this.text, this.seenStatus, this.createDon});

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map["sender"];
    text = map["text"];
    seenStatus = map["seenStatus"];
    createDon = map["createDon"];
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "text": text,
      "seenStatus": seenStatus,
      "createDon": createDon,
    };
  }
}