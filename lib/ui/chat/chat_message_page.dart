// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:link_up/get_controller/ChatController.dart';
// // import 'package:link_up/get_controller/auth_controller.dart';
// // import 'package:link_up/helper/app_constant.dart';
// // import 'package:link_up/helper/router/route_path.dart';
// // import 'package:link_up/model/user_model.dart';
// // import 'package:link_up/ui/chat/calling/dial.dart';

// // class ChatMessagePage extends StatefulWidget {
// //   final String endUserID;
// //   final String endUserName;
// //   final String chatID;

// //   const ChatMessagePage(
// //       {required this.endUserID,
// //       required this.endUserName,
// //       required this.chatID,
// //       // this.endUser,
// //       Key? key})
// //       : super(key: key);
// //   @override
// //   _ChatMessagePageState createState() => _ChatMessagePageState();
// // }

// // class _ChatMessagePageState extends State<ChatMessagePage> {
// //   FirebaseFirestore db = FirebaseFirestore.instance;
// //   AuthController authController = Get.find(tag: AuthController().toString());
// //   ChatController chatController = Get.find(tag: ChatController().toString());

// //   FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
// //   late CollectionReference chatReference;
// //   bool _isWritting = false;
// //   TextEditingController _textController = new TextEditingController();
// //   final _picker = ImagePicker();
// //   late Timer _timer;
// //   UserModel? endUser;

// //   Future<void> checkedReadMsg() async {
// //     db
// //         .collection('chats')
// //         .doc(widget.chatID)
// //         .collection('message')
// //         .where('senderID', isEqualTo: widget.endUserID)
// //         .where('isRead', isEqualTo: false)
// //         .get()
// //         .then((querySnapshot) {
// //       querySnapshot.docs.forEach((doc) {
// //         db
// //             .collection('chats')
// //             .doc(widget.chatID)
// //             .collection('message')
// //             .doc(doc.id)
// //             .update({
// //           'isRead': true,
// //         });
// //       });
// //     });
// //   }

// //   Future<void> getEndUser() async {
// //     var _res = await db.collection('users').doc(widget.endUserID).snapshots();
// //     setState(() {
// //       _res.listen((event) {
// //         endUser = UserModel.fromJson(event.data()!);
// //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //           chatController.updateEndUser(UserModel.fromJson(event.data()!));
// //         });
// //       });
// //     });
// //   }

// //   getOtherValue() {
// //     setState(() {
// //       chatReference =
// //           db.collection('chats').doc(widget.chatID).collection('message');
// //       _timer = Timer.periodic(
// //           Duration(seconds: 5), (Timer timer) => checkedReadMsg());
// //     });
// //   }

// //   void initState() {
// //     getEndUser();
// //     // addUserToContact();
// //     getOtherValue();
// //     super.initState();
// //   }

