class MessageModel{

  String? id;
  String? senderID;
  String? receiverToken;
  String? content;
  int? type;

  DateTime? time;


  MessageModel({
    this.id,
    this.content,
    this.senderID,
    this.type,

    this.receiverToken,


    this.time
  });

  factory MessageModel.fromMap(var map){
    return MessageModel(

        senderID: map['senderID'],
        receiverToken: map['receiverToken'],

        content: map['content'],
        time: map['time'],
        id: map['id'],
        type: map['type'],

    );


  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['content']=content;

    map['receiverToken']=receiverToken;
    map['type']=type;
    map['senderID']=senderID;
    map['time']=time;
    id=map['id'];
    return map;

  }





}