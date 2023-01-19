import 'dart:convert';

Subscription SubscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String SubscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription(
      {required this.transactionId,
      required this.packageId,
      required this.userId,
      required this.timeStamp,
      required this.expiry});

  final String transactionId;
  final String packageId;
  final String userId;
  final int timeStamp;
  final int expiry;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
      transactionId: json["transaction_id"],
      packageId: json["package_id"],
      userId: json["user_id"],
      timeStamp: json["time_stamp"],
      expiry: json['expiry']);

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "package_id": packageId,
        "user_id": userId,
        "time_stamp": timeStamp,
        "expiry": expiry
      };
}