// //   @override
// //   void dispose() {
// //     _timer.cancel();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final width = MediaQuery.of(context).size.width;
// //     final height = MediaQuery.of(context).size.height;
// //     return GetBuilder(
// //         init: authController,
// //         builder: (_) {
// //           return Scaffold(
// //             appBar: AppBar(
// //               backgroundColor: Colors.green.shade900,
// //               automaticallyImplyLeading: true,
// //               title: Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () {
// //                       Navigator.pushNamed(context, RoutePath.user_detail_page,
// //                           arguments: {'end_user': endUser!});
// //                     },
// //                     child: Container(
// //                       margin: const EdgeInsets.only(right: 10.0),
// //                       child: endUser?.avatar != null && endUser?.avatar != ''
// //                           ? CircleAvatar(
// //                               backgroundImage:
// //                                   new NetworkImage(endUser!.avatar),
// //                             )
// //                           : CircleAvatar(
// //                               backgroundColor: Colors.black12,
// //                               child: Text(
// //                                 endUser?.firstName[0] ??
// //                                     '' + (endUser?.lastName[0] ?? ''),
// //                                style: TextStyle(
// //                                     color: Colors.blue[800],
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 15),
// //                               ),
// //                             ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 160,
// //                     child: Text(
// //                       ((endUser?.firstName ?? '') +
// //                           ' ' +
// //                           (endUser?.lastName ?? '')),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   )
// //                 ],
// //               ),
// //               actions: [
// //                 GestureDetector(
// //                   onTap: () {
// //                     bool? isActiveSub = authController.user?.value.subscription
// //                         .any((element) => DateTime.fromMillisecondsSinceEpoch(
// //                                 element['expiry'])
// //                             .isAfter(DateTime.now()));
// //                     if (isActiveSub != true) {
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('please_subscribe_first'.tr)));
// //                     } else {
// //                       ChatController chatController =
// //                           Get.find(tag: ChatController().toString());
// //                       FirebaseFirestore.instance
// //                           .collection('calls')
// //                           .doc(FirebaseAuth.instance.currentUser!.uid)
// //                           .set({
// //                         "title": "call",
// //                         "channel_id": widget.chatID,
// //                         "receiver": widget.endUserID,
// //                         "channel_name": "testchannel3",
// //                         "caller_picture": authController.user!.value.avatar,
// //                         "caller_name": authController.user!.value.firstName,
// //                         "caller_uid": authController.user!.value.uid,
// //                         "call_type": "Audio",
// //                         "response": "Awaiting"
// //                       });
// //                       FirebaseFirestore.instance
// //                           .collection('calls')
// //                           .doc(widget.endUserID)
// //                           .set({
// //                         "title": "call",
// //                         "channel_id": widget.chatID,
// //                         "receiver": widget.endUserID,
// //                         "channel_name": "testchannel3",
// //                         "caller_picture": authController.user!.value.avatar,
// //                         "caller_name": authController.user!.value.firstName,
// //                         "caller_uid": authController.user!.value.uid,
// //                         "call_type": "Audio",
// //                         "response": "Awaiting"
// //                       });
// //                       if (chatController.endUser != null) {
// //                         Navigator.pushNamed(context, RoutePath.dial_call,
// //                             arguments: {
// //                               'call_type': 'Audio',
// //                               'channel_id': widget.chatID,
// //                               'receiver': chatController.endUser,
// //                               'receiver_id': chatController.endUser!.uid
// //                             });
// //                       }
// //                       // AppConstant().sendMessage(
// //                       //   receiverFcmToken: chatController.endUser!.fcmToken!,
// //                       //   title: "call",
// //                       //   msg: jsonEncode({
// //                       //     "title": "call",
// //                       //     "channel_id": widget.chatID,
// //                       //     "channel_name": "testchannel3",
// //                       //     "caller_picture": authController.user!.value.avatar,
// //                       //     "caller_name": authController.user!.value.firstName,
// //                       //     "caller_uid": authController.user!.value.uid,
// //                       //     "call_type": "Audio",
// //                       //   }),
// //                       // );
// //                       // if (chatController.endUser != null) {
// //                       //   Navigator.pushNamed(context, RoutePath.dial_call,
// //                       //       arguments: {
// //                       //         'call_type': 'Audio',
// //                       //         'channel_id': widget.chatID,
// //                       //         'receiver': chatController.endUser
// //                       //       });
// //                       // }
// //                     }
// //                   },
// //                   child: Icon(
// //                     Icons.call,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 20,
// //                 ),
// //                 GestureDetector(
// //                   onTap: () async {
// //                     bool? isActiveSub = authController.user?.value.subscription
// //                         .any((element) => DateTime.fromMillisecondsSinceEpoch(
// //                                 element['expiry'])
// //                             .isAfter(DateTime.now()));
// //                     if (isActiveSub != true) {
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('please_subscribe_first'.tr)));
// //                     } else {
// //                       ChatController chatController =
// //                           Get.find(tag: ChatController().toString());
// //                       // AppConstant().sendMessage(
// //                       //   receiverFcmToken: chatController.endUser!.fcmToken!,
// //                       //   title: "call",
// //                       //   msg: jsonEncode({
// //                       //     "title": "call",
// //                       //     "channel_id": widget.chatID,
// //                       //     "channel_name": "testchannel3",
// //                       //     "caller_picture": authController.user!.value.avatar,
// //                       //     "caller_name": authController.user!.value.firstName,
// //                       //     "caller_uid": authController.user!.value.uid,
// //                       //     "call_type": "Video",
// //                       //   }),
// //                       // );
// //                       // if (chatController.endUser != null) {
// //                       //   Navigator.push(
// //                       //       context,
// //                       //       MaterialPageRoute(
// //                       //         builder: (context) => DialCall(
// //                       //           callType: 'video'.tr,
// //                       //           channelId: widget.chatID,
// //                       //           receiver: chatController.endUser!,
// //                       //           receiverId: chatController.endUser!.uid!,
// //                       //         ),
// //                       //       ));
// //                       // }
// //                       FirebaseFirestore.instance
// //                           .collection('calls')
// //                           .doc(FirebaseAuth.instance.currentUser!.uid)
// //                           .set({
// //                         "title": "call",
// //                         "channel_id": widget.chatID,
// //                         "receiver": widget.endUserID,
// //                         "channel_name": "testchannel3",
// //                         "caller_picture": authController.user!.value.avatar,
// //                         "caller_name": authController.user!.value.firstName,
// //                         "caller_uid": authController.user!.value.uid,
// //                         "call_type": "Video",
// //                         "response": "Awaiting"
// //                       });
// //                       FirebaseFirestore.instance
// //                           .collection('calls')
// //                           .doc(widget.endUserID)
// //                           .set({
// //                         "title": "call",
// //                         "channel_id": widget.chatID,
// //                         "receiver": widget.endUserID,
// //                         "channel_name": "testchannel3",
// //                         "caller_picture": authController.user!.value.avatar,
// //                         "caller_name": authController.user!.value.firstName,
// //                         "caller_uid": authController.user!.value.uid,
// //                         "call_type": "Video",
// //                         "response": "Awaiting"
// //                       });
// //                       if (chatController.endUser != null) {
// //                         Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => DialCall(
// //                                 callType: 'video'.tr,
// //                                 channelId: widget.chatID,
// //                                 receiver: chatController.endUser!,
// //                                 receiverId: chatController.endUser!.uid!,
// //                               ),
// //                             ));
// //                       }
// //                     }
// //                   },
// //                   child: Icon(
// //                     Icons.video_call,
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 20,
// //                 )
// //               ],
// //             ),
// //             body: Container(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.max,
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: <Widget>[
// //                   StreamBuilder<QuerySnapshot>(
// //                       stream: chatReference
// //                           .orderBy('timestamp', descending: true)
// //                           .snapshots(),
// //                       builder: (BuildContext context,
// //                           AsyncSnapshot<QuerySnapshot> snapshot) {
// //                         if (!snapshot.hasData) {
// //                           return new Container(
// //                             height: height * 0.7,
// //                             alignment: Alignment.center,
// //                             child: CircularProgressIndicator(),
// //                           );
// //                         } else if (snapshot.data?.docs.length == 0) {
// //                           return Container(
// //                             alignment: Alignment.center,
// //                             child: Column(
// //                               children: [
// //                                 Text(
// //                                   'no_message'.tr,
// //                                  style: TextStyle(fontSize: 16),
// //                                 ),
// //                                 SizedBox(
// //                                   height: 20,
// //                                 )
// //                               ],
// //                             ),
// //                           );
// //                         } else {
// //                           return Expanded(
// //                             child: new ListView(
// //                               padding: EdgeInsets.all(10.0),
// //                               reverse: true,
// //                               children: generateMessages(snapshot, context),
// //                             ),
// //                           );
// //                         }
// //                       }),
// //                   new Divider(height: 1.0),
// //                   new Container(
// //                     alignment: Alignment.bottomCenter,
// //                     decoration:
// //                         new BoxDecoration(color: Theme.of(context).cardColor),
// //                     child: _buildTextComposer(),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         });
// //   }

// //   List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
// //     return <Widget>[
// //       new Expanded(
// //         child: new Column(
// //           crossAxisAlignment: CrossAxisAlignment.end,
// //           children: <Widget>[
// //             new Text(
// //               authController.timeStampToTime(documentSnapshot['timestamp']),
// //               style: new TextStyle(fontSize: 13.0, color: Colors.black45),
// //             ),
// //             new Container(
// //               child: documentSnapshot['imageURL'] != '' &&
// //                       documentSnapshot['imageURL'] == null
// //                   ? InkWell(
// //                       child: new Container(
// //                         height: 150,
// //                         width: 150,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.only(
// //                               topLeft: Radius.circular(10.0),
// //                               topRight: Radius.circular(10.0),
// //                               bottomLeft: Radius.circular(10.0)),
// //                           color: Colors.black,
// //                           image: new DecorationImage(
// //                             image: NetworkImage(documentSnapshot['imageURL']),
// //                             fit: BoxFit.fitHeight,
// //                           ),
// //                         ),
// //                       ),
// //                       onTap: () {
// //                         Navigator.pushNamed(
// //                             context, RoutePath.full_screen_image, arguments: {
// //                           'image_url': documentSnapshot['imageURL'],
// //                           'tag': 'You'
// //                         });
// //                       },
// //                     )
// //                   : new Container(
// //                       margin: const EdgeInsets.only(
// //                           top: 2.0, left: 80, bottom: 10.0),
// //                       padding: const EdgeInsets.all(10.0),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.only(
// //                             topLeft: Radius.circular(10.0),
// //                             topRight: Radius.circular(10.0),
// //                             bottomLeft: Radius.circular(10.0)),
// //                         color: Colors.cyan[100],
// //                       ),
// //                       child: Text(
// //                         documentSnapshot['text'],
// //                        style: TextStyle(fontSize: 15.0, color: Colors.black),
// //                       ),
// //                     ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ];
// //   }

// //   List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
// //     return <Widget>[
// //       new Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: <Widget>[
// //           new Container(
// //             margin: const EdgeInsets.only(right: 8.0),
// //             child: endUser?.avatar != null && endUser?.avatar != ''
// //                 ? CircleAvatar(
// //                     backgroundImage: new NetworkImage(endUser!.avatar),
// //                   )
// //                 : CircleAvatar(
// //                     backgroundColor: Colors.black12,
// //                     child: Text(
// //                       widget.endUserName[0] +
// //                           widget
// //                               .endUserName[widget.endUserName.indexOf(' ') + 1],
// //                      style: TextStyle(
// //                           color: Colors.blue[800],
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 15),
// //                     ),
// //                   ),
// //           ),
// //         ],
// //       ),
// //       new Expanded(
// //         child: new Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             new Text(
// //               widget.endUserName +
// //                   ',  ' +
// //                   authController.timeStampToTime(documentSnapshot['timestamp']),
// //               style: new TextStyle(fontSize: 13.0, color: Colors.black45),
// //             ),
// //             new Container(
// //               child: documentSnapshot['imageURL'] != ''
// //                   ? InkWell(
// //                       child: new Container(
// //                         height: 150,
// //                         width: 150,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.only(
// //                               topRight: Radius.circular(10.0),
// //                               bottomLeft: Radius.circular(10.0),
// //                               bottomRight: Radius.circular(10.0)),
// //                           color: Colors.black,
// //                           image: new DecorationImage(
// //                             image: NetworkImage(documentSnapshot['imageURL']),
// //                             fit: BoxFit.fitHeight,
// //                           ),
// //                         ),
// //                       ),
// //                       onTap: () {
// //                         Navigator.pushNamed(
// //                             context, RoutePath.full_screen_image, arguments: {
// //                           'image_url': documentSnapshot['imageURL'],
// //                           'tag': widget.endUserName
// //                         });
// //                       },
// //                     )
// //                   : new Container(
// //                       margin: const EdgeInsets.only(
// //                           top: 2.0, right: 50, bottom: 10.0),
// //                       padding: const EdgeInsets.all(10.0),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.only(
// //                             topRight: Radius.circular(10.0),
// //                             bottomRight: Radius.circular(10.0),
// //                             bottomLeft: Radius.circular(10.0)),
// //                         color: Colors.grey[300],
// //                       ),
// //                       child: Text(
// //                         documentSnapshot['text'],
// //                        style: TextStyle(
// //                           fontSize: 15.0,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                     ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ];
// //   }

