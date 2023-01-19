class RecentChatModel {
  RecentChatModel({
    required this.lastText,
    required this.withAvatar,
    required this.withName,
    required this.withId,
    required this.chatId,
    required this.timestamp,
  });

  String lastText;
  String withAvatar;
  String withName;
  String withId;
  String chatId;
  int timestamp;

  factory RecentChatModel.fromJson(Map<String, dynamic> json) =>
      RecentChatModel(
        lastText: json["lastText"],
        withAvatar: json["withAvatar"],
        withName: json["withName"],
        withId: json["withID"],
        chatId: json['chatID'],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "lastText": lastText,
        "withAvatar": withAvatar,
        "withName": withName,
        "withID": withId,
        "chatID": chatId,
        "timestamp": timestamp,
      };
}
