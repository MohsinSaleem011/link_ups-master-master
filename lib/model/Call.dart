// Call Model to be sent and received when calls are made between users

class Call {
  String callerId;
  String callerName;
  String callerPic;
  String receiverId;
  String receiverName;
  String receiverPic;
  String channelId;
  String callType;
  String status;
  bool hasAccepted;
  bool hasDialled;

  Call({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.hasAccepted,
    required this.callType,
    required this.receiverId,
    required this.status,
    required this.receiverName,
    required this.receiverPic,
    required this.channelId,
    required this.hasDialled,
  });

//Method convert Call model to JSON
//Return Map
  // to map
  Map<String, dynamic> toJson(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap['hasAccepted'] = call.hasAccepted;
    callMap["callType"] = call.callType;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.receiverId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_pic"] = call.receiverPic;
    callMap["channel_id"] = call.channelId;
    callMap["status"] = call.status;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }

  factory Call.fromJson(Map<String, dynamic> callMap) => Call(
        hasAccepted: callMap['hasAccepted'],
        callerId: callMap["caller_id"],
        callType: callMap['callType'],
        callerName: callMap["caller_name"],
        status: callMap['status'],
        callerPic: callMap["caller_pic"],
        receiverId: callMap["receiver_id"],
        receiverName: callMap["receiver_name"],
        receiverPic: callMap["receiver_pic"],
        channelId: callMap["channel_id"],
        hasDialled: callMap["has_dialled"],
      );
}