// //   generateMessages(
// //       AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
// //     return snapshot.data?.docs
// //         .map<Widget>(
// //           (doc) => Container(
// //             margin: const EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0),
// //             width: MediaQuery.of(context).size.width * 0.6,
// //             child: new Row(
// //               children: doc['senderID'] != authController.user!.value.uid
// //                   ? generateReceiverLayout(doc)
// //                   : generateSenderLayout(doc),
// //             ),
// //           ),
// //         )
// //         .toList();
// //   }

// //   IconButton getDefaultSendButton() {
// //     return new IconButton(
// //       icon: new Icon(Icons.send),
// //       onPressed: _isWritting
// //           ? () {
// //               _updateChatRequestField((authController.user!.value.uid!),
// //                   _textController.text.trim());
// //               _updateChatRequestField(
// //                   widget.endUserID, _textController.text.trim());
// //               _sendText(_textController.text.trim());
// //             }
// //           : null,
// //     );
// //   }

// //   Widget _buildTextComposer() {
// //     return new IconTheme(
// //         data: new IconThemeData(
// //           color: _isWritting
// //               ? Theme.of(context).accentColor
// //               : Theme.of(context).disabledColor,
// //         ),
// //         child: new Container(
// //           margin: const EdgeInsets.symmetric(horizontal: 4.0),
// //           child: new Row(
// //             children: <Widget>[
// //               new Container(
// //                 margin: new EdgeInsets.symmetric(horizontal: 2.0),
// //                 child: new IconButton(
// //                     icon: new Icon(
// //                       Icons.photo_camera,
// //                       color: Theme.of(context).accentColor,
// //                     ),
// //                     onPressed: () async {
// //                       final pickedImage =
// //                           await _picker.pickImage(source: ImageSource.gallery);
// //                       if (pickedImage != null) {
// //                         File image = File(pickedImage.path);
// //                         int timestamp =
// //                             new DateTime.now().millisecondsSinceEpoch;
// //                         Reference storageReference = _firebaseStorage
// //                             .ref()
// //                             .child('chats/' +
// //                                 widget.chatID +
// //                                 '/img_' +
// //                                 timestamp.toString() +
// //                                 '.jpg');
// //                         UploadTask uploadTask = storageReference.putFile(image);

