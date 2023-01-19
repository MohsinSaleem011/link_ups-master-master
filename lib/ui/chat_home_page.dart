import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/recent_chat.dart';
import 'package:link_up/model/user_model.dart';

import 'DrawerScreen.dart';

class ChatHomePage extends StatefulWidget {
  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  AuthController authController = Get.find(tag: AuthController().toString());
  ChatController chatController = Get.find(tag: ChatController().toString());

  @override
  void initState() {
    chatController.getMatchList();
    chatController.getMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, RoutePath.home_screen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text("chat_now".tr),
        ),
        drawer: Drawer(
          backgroundColor: Colors.green.shade900,
          child: DrawerScreen(),
        ),
        body: GetBuilder(
            init: chatController,
            builder: (_) {
              return Container(
                width: width,
                height: height,
                child: new Column(
                  children: <Widget>[
                    if (chatController.matchList.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(
                            left: 10,
                            top: height * 0.02,
                            bottom: height * 0.03),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'new_matches'.tr,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    if (chatController.matchList.isNotEmpty)
                      new Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: chatController.matchList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            UserModel _endUser = UserModel.fromJson(
                                chatController.matchList[index]);
                            return GestureDetector(
                              onTap: () {
                                chatController.updateEndUser(_endUser);

                                String chatID =
                                    chatController.matchList[index]['chat_id'];
                                Navigator.pushNamed(
                                    context, RoutePath.chat_message_page,
                                    arguments: {
                                      'end_user_id': _endUser.uid,
                                      'end_user_name': _endUser.firstName,
                                      'chat_id': chatID
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    if (_endUser.avatar != '')
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: new NetworkImage(
                                          _endUser.avatar,
                                        ),
                                        backgroundColor: Colors.grey,
                                      ),
                                    if (_endUser.avatar == '')
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey,
                                        child: Text(
                                          _endUser.firstName[0].toUpperCase(),
                                        ),
                                      ),
                                    Text(
                                      _endUser.firstName,
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: (_endUser.firstName).length <
                                                10
                                            ? 16
                                            : ((_endUser.firstName).length < 15)
                                                ? 14
                                                : 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'messages'.tr,
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    if (chatController.recentChatList.length == 0)
                      Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            'there_is_no_message'.tr,
                            style:
                                TextStyle(fontFamily: "OpenSans", fontSize: 16),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: new ListView.builder(
                                itemCount: chatController.recentChatList.length,
                                itemBuilder: (context, index) {
                                  RecentChatModel _recentChatModel =
                                      RecentChatModel.fromJson(
                                          chatController.recentChatList[index]
                                              as Map<String, dynamic>);
                                  return Slidable(
                                    key: const ValueKey(0),
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {}),
                                      dragDismissible: false,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) async {
                                            FirebaseFirestore.instance
                                                .collection('chats')
                                                .doc(_recentChatModel.chatId)
                                                .collection('message')
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection('chats')
                                                    .doc(
                                                        _recentChatModel.chatId)
                                                    .collection('message')
                                                    .doc(element.id)
                                                    .delete();
                                              });
                                            });
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(authController
                                                    .user?.value.uid)
                                                .collection('messages')
                                                .doc(_recentChatModel.chatId)
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('delete'.tr),
                                              ),
                                            );
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            FirebaseFirestore.instance
                                                .collection('chats')
                                                .doc(_recentChatModel.chatId)
                                                .collection('message')
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection('chats')
                                                    .doc(
                                                        _recentChatModel.chatId)
                                                    .collection('message')
                                                    .doc(element.id)
                                                    .delete();
                                              });
                                            });
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(authController
                                                    .user?.value.uid)
                                                .collection('messages')
                                                .doc(_recentChatModel.chatId)
                                                .delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('delete'.tr),
                                              ),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('matches')
                                                .doc(authController
                                                    .user?.value.uid)
                                                .collection('matches')
                                                .doc(_recentChatModel.chatId)
                                                .update({
                                              'friend': false,
                                              'me': false,
                                              'matchingStatus': false,
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('un_match'.tr),
                                              ),
                                            );
                                          },
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          icon: Icons.refresh,
                                          label: 'un_match'.tr,
                                        ),
                                      ],
                                    ),
                                    child: new Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black26,
                                                  width: 0.5))),
                                      child: ListTile(
                                        leading: _recentChatModel
                                                .withAvatar.isNotEmpty
                                            ? Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black12,
                                                  image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        _recentChatModel
                                                            .withAvatar),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 50,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black12,
                                                ),
                                                child: Text(
                                                  _recentChatModel.withName[0]
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans",
                                                      color: Colors.blue[700],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                        title: Text(
                                          _recentChatModel.withName,
                                          style: TextStyle(
                                              fontFamily: "OpenSans",
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          _recentChatModel.lastText.length < 30
                                              ? _recentChatModel.lastText
                                              : _recentChatModel.lastText
                                                      .substring(0, 30) +
                                                  ' ...',
                                        ),
                                        trailing: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('chats')
                                              .doc(_recentChatModel.chatId)
                                              .collection('message')
                                              .where('senderID',
                                                  isEqualTo:
                                                      _recentChatModel.withId)
                                              .where('isRead', isEqualTo: false)
                                              .snapshots(),
                                          builder: (context, unReadSnapshot) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  authController
                                                      .timeStampToDateTime(
                                                          _recentChatModel
                                                              .timestamp),
                                                  style: TextStyle(
                                                      fontFamily: "OpenSans",
                                                      color: Colors.black54),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                unReadSnapshot.hasData &&
                                                        (unReadSnapshot
                                                                    .data
                                                                    ?.docs
                                                                    .length ??
                                                                0) >
                                                            0
                                                    ? Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Colors.blue[700],
                                                        ),
                                                        child: Text(
                                                          unReadSnapshot
                                                              .data!.docs.length
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                              ],
                                            );
                                          },
                                        ),
                                        isThreeLine: false,
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RoutePath.chat_message_page,
                                              arguments: {
                                                'end_user_id':
                                                    _recentChatModel.withId,
                                                'end_user_name':
                                                    _recentChatModel.withName,
                                                'chat_id':
                                                    _recentChatModel.chatId
                                              });
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
