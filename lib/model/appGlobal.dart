import 'package:link_up/model/chatModel.dart';


var appToken;
getToken(String token){
  appToken=token;

}
List< MessageModel> messageList=[

  MessageModel(
    id: '1',
    type: 1,
    content: 'Hello',
    senderID: '1',
    receiverToken: '2',
    time: DateTime.now()
  ),
  MessageModel(
    id: '1',
    type: 1,
    content: 'Hello how are you',
    senderID: '2',
    receiverToken: '2',
    time: DateTime.now()
  ),
  MessageModel(
    id: '1',
    type: 1,
    content: 'Hello',
    senderID: '1',
    receiverToken: '2',
    time: DateTime.now()
  ),
  MessageModel(
    id: '1',
    type: 1,
    content: 'whats about you?',
    senderID: '2',
    receiverToken: '2',
    time: DateTime.now()
  ),
  MessageModel(
    id: '1',
    type: 1,
    content: 'fine',
    senderID: '1',
    receiverToken: '2',
    time: DateTime.now()
  ),

];