// //                         await uploadTask.whenComplete(() async {
// //                           try {
// //                             String fileUrl =
// //                                 await storageReference.getDownloadURL();
// //                             print(fileUrl);
// //                             _sendImage(messageText: '', imageUrl: fileUrl);
// //                           } catch (onError) {
// //                             print('Error');
// //                           }
// //                         });
// //                       }
// //                     }),
// //               ),
// //               new Flexible(
// //                 child: new Container(
// //                   padding:
// //                       EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
// //                   alignment: Alignment.center,
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[350],
// //                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
// //                   ),
// //                   child: new TextField(
// //                     controller: _textController,
// //                     onChanged: (String messageText) {
// //                       setState(() {
// //                         _isWritting = messageText.length > 0;
// //                       });
// //                     },
// //                     onSubmitted: _sendText,
// //                     maxLines: null,
// //                     decoration: new InputDecoration.collapsed(
// //                         hintText: "type_message".tr),
// //                    style: TextStyle(fontSize: 18),
// //                     onTap: () {
// //                       checkedReadMsg();
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               new Container(
// //                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
// //                 child: getDefaultSendButton(),
// //               ),
// //             ],
// //           ),
// //         ));
// //   }

// //   Future<Null> _sendText(String text) async {
// //     _textController.clear();
// //     chatReference.add({
// //       'text': text,
// //       'senderID': authController.user!.value.uid,
// //       'senderName': (authController.user!.value.firstName) +
// //           ' ' +
// //           (authController.user!.value.lastName),
// //       'imageURL': '',
// //       'isRead': false,
// //       'timestamp': Timestamp.now().millisecondsSinceEpoch,
// //     }).then((documentReference) {
// //       setState(() {
// //         _isWritting = false;
// //       });
// //     }).catchError((e) {});
// //   }

// //   void _sendImage({required String messageText, required String imageUrl}) {
// //     chatReference.add({
// //       'text': messageText,
// //       'senderID': authController.user!.value.uid,
// //       'senderName': (authController.user!.value.firstName) +
// //           ' ' +
// //           (authController.user!.value.lastName),
// //       'imageURL': imageUrl,
// //       'isRead': false,
// //       'timestamp': Timestamp.now().millisecondsSinceEpoch,
// //     });
// //   }

// //   Future<void> _updateChatRequestField(String documentID, String text) async {
// //     db
// //         .collection('users')
// //         .doc(documentID)
// //         .collection('messages')
// //         .doc(widget.chatID)
// //         .set({
// //       'chatID': widget.chatID,
// //       'withID': documentID == authController.user!.value.uid
// //           ? widget.endUserID
// //           : authController.user!.value.uid,
// //       'withName': documentID == authController.user!.value.uid
// //           ? widget.endUserName
// //           : (authController.user!.value.firstName) +
// //               ' ' +
// //               (authController.user!.value.lastName),
// //       'withAvatar': documentID == authController.user!.value.uid
// //           ? endUser?.avatar
// //           : authController.user!.value.avatar,
// //       'lastText': text,
// //       'timestamp': Timestamp.now().millisecondsSinceEpoch,
// //     });
// //   }
// // }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:link_up/get_controller/ChatController.dart';
// import 'package:link_up/get_controller/auth_controller.dart';
// import 'package:link_up/helper/app_constant.dart';
// import 'package:link_up/helper/router/route_path.dart';
// import 'package:link_up/model/user_model.dart';
// import 'package:link_up/ui/chat/calling/dial.dart';
// import 'package:link_up/ui/home_page.dart';

// import '../DrawerScreen.dart';

// class ChatMessagePage extends StatefulWidget {
//   final String endUserID;
//   final String endUserName;
//   final String chatID;

//   const ChatMessagePage(
//       {required this.endUserID,
//       required this.endUserName,
//       required this.chatID,
//       // this.endUser,
//       Key? key})
//       : super(key: key);
//   @override
//   _ChatMessagePageState createState() => _ChatMessagePageState();
// }

// class _ChatMessagePageState extends State<ChatMessagePage> {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   AuthController authController = Get.find(tag: AuthController().toString());
//   ChatController chatController = Get.find(tag: ChatController().toString());

//   FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//   late CollectionReference chatReference;
//   bool _isWritting = false;
//   TextEditingController _textController = new TextEditingController();
//   final _picker = ImagePicker();
//   late Timer _timer;
//   UserModel? endUser;

//   Future<void> checkedReadMsg() async {
//     db
//         .collection('chats')
//         .doc(widget.chatID)
//         .collection('message')
//         .where('senderID', isEqualTo: widget.endUserID)
//         .where('isRead', isEqualTo: false)
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         db
//             .collection('chats')
//             .doc(widget.chatID)
//             .collection('message')
//             .doc(doc.id)
//             .update({
//           'isRead': true,
//         });
//       });
//     });
//   }

//   Future<void> getEndUser() async {
//     var _res = await db.collection('users').doc(widget.endUserID).snapshots();
//     setState(() {
//       _res.listen((event) {
//         endUser = UserModel.fromJson(event.data()!);
//         WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//           chatController.updateEndUser(UserModel.fromJson(event.data()!));
//         });
//       });
//     });
//   }

//   getOtherValue() {
//     setState(() {
//       chatReference =
//           db.collection('chats').doc(widget.chatID).collection('message');
//       _timer = Timer.periodic(
//           Duration(seconds: 5), (Timer timer) => checkedReadMsg());
//     });
//   }

//   void initState() {
//     getEndUser();
//     // addUserToContact();
//     getOtherValue();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _scaffoldKey = GlobalKey<ScaffoldState>();
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return GetBuilder(
//         init: authController,

//         builder: (_) {
//           return Scaffold(
//             key: _scaffoldKey,
//             drawer: Drawer(
//         backgroundColor: Color(0XFF4E5B81),
//         child: DrawerScreen(),
//       ),
//             // appBar: AppBar(
//             //   backgroundColor: Colors.green.shade900,
//             //   automaticallyImplyLeading: true,
//             //   // title:
//             //   actions: [

//             //   ],
//             // ),
//             body: Stack(
//               children: [
//                 Image.asset("assets/image/Group 163959 (2).png"),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40,left: 10),
//                   child: InkWell(
//                     onTap: () {
//                      _scaffoldKey.currentState!.openDrawer();
//                     },
//                     child: Icon(Icons.menu,
//                     color: Colors.white,
//                     size: 30,)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 35,left: 70),
//                   child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, RoutePath.user_detail_page,
//                             arguments: {'end_user': endUser!});
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(right: 10.0),
//                         child: endUser?.avatar != null && endUser?.avatar != ''
//                             ? CircleAvatar(
//                                 backgroundImage:
//                                     new NetworkImage(endUser!.avatar),
//                               )
//                             : CircleAvatar(
//                                 backgroundColor: Colors.black12,
//                                 child: Text(
//                                   endUser?.firstName[0] ??
//                                       '' + (endUser?.lastName[0] ?? ''),
//                                  style: TextStyle(
//                                       color: Colors.blue[800],
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 130,
//                       child: Text(
//                         ((endUser?.firstName ?? '') +
//                             ' ' +
//                             (endUser?.lastName ?? '')),
//                         overflow: TextOverflow.ellipsis,
//                        style: TextStyle(color: Colors.white,fontSize: 17),
//                       ),
//                     )
//                   ],
//               ),
//                 ),
// Padding(
//   padding: const EdgeInsets.only(top: 40,left: 270),
//   child:   GestureDetector(
//                     onTap: () {
//                       bool? isActiveSub = authController.user?.value.subscription
//                           .any((element) => DateTime.fromMillisecondsSinceEpoch(
//                                   element['expiry'])
//                               .isAfter(DateTime.now()));
//                       if (isActiveSub != true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('please_subscribe_first'.tr)));
//                       } else {
//                         ChatController chatController =
//                             Get.find(tag: ChatController().toString());
//                         FirebaseFirestore.instance
//                             .collection('calls')
//                             .doc(FirebaseAuth.instance.currentUser!.uid)
//                             .set({
//                           "title": "call",
//                           "channel_id": widget.chatID,
//                           "receiver": widget.endUserID,
//                           "channel_name": "testchannel3",
//                           "caller_picture": authController.user!.value.avatar,
//                           "caller_name": authController.user!.value.firstName,
//                           "caller_uid": authController.user!.value.uid,
//                           "call_type": "Audio",
//                           "response": "Awaiting"
//                         });
//                         FirebaseFirestore.instance
//                             .collection('calls')
//                             .doc(widget.endUserID)
//                             .set({
//                           "title": "call",
//                           "channel_id": widget.chatID,
//                           "receiver": widget.endUserID,
//                           "channel_name": "testchannel3",
//                           "caller_picture": authController.user!.value.avatar,
//                           "caller_name": authController.user!.value.firstName,
//                           "caller_uid": authController.user!.value.uid,
//                           "call_type": "Audio",
//                           "response": "Awaiting"
//                         });
//                         if (chatController.endUser != null) {
//                           Navigator.pushNamed(context, RoutePath.dial_call,
//                               arguments: {
//                                 'call_type': 'Audio',
//                                 'channel_id': widget.chatID,
//                                 'receiver': chatController.endUser,
//                                 'receiver_id': chatController.endUser!.uid
//                               });
//                         }
//                         // AppConstant().sendMessage(
//                         //   receiverFcmToken: chatController.endUser!.fcmToken!,
//                         //   title: "call",
//                         //   msg: jsonEncode({
//                         //     "title": "call",
//                         //     "channel_id": widget.chatID,
//                         //     "channel_name": "testchannel3",
//                         //     "caller_picture": authController.user!.value.avatar,
//                         //     "caller_name": authController.user!.value.firstName,
//                         //     "caller_uid": authController.user!.value.uid,
//                         //     "call_type": "Audio",
//                         //   }),
//                         // );
//                         // if (chatController.endUser != null) {
//                         //   Navigator.pushNamed(context, RoutePath.dial_call,
//                         //       arguments: {
//                         //         'call_type': 'Audio',
//                         //         'channel_id': widget.chatID,
//                         //         'receiver': chatController.endUser
//                         //       });
//                         // }
//                       }
//                     },
//                     child: Icon(
//                       Icons.camera_alt_outlined,
//                       color: Colors.white,
//                     ),
//                   ),
// ),
//                 SizedBox(
//                   width: 20,
//                 ),
// Padding(
//   padding: const EdgeInsets.only(top: 40,left: 310),
//   child:   GestureDetector(
//                     onTap: () async {
//                       bool? isActiveSub = authController.user?.value.subscription
//                           .any((element) => DateTime.fromMillisecondsSinceEpoch(
//                                   element['expiry'])
//                               .isAfter(DateTime.now()));
//                       if (isActiveSub != true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('please_subscribe_first'.tr)));
//                       } else {
//                         ChatController chatController =
//                             Get.find(tag: ChatController().toString());
//                         // AppConstant().sendMessage(
//                         //   receiverFcmToken: chatController.endUser!.fcmToken!,
//                         //   title: "call",
//                         //   msg: jsonEncode({
//                         //     "title": "call",
//                         //     "channel_id": widget.chatID,
//                         //     "channel_name": "testchannel3",
//                         //     "caller_picture": authController.user!.value.avatar,
//                         //     "caller_name": authController.user!.value.firstName,
//                         //     "caller_uid": authController.user!.value.uid,
//                         //     "call_type": "Video",
//                         //   }),
//                         // );
//                         // if (chatController.endUser != null) {
//                         //   Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) => DialCall(
//                         //           callType: 'video'.tr,
//                         //           channelId: widget.chatID,
//                         //           receiver: chatController.endUser!,
//                         //           receiverId: chatController.endUser!.uid!,
//                         //         ),
//                         //       ));
//                         // }
//                         FirebaseFirestore.instance
//                             .collection('calls')
//                             .doc(FirebaseAuth.instance.currentUser!.uid)
//                             .set({
//                           "title": "call",
//                           "channel_id": widget.chatID,
//                           "receiver": widget.endUserID,
//                           "channel_name": "testchannel3",
//                           "caller_picture": authController.user!.value.avatar,
//                           "caller_name": authController.user!.value.firstName,
//                           "caller_uid": authController.user!.value.uid,
//                           "call_type": "Video",
//                           "response": "Awaiting"
//                         });
//                         FirebaseFirestore.instance
//                             .collection('calls')
//                             .doc(widget.endUserID)
//                             .set({
//                           "title": "call",
//                           "channel_id": widget.chatID,
//                           "receiver": widget.endUserID,
//                           "channel_name": "testchannel3",
//                           "caller_picture": authController.user!.value.avatar,
//                           "caller_name": authController.user!.value.firstName,
//                           "caller_uid": authController.user!.value.uid,
//                           "call_type": "Video",
//                           "response": "Awaiting"
//                         });
//                         if (chatController.endUser != null) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DialCall(
//                                   callType: 'video'.tr,
//                                   channelId: widget.chatID,
//                                   receiver: chatController.endUser!,
//                                   receiverId: chatController.endUser!.uid!,
//                                 ),
//                               ));
//                         }
//                       }
//                     },
//                     child: Icon(
//                       Icons.call_outlined,
//                       color: Colors.white,
//                     ),
//                   ),
// ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     StreamBuilder<QuerySnapshot>(
//                         stream: chatReference
//                             .orderBy('timestamp', descending: true)
//                             .snapshots(),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (!snapshot.hasData) {
//                             return new Container(
//                               height: height * 0.7,
//                               alignment: Alignment.center,
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (snapshot.data?.docs.length == 0) {
//                             return Container(
//                               alignment: Alignment.center,
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'no_message'.tr,
//                                    style: TextStyle(fontSize: 16),
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   )
//                                 ],
//                               ),
//                             );
//                           } else {
//                             return Expanded(
//                               child: new ListView(
//                                 padding: EdgeInsets.all(10.0),
//                                 reverse: true,
//                                 children: generateMessages(snapshot, context),
//                               ),
//                             );
//                           }
//                         }),
//                     new Divider(height: 1.0),
//                     new Container(
//                       alignment: Alignment.bottomCenter,
//                       decoration:
//                           new BoxDecoration(color: Theme.of(context).cardColor),
//                       child: _buildTextComposer(),
//                     ),
//                   ],
//                 ),
//               ),
//               ]
//             ),
//           );
//         });
//   }

//   List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
//     return <Widget>[
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             new Text(
//               authController.timeStampToTime(documentSnapshot['timestamp']),
//               style: new TextStyle(fontSize: 13.0, color: Colors.black45),
//             ),
//             new Container(
//               child: documentSnapshot['imageURL'] != '' &&
//                       documentSnapshot['imageURL'] == null
//                   ? InkWell(
//                       child: new Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10.0),
//                               topRight: Radius.circular(10.0),
//                               bottomLeft: Radius.circular(10.0)),
//                           color: Colors.black,
//                           image: new DecorationImage(
//                             image: NetworkImage(documentSnapshot['imageURL']),
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.pushNamed(
//                             context, RoutePath.full_screen_image, arguments: {
//                           'image_url': documentSnapshot['imageURL'],
//                           'tag': 'You'
//                         });
//                       },
//                     )
//                   : new Container(
//                       margin: const EdgeInsets.only(
//                           top: 2.0, left: 80, bottom: 10.0),
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10.0),
//                             topRight: Radius.circular(10.0),
//                             bottomLeft: Radius.circular(10.0)),
//                         color: Colors.cyan[100],
//                       ),
//                       child: Text(
//                         documentSnapshot['text'],
//                        style: TextStyle(fontSize: 15.0, color: Colors.black),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
//     return <Widget>[
//       new Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           new Container(
//             margin: const EdgeInsets.only(right: 8.0),
//             child: endUser?.avatar != null && endUser?.avatar != ''
//                 ? CircleAvatar(
//                     backgroundImage: new NetworkImage(endUser!.avatar),
//                   )
//                 : CircleAvatar(
//                     backgroundColor: Colors.black12,
//                     child: Text(
//                       widget.endUserName[0] +
//                           widget
//                               .endUserName[widget.endUserName.indexOf(' ') + 1],
//                      style: TextStyle(
//                           color: Colors.blue[800],
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Text(
//               widget.endUserName +
//                   ',  ' +
//                   authController.timeStampToTime(documentSnapshot['timestamp']),
//               style: new TextStyle(fontSize: 13.0, color: Colors.black45),
//             ),
//             new Container(
//               child: documentSnapshot['imageURL'] != ''
//                   ? InkWell(
//                       child: new Container(
//                         height: 150,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(10.0),
//                               bottomLeft: Radius.circular(10.0),
//                               bottomRight: Radius.circular(10.0)),
//                           color: Colors.black,
//                           image: new DecorationImage(
//                             image: NetworkImage(documentSnapshot['imageURL']),
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.pushNamed(
//                             context, RoutePath.full_screen_image, arguments: {
//                           'image_url': documentSnapshot['imageURL'],
//                           'tag': widget.endUserName
//                         });
//                       },
//                     )
//                   : new Container(
//                       margin: const EdgeInsets.only(
//                           top: 2.0, right: 50, bottom: 10.0),
//                       padding: const EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(10.0),
//                             bottomRight: Radius.circular(10.0),
//                             bottomLeft: Radius.circular(10.0)),
//                         color: Colors.grey[300],
//                       ),
//                       child: Text(
//                         documentSnapshot['text'],
//                        style: TextStyle(
//                           fontSize: 15.0,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   generateMessages(
//       AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
//     return snapshot.data?.docs
//         .map<Widget>(
//           (doc) => Container(
//             margin: const EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0),
//             width: MediaQuery.of(context).size.width * 0.6,
//             child: new Row(
//               children: doc['senderID'] != authController.user!.value.uid
//                   ? generateReceiverLayout(doc)
//                   : generateSenderLayout(doc),
//             ),
//           ),
//         )
//         .toList();
//   }

//   IconButton getDefaultSendButton() {
//     return new IconButton(
//       icon: new Icon(Icons.send),
//       onPressed: _isWritting
//           ? () {
//               _updateChatRequestField((authController.user!.value.uid!),
//                   _textController.text.trim());
//               _updateChatRequestField(
//                   widget.endUserID, _textController.text.trim());
//               _sendText(_textController.text.trim());
//             }
//           : null,
//     );
//   }

//   Widget _buildTextComposer() {
//     return new IconTheme(
//         data: new IconThemeData(
//           color: _isWritting
//               ? Theme.of(context).accentColor
//               : Theme.of(context).disabledColor,
//         ),
//         child: new Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//           child: new Row(
//             children: <Widget>[
//               new Container(
//                 margin: new EdgeInsets.symmetric(horizontal: 2.0),
//                 child: new IconButton(
//                     icon: new Icon(
//                       Icons.photo_camera,
//                       color: Theme.of(context).accentColor,
//                     ),
//                     onPressed: () async {
//                       final pickedImage =
//                           await _picker.pickImage(source: ImageSource.gallery);
//                       if (pickedImage != null) {
//                         File image = File(pickedImage.path);
//                         int timestamp =
//                             new DateTime.now().millisecondsSinceEpoch;
//                         Reference storageReference = _firebaseStorage
//                             .ref()
//                             .child('chats/' +
//                                 widget.chatID +
//                                 '/img_' +
//                                 timestamp.toString() +
//                                 '.jpg');
//                         UploadTask uploadTask = storageReference.putFile(image);

//                         await uploadTask.whenComplete(() async {
//                           try {
//                             String fileUrl =
//                                 await storageReference.getDownloadURL();
//                             print(fileUrl);
//                             _sendImage(messageText: '', imageUrl: fileUrl);
//                           } catch (onError) {
//                             print('Error');
//                           }
//                         });
//                       }
//                     }),
//               ),
//               new Flexible(
//                 child: new Container(
//                   padding:
//                       EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[350],
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   ),
//                   child: new TextField(
//                     controller: _textController,
//                     onChanged: (String messageText) {
//                       setState(() {
//                         _isWritting = messageText.length > 0;
//                       });
//                     },
//                     onSubmitted: _sendText,
//                     maxLines: null,
//                     decoration: new InputDecoration.collapsed(
//                         hintText: "type_message".tr),
//                    style: TextStyle(fontSize: 18),
//                     onTap: () {
//                       checkedReadMsg();
//                     },
//                   ),
//                 ),
//               ),
//               new Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: getDefaultSendButton(),
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<Null> _sendText(String text) async {
//     _textController.clear();
//     chatReference.add({
//       'text': text,
//       'senderID': authController.user!.value.uid,
//       'senderName': (authController.user!.value.firstName) +
//           ' ' +
//           (authController.user!.value.lastName),
//       'imageURL': '',
//       'isRead': false,
//       'timestamp': Timestamp.now().millisecondsSinceEpoch,
//     }).then((documentReference) {
//       setState(() {
//         _isWritting = false;
//       });
//     }).catchError((e) {});
//   }

//   void _sendImage({required String messageText, required String imageUrl}) {
//     chatReference.add({
//       'text': messageText,
//       'senderID': authController.user!.value.uid,
//       'senderName': (authController.user!.value.firstName) +
//           ' ' +
//           (authController.user!.value.lastName),
//       'imageURL': imageUrl,
//       'isRead': false,
//       'timestamp': Timestamp.now().millisecondsSinceEpoch,
//     });
//   }

//   Future<void> _updateChatRequestField(String documentID, String text) async {
//     db
//         .collection('users')
//         .doc(documentID)
//         .collection('messages')
//         .doc(widget.chatID)
//         .set({
//       'chatID': widget.chatID,
//       'withID': documentID == authController.user!.value.uid
//           ? widget.endUserID
//           : authController.user!.value.uid,
//       'withName': documentID == authController.user!.value.uid
//           ? widget.endUserName
//           : (authController.user!.value.firstName) +
//               ' ' +
//               (authController.user!.value.lastName),
//       'withAvatar': documentID == authController.user!.value.uid
//           ? endUser?.avatar
//           : authController.user!.value.avatar,
//       'lastText': text,
//       'timestamp': Timestamp.now().millisecondsSinceEpoch,
//     });
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/user_model.dart';
import 'package:link_up/ui/chat/calling/dial.dart';

class ChatMessagePage extends StatefulWidget {
  final String endUserID;
  final String endUserName;
  final String chatID;

  const ChatMessagePage(
      {required this.endUserID,
      required this.endUserName,
      required this.chatID,
      // this.endUser,
      Key? key})
      : super(key: key);
  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthController authController = Get.find(tag: AuthController().toString());
  ChatController chatController = Get.find(tag: ChatController().toString());

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late CollectionReference chatReference;
  bool _isWritting = false;
  TextEditingController _textController = new TextEditingController();
  final _picker = ImagePicker();
  late Timer _timer;
  UserModel? endUser;

  Future<void> checkedReadMsg() async {
    db
        .collection('chats')
        .doc(widget.chatID)
        .collection('message')
        .where('senderID', isEqualTo: widget.endUserID)
        .where('isRead', isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        db
            .collection('chats')
            .doc(widget.chatID)
            .collection('message')
            .doc(doc.id)
            .update({
          'isRead': true,
        });
      });
    });
  }

  Future<void> getEndUser() async {
    var _res = await db.collection('users').doc(widget.endUserID).snapshots();
    setState(() {
      _res.listen((event) {
        endUser = UserModel.fromJson(event.data()!);
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          chatController.updateEndUser(UserModel.fromJson(event.data()!));
        });
      });
    });
  }

  getOtherValue() {
    setState(() {
      chatReference =
          db.collection('chats').doc(widget.chatID).collection('message');
      _timer = Timer.periodic(
          Duration(seconds: 5), (Timer timer) => checkedReadMsg());
    });
  }

  void initState() {
    getEndUser();
    // addUserToContact();
    getOtherValue();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: authController,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 56, 171, 216),
              automaticallyImplyLeading: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePath.user_detail_page,
                          arguments: {'end_user': endUser!});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: endUser?.avatar != null && endUser?.avatar != ''
                          ? CircleAvatar(
                              backgroundImage:
                                  new NetworkImage(endUser!.avatar),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: Text(
                                endUser?.firstName[0] ??
                                    '' + (endUser?.lastName[0] ?? ''),
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: Text(
                      ((endUser?.firstName ?? '') +
                          ' ' +
                          (endUser?.lastName ?? '')),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    bool? isActiveSub = authController.user?.value.subscription
                        .any((element) => DateTime.fromMillisecondsSinceEpoch(
                                element['expiry'])
                            .isAfter(DateTime.now()));
                    if (isActiveSub != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please_subscribe_first'.tr)));
                    } else {
                      ChatController chatController =
                          Get.find(tag: ChatController().toString());
                      // AppConstant().sendMessage(
                      //   receiverFcmToken: chatController.endUser!.fcmToken!,
                      //   title: "call",
                      //   msg: jsonEncode({
                      //     "title": "call",
                      //     "channel_id": widget.chatID,
                      //     "channel_name": "testchannel3",
                      //     "caller_picture": authController.user!.value.avatar,
                      //     "caller_name": authController.user!.value.firstName,
                      //     "caller_uid": authController.user!.value.uid,
                      //     "call_type": "Video",
                      //   }),
                      // );
                      // if (chatController.endUser != null) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => DialCall(
                      //           callType: 'video'.tr,
                      //           channelId: widget.chatID,
                      //           receiver: chatController.endUser!,
                      //           receiverId: chatController.endUser!.uid!,
                      //         ),
                      //       ));
                      // }
                      FirebaseFirestore.instance
                          .collection('calls')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "title": "call",
                        "channel_id": widget.chatID,
                        "receiver": widget.endUserID,
                        "channel_name": "testchannel3",
                        "caller_picture": authController.user!.value.avatar,
                        "caller_name": authController.user!.value.firstName,
                        "caller_uid": authController.user!.value.uid,
                        "call_type": "Video",
                        "response": "Awaiting"
                      });
                      FirebaseFirestore.instance
                          .collection('calls')
                          .doc(widget.endUserID)
                          .set({
                        "title": "call",
                        "channel_id": widget.chatID,
                        "receiver": widget.endUserID,
                        "channel_name": "testchannel3",
                        "caller_picture": authController.user!.value.avatar,
                        "caller_name": authController.user!.value.firstName,
                        "caller_uid": authController.user!.value.uid,
                        "call_type": "Video",
                        "response": "Awaiting"
                      });
                      if (chatController.endUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DialCall(
                                callType: 'video'.tr,
                                channelId: widget.chatID,
                                receiver: chatController.endUser!,
                                receiverId: chatController.endUser!.uid!,
                              ),
                            ));
                      }
                    }
                  },
                  child: Icon(
                    Icons.video_call,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    bool? isActiveSub = authController.user?.value.subscription
                        .any((element) => DateTime.fromMillisecondsSinceEpoch(
                                element['expiry'])
                            .isAfter(DateTime.now()));
                    if (isActiveSub != true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please_subscribe_first'.tr)));
                    } else {
                      ChatController chatController =
                          Get.find(tag: ChatController().toString());
                      FirebaseFirestore.instance
                          .collection('calls')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "title": "call",
                        "channel_id": widget.chatID,
                        "receiver": widget.endUserID,
                        "channel_name": "testchannel3",
                        "caller_picture": authController.user!.value.avatar,
                        "caller_name": authController.user!.value.firstName,
                        "caller_uid": authController.user!.value.uid,
                        "call_type": "Audio",
                        "response": "Awaiting"
                      });
                      FirebaseFirestore.instance
                          .collection('calls')
                          .doc(widget.endUserID)
                          .set({
                        "title": "call",
                        "channel_id": widget.chatID,
                        "receiver": widget.endUserID,
                        "channel_name": "testchannel3",
                        "caller_picture": authController.user!.value.avatar,
                        "caller_name": authController.user!.value.firstName,
                        "caller_uid": authController.user!.value.uid,
                        "call_type": "Audio",
                        "response": "Awaiting"
                      });
                      if (chatController.endUser != null) {
                        Navigator.pushNamed(context, RoutePath.dial_call,
                            arguments: {
                              'call_type': 'Audio',
                              'channel_id': widget.chatID,
                              'receiver': chatController.endUser,
                              'receiver_id': chatController.endUser!.uid
                            });
                      }
                      // AppConstant().sendMessage(
                      //   receiverFcmToken: chatController.endUser!.fcmToken!,
                      //   title: "call",
                      //   msg: jsonEncode({
                      //     "title": "call",
                      //     "channel_id": widget.chatID,
                      //     "channel_name": "testchannel3",
                      //     "caller_picture": authController.user!.value.avatar,
                      //     "caller_name": authController.user!.value.firstName,
                      //     "caller_uid": authController.user!.value.uid,
                      //     "call_type": "Audio",
                      //   }),
                      // );
                      // if (chatController.endUser != null) {
                      //   Navigator.pushNamed(context, RoutePath.dial_call,
                      //       arguments: {
                      //         'call_type': 'Audio',
                      //         'channel_id': widget.chatID,
                      //         'receiver': chatController.endUser
                      //       });
                      // }
                    }
                  },
                  child: Icon(
                    Icons.call,
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: chatReference
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return new Container(
                            height: height * 0.7,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data?.docs.length == 0) {
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'no_message'.tr,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          );
                        } else {
                          return Expanded(
                            child: new ListView(
                              padding: EdgeInsets.all(10.0),
                              reverse: true,
                              children: generateMessages(snapshot, context),
                            ),
                          );
                        }
                      }),
                  new Divider(height: 1.0),
                  new Container(
                    alignment: Alignment.bottomCenter,
                    decoration:
                        new BoxDecoration(color: Theme.of(context).cardColor),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(
              authController.timeStampToTime(documentSnapshot['timestamp']),
              style: new TextStyle(fontSize: 13.0, color: Colors.black45),
            ),
            new Container(
              child: documentSnapshot['imageURL'] != '' &&
                      documentSnapshot['imageURL'] == null
                  ? InkWell(
                      child: new Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                          color: Colors.black,
                          image: new DecorationImage(
                            image: NetworkImage(documentSnapshot['imageURL']),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutePath.full_screen_image, arguments: {
                          'image_url': documentSnapshot['imageURL'],
                          'tag': 'You'
                        });
                      },
                    )
                  : new Container(
                      margin: const EdgeInsets.only(
                          top: 2.0, left: 80, bottom: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        color: Colors.cyan[100],
                      ),
                      child: Text(
                        documentSnapshot['text'],
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: endUser?.avatar != null && endUser?.avatar != ''
                ? CircleAvatar(
                    backgroundImage: new NetworkImage(endUser!.avatar),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: Text(
                      widget.endUserName[0] +
                          widget
                              .endUserName[widget.endUserName.indexOf(' ') + 1],
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
          ),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              widget.endUserName +
                  ',  ' +
                  authController.timeStampToTime(documentSnapshot['timestamp']),
              style: new TextStyle(fontSize: 13.0, color: Colors.black45),
            ),
            new Container(
              child: documentSnapshot['imageURL'] != ''
                  ? InkWell(
                      child: new Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Colors.black,
                          image: new DecorationImage(
                            image: NetworkImage(documentSnapshot['imageURL']),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutePath.full_screen_image, arguments: {
                          'image_url': documentSnapshot['imageURL'],
                          'tag': widget.endUserName
                        });
                      },
                    )
                  : new Container(
                      margin: const EdgeInsets.only(
                          top: 2.0, right: 50, bottom: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                        color: Colors.grey[300],
                      ),
                      child: Text(
                        documentSnapshot['text'],
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    ];
  }

  generateMessages(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data?.docs
        .map<Widget>(
          (doc) => Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0, right: 20.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: new Row(
              children: doc['senderID'] != authController.user!.value.uid
                  ? generateReceiverLayout(doc)
                  : generateSenderLayout(doc),
            ),
          ),
        )
        .toList();
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isWritting
          ? () {
              _updateChatRequestField((authController.user!.value.uid!),
                  _textController.text.trim());
              _updateChatRequestField(
                  widget.endUserID, _textController.text.trim());
              _sendText(_textController.text.trim());
            }
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isWritting
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 2.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {
                      final pickedImage =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        File image = File(pickedImage.path);
                        int timestamp =
                            new DateTime.now().millisecondsSinceEpoch;
                        Reference storageReference = _firebaseStorage
                            .ref()
                            .child('chats/' +
                                widget.chatID +
                                '/img_' +
                                timestamp.toString() +
                                '.jpg');
                        UploadTask uploadTask = storageReference.putFile(image);

                        await uploadTask.whenComplete(() async {
                          try {
                            String fileUrl =
                                await storageReference.getDownloadURL();
                            print(fileUrl);
                            _sendImage(messageText: '', imageUrl: fileUrl);
                          } catch (onError) {
                            print('Error');
                          }
                        });
                      }
                    }),
              ),
              new Flexible(
                child: new Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: new TextField(
                    controller: _textController,
                    onChanged: (String messageText) {
                      setState(() {
                        _isWritting = messageText.length > 0;
                      });
                    },
                    onSubmitted: _sendText,
                    maxLines: null,
                    decoration: new InputDecoration.collapsed(
                        hintText: "type_message".tr),
                    style: TextStyle(fontSize: 18),
                    onTap: () {
                      checkedReadMsg();
                    },
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _sendText(String text) async {
    _textController.clear();
    chatReference.add({
      'text': text,
      'senderID': authController.user!.value.uid,
      'senderName': (authController.user!.value.firstName) +
          ' ' +
          (authController.user!.value.lastName),
      'imageURL': '',
      'isRead': false,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    }).then((documentReference) {
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});
  }

  void _sendImage({required String messageText, required String imageUrl}) {
    chatReference.add({
      'text': messageText,
      'senderID': authController.user!.value.uid,
      'senderName': (authController.user!.value.firstName) +
          ' ' +
          (authController.user!.value.lastName),
      'imageURL': imageUrl,
      'isRead': false,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    });
  }

  Future<void> _updateChatRequestField(String documentID, String text) async {
    db
        .collection('users')
        .doc(documentID)
        .collection('messages')
        .doc(widget.chatID)
        .set({
      'chatID': widget.chatID,
      'withID': documentID == authController.user!.value.uid
          ? widget.endUserID
          : authController.user!.value.uid,
      'withName': documentID == authController.user!.value.uid
          ? widget.endUserName
          : (authController.user!.value.firstName) +
              ' ' +
              (authController.user!.value.lastName),
      'withAvatar': documentID == authController.user!.value.uid
          ? endUser?.avatar
          : authController.user!.value.avatar,
      'lastText': text,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    });
  }
}
