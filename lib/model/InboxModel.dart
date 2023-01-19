class InboxModel {
  final String chatID;
  final String withID;
  final String withName;
  final String avatar;
  String lastText;
  final String lastTime;
  int unReadMsgCount;

  InboxModel({
    required this.chatID,
    required this.withID,
    required this.withName,
    required this.avatar,
    required this.lastText,
    required this.lastTime,
    required this.unReadMsgCount,
  });

  factory InboxModel.fromJson(Map<String, dynamic> json) {
    return new InboxModel(
      chatID: json['chatID'],
      withID: json['withID'],
      withName: json['withName'],
      avatar: json['avatar'],
      lastText: json['lastText'],
      lastTime: json['lastTime'],
      unReadMsgCount: json['unReadMsgCount'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['chatID'] = chatID;
    map['withID'] = withID;
    map['withName'] = withName;
    map['avatar'] = avatar;
    map['lastText'] = lastText;
    map['lastTime'] = lastTime;
    map['unReadMsgCount'] = unReadMsgCount;
    return map;
  }
}
