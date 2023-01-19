// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:link_up/get_controller/ChatController.dart';
// import 'package:link_up/get_controller/auth_controller.dart';
// import 'package:link_up/helper/router/route_path.dart';
// import 'package:link_up/model/recent_chat.dart';
// import 'package:link_up/model/user_model.dart';
// import '../DrawerScreen.dart';

// class ChatHomePage extends StatefulWidget {
//   @override
//   _ChatHomePageState createState() => _ChatHomePageState();
// }

// class _ChatHomePageState extends State<ChatHomePage> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   AuthController authController = Get.find(tag: AuthController().toString());
//   ChatController chatController = Get.find(tag: ChatController().toString());

//   @override
//   void initState() {
//     chatController.getMatchList();
//     chatController.getMessageList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushNamed(context, RoutePath.home_screen);
//         return false;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         // appBar: AppBar(
//         //   backgroundColor: Colors.green.shade900,
//         //   title: Text("chat_now".tr),
//         // ),
//         drawer: Drawer(
//           // backgroundColor: Colors.green.shade900,
//           child: DrawerScreen(),
//         ),
//         body: ListView(
//           children: [
//             Container(
//               height: 120,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/Group 163959.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       _scaffoldKey.currentState!.openDrawer();
//                     },
//                     icon: Icon(Icons.menu),
//                     color: Colors.white,
//                     iconSize: 35,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                     child: Text(
//                       "chat_now".tr,
//                      style: TextStyle(color: Colors.white, fontSize: 26),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             GetBuilder(
//                 init: chatController,
//                 builder: (_) {
//                   return Container(
//                     width: width,
//                     height: height,
//                     child: new Column(
//                       children: <Widget>[
//                         if (chatController.matchList.isNotEmpty)
//                           Container(
//                             margin: EdgeInsets.only(
//                                 left: 10,
//                                 top: height * 0.02,
//                                 bottom: height * 0.03),
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'new_matches'.tr,
//                              style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                         if (chatController.matchList.isNotEmpty)
//                           new Container(
//                             height: 100,
//                             child: ListView.builder(
//                               itemCount: chatController.matchList.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 UserModel _endUser = UserModel.fromJson(
//                                     chatController.matchList[index]);
//                                 return GestureDetector(
//                                   onTap: () {
//                                     chatController.updateEndUser(_endUser);
//                                     String chatID = chatController
//                                         .matchList[index]['chat_id'];
//                                     Navigator.pushNamed(
//                                         context, RoutePath.chat_message_page,
//                                         arguments: {
//                                           'end_user_id': _endUser.uid,
//                                           'end_user_name': _endUser.firstName,
//                                           'chat_id': chatID
//                                         });
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 5),
//                                     child: Column(
//                                       children: [
//                                         if (_endUser.avatar != '')
//                                           CircleAvatar(
//                                             radius: 40,
//                                             backgroundImage: new NetworkImage(
//                                               _endUser.avatar,
//                                             ),
//                                             backgroundColor: Colors.grey,
//                                           ),
//                                         if (_endUser.avatar == '')
//                                           CircleAvatar(
//                                             radius: 40,
//                                             backgroundColor: Colors.grey,
//                                             child: Text(
//                                               _endUser.firstName[0]
//                                                   .toUpperCase(),
//                                             ),
//                                           ),
//                                         Text(
//                                           _endUser.firstName,
//                                          style: TextStyle(
//                                             fontSize:
//                                                 (_endUser.firstName).length < 10
//                                                     ? 16
//                                                     : ((_endUser.firstName)
//                                                                 .length <
//                                                             15)
//                                                         ? 14
//                                                         : 12,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         SizedBox(
//                           height: height * 0.03,
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 20),
//                           height: height / 6,
//                           width: width / 1.5,
//                           // color: Colors.amber,
//                           child: Column(
//                             children: [
//                               Text(
//                                 "New Matches",
//                                style: TextStyle(
//                                     color: Color(0xff38ABD8),
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Image.asset(
//                                 'assets/photos.png',
//                                 width: 300,
//                                 fit: BoxFit.cover,
//                               ),
//                               SizedBox(
//                                 height: 0,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Jane",
//                                    style: TextStyle(color: Colors.grey),
//                                   ),
//                                   Text(
//                                     "Amber",
//                                    style: TextStyle(color: Colors.grey),
//                                   ),
//                                   Text(
//                                     "Jane",
//                                    style: TextStyle(color: Colors.grey),
//                                   ),
//                                   Text(
//                                     "Amber",
//                                    style: TextStyle(color: Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                               // SizedBox(
//                               //   height: 30,
//                               // ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                           child: Divider(
//                             color: Color(0xff38ABD8),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           // padding: EdgeInsets.only(left: 10),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Message",
//                             // 'messages'.tr,
//                            style: TextStyle(
//                                 color: Color(0xff38ABD8),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 24.0),
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                         SizedBox(
//                           height: height * 0.02,
//                         ),
//                         PhysicalModel(
//                           color: Colors.white,
//                           elevation: 1,
//                           shadowColor: Colors.grey,
//                           child: ListTile(
//                             leading: CircleAvatar(
//                                 backgroundColor: Color(0xff38ABD8)),
//                             title: Text("Vida Stuart"),
//                             subtitle: Text("How are you"),
//                             trailing: Text(
//                               "Yesterday",
//                              style: TextStyle(color: Colors.grey),
//                             ),
//                             tileColor: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         PhysicalModel(
//                           color: Colors.white,
//                           elevation: 1,
//                           shadowColor: Colors.grey,
//                           child: ListTile(
//                             leading: CircleAvatar(
//                                 backgroundColor: Color(0xff38ABD8)),
//                             title: Text("Elene Rolle"),
//                             subtitle: Text("hu"),
//                             trailing: Text(
//                               "Yesterday",
//                              style: TextStyle(color: Colors.grey),
//                             ),
//                             tileColor: Colors.white,
//                           ),
//                         ),
//                     //     if (chatController.recentChatList.length == 0)
//                     //       Container(
//                     //         alignment: Alignment.center,
//                     //         child: Center(
//                     //           child: Text(
//                     //             "  ",
//                     //             // 'there_is_no_message'.tr,
//                     //            style: TextStyle(fontSize: 16),
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     Expanded(
//                     //       child: Column(
//                     //         mainAxisSize: MainAxisSize.max,
//                     //         mainAxisAlignment: MainAxisAlignment.start,
//                     //         children: <Widget>[
//                     //           Expanded(
//                     //             child: new ListView.builder(
//                     //                 itemCount:
//                     //                     chatController.recentChatList.length,
//                     //                 itemBuilder: (context, index) {
//                     //                   RecentChatModel _recentChatModel =
//                     //                       RecentChatModel.fromJson(
//                     //                           chatController
//                     //                                   .recentChatList[index]
//                     //                               as Map<String, dynamic>);
//                     //                   return Slidable(
//                     //                     key: const ValueKey(0),
//                     //                     startActionPane: ActionPane(
//                     //                       motion: const ScrollMotion(),
//                     //                       dismissible: DismissiblePane(
//                     //                           onDismissed: () {}),
//                     //                       dragDismissible: false,
//                     //                       children: [
//                     //                         SlidableAction(
//                     //                           onPressed: (context) async {
//                     //                             FirebaseFirestore.instance
//                     //                                 .collection('chats')
//                     //                                 .doc(
//                     //                                     _recentChatModel.chatId)
//                     //                                 .collection('message')
//                     //                                 .get()
//                     //                                 .then((value) {
//                     //                               value.docs.forEach((element) {
//                     //                                 FirebaseFirestore.instance
//                     //                                     .collection('chats')
//                     //                                     .doc(_recentChatModel
//                     //                                         .chatId)
//                     //                                     .collection('message')
//                     //                                     .doc(element.id)
//                     //                                     .delete();
//                     //                               });
//                     //                             });
//                     //                             FirebaseFirestore.instance
//                     //                                 .collection('users')
//                     //                                 .doc(authController
//                     //                                     .user?.value.uid)
//                     //                                 .collection('messages')
//                     //                                 .doc(
//                     //                                     _recentChatModel.chatId)
//                     //                                 .delete();
//                     //                             ScaffoldMessenger.of(context)
//                     //                                 .showSnackBar(
//                     //                               SnackBar(
//                     //                                 content: Text('delete'.tr),
//                     //                               ),
//                     //                             );
//                     //                           },
//                     //                           backgroundColor: Colors.red,
//                     //                           foregroundColor: Colors.white,
//                     //                           icon: Icons.delete,
//                     //                           label: 'Delete',
//                     //                         ),
//                     //                         SlidableAction(
//                     //                           onPressed: (context) {
//                     //                             FirebaseFirestore.instance
//                     //                                 .collection('chats')
//                     //                                 .doc(
//                     //                                     _recentChatModel.chatId)
//                     //                                 .collection('message')
//                     //                                 .get()
//                     //                                 .then((value) {
//                     //                               value.docs.forEach((element) {
//                     //                                 FirebaseFirestore.instance
//                     //                                     .collection('chats')
//                     //                                     .doc(_recentChatModel
//                     //                                         .chatId)
//                     //                                     .collection('message')
//                     //                                     .doc(element.id)
//                     //                                     .delete();
//                     //                               });
//                     //                             });
//                     //                             FirebaseFirestore.instance
//                     //                                 .collection('users')
//                     //                                 .doc(authController
//                     //                                     .user?.value.uid)
//                     //                                 .collection('messages')
//                     //                                 .doc(
//                     //                                     _recentChatModel.chatId)
//                     //                                 .delete();
//                     //                             ScaffoldMessenger.of(context)
//                     //                                 .showSnackBar(
//                     //                               SnackBar(
//                     //                                 content: Text('delete'.tr),
//                     //                               ),
//                     //                             );
//                     //                             FirebaseFirestore.instance
//                     //                                 .collection('matches')
//                     //                                 .doc(authController
//                     //                                     .user?.value.uid)
//                     //                                 .collection('matches')
//                     //                                 .doc(
//                     //                                     _recentChatModel.chatId)
//                     //                                 .update({
//                     //                               'friend': false,
//                     //                               'me': false,
//                     //                               'matchingStatus': false,
//                     //                             });

//                     //                             ScaffoldMessenger.of(context)
//                     //                                 .showSnackBar(
//                     //                               SnackBar(
//                     //                                 content:
//                     //                                     Text('un_match'.tr),
//                     //                               ),
//                     //                             );
//                     //                           },
//                     //                           backgroundColor: Colors.blue,
//                     //                           foregroundColor: Colors.white,
//                     //                           icon: Icons.refresh,
//                     //                           label: 'un_match'.tr,
//                     //                         ),
//                     //                       ],
//                     //                     ),
//                     //                     child: new Container(
//                     //                       decoration: BoxDecoration(
//                     //                           border: Border(
//                     //                               bottom: BorderSide(
//                     //                                   color: Colors.black26,
//                     //                                   width: 0.5))),
//                     //                       child: ListTile(
//                     //                         leading: _recentChatModel
//                     //                                 .withAvatar.isNotEmpty
//                     //                             ? Container(
//                     //                                 width: 50,
//                     //                                 height: 50,
//                     //                                 decoration: BoxDecoration(
//                     //                                   shape: BoxShape.circle,
//                     //                                   color: Colors.black12,
//                     //                                   image:
//                     //                                       new DecorationImage(
//                     //                                     fit: BoxFit.fill,
//                     //                                     image: NetworkImage(
//                     //                                         _recentChatModel
//                     //                                             .withAvatar),
//                     //                                   ),
//                     //                                 ),
//                     //                               )
//                     //                             : Container(
//                     //                                 width: 50,
//                     //                                 height: 50,
//                     //                                 alignment: Alignment.center,
//                     //                                 decoration: BoxDecoration(
//                     //                                   shape: BoxShape.circle,
//                     //                                   color: Colors.black12,
//                     //                                 ),
//                     //                                 child: Text(
//                     //                                   _recentChatModel
//                     //                                       .withName[0]
//                     //                                       .toUpperCase(),
//                     //                                  style: TextStyle(
//                     //                                       color:
//                     //                                           Colors.blue[700],
//                     //                                       fontSize: 16,
//                     //                                       fontWeight:
//                     //                                           FontWeight.bold),
//                     //                                 ),
//                     //                               ),
//                     //                         title: Text(
//                     //                           _recentChatModel.withName,
//                     //                          style: TextStyle(
//                     //                               color: Colors.black),
//                     //                         ),
//                     //                         subtitle: Text(
//                     //                           _recentChatModel.lastText.length <
//                     //                                   30
//                     //                               ? _recentChatModel.lastText
//                     //                               : _recentChatModel.lastText
//                     //                                       .substring(0, 30) +
//                     //                                   ' ...',
//                     //                         ),
//                     //                         trailing:
//                     //                             StreamBuilder<QuerySnapshot>(
//                     //                           stream: FirebaseFirestore.instance
//                     //                               .collection('chats')
//                     //                               .doc(_recentChatModel.chatId)
//                     //                               .collection('message')
//                     //                               .where('senderID',
//                     //                                   isEqualTo:
//                     //                                       _recentChatModel
//                     //                                           .withId)
//                     //                               .where('isRead',
//                     //                                   isEqualTo: false)
//                     //                               .snapshots(),
//                     //                           builder:
//                     //                               (context, unReadSnapshot) {
//                     //                             return Column(
//                     //                               mainAxisAlignment:
//                     //                                   MainAxisAlignment.start,
//                     //                               children: <Widget>[
//                     //                                 SizedBox(
//                     //                                   height: 5.0,
//                     //                                 ),
//                     //                                 Text(
//                     //                                   authController
//                     //                                       .timeStampToDateTime(
//                     //                                           _recentChatModel
//                     //                                               .timestamp),
//                     //                                  style: TextStyle(
//                     //                                       color:
//                     //                                           Colors.black54),
//                     //                                 ),
//                     //                                 SizedBox(
//                     //                                   height: 5.0,
//                     //                                 ),
//                     //                                 unReadSnapshot.hasData &&
//                     //                                         (unReadSnapshot
//                     //                                                     .data
//                     //                                                     ?.docs
//                     //                                                     .length ??
//                     //                                                 0) >
//                     //                                             0
//                     //                                     ? Container(
//                     //                                         alignment: Alignment
//                     //                                             .center,
//                     //                                         width: 20.0,
//                     //                                         height: 20.0,
//                     //                                         decoration:
//                     //                                             BoxDecoration(
//                     //                                           shape: BoxShape
//                     //                                               .circle,
//                     //                                           color: Colors
//                     //                                               .blue[700],
//                     //                                         ),
//                     //                                         child: Text(
//                     //                                           unReadSnapshot
//                     //                                               .data!
//                     //                                               .docs
//                     //                                               .length
//                     //                                               .toString(),
//                     //                                          style: TextStyle(
//                     //                                             color: Colors
//                     //                                                 .white,
//                     //                                           ),
//                     //                                         ),
//                     //                                       )
//                     //                                     : SizedBox(
//                     //                                         height: 0,
//                     //                                       ),
//                     //                               ],
//                     //                             );
//                     //                           },
//                     //                         ),
//                     //                         isThreeLine: false,
//                     //                         onTap: () {
//                     //                           Navigator.pushNamed(context,
//                     //                               RoutePath.chat_message_page,
//                     //                               arguments: {
//                     //                                 'end_user_id':
//                     //                                     _recentChatModel.withId,
//                     //                                 'end_user_name':
//                     //                                     _recentChatModel
//                     //                                         .withName,
//                     //                                 'chat_id':
//                     //                                     _recentChatModel.chatId
//                     //                               });
//                     //                         },
//                     //                       ),
//                     //                     ),
//                     //                   );
//                     //                 }),
//                     //           )
//                     //         ],
//                     //       ),
//                     //     ),
//                       ],
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/user_model.dart';
import 'package:link_up/ui/home_page.dart';

class LikesMePage extends StatefulWidget {
  @override
  _LikesMePageState createState() => _LikesMePageState();
}

class _LikesMePageState extends State<LikesMePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthController authController = Get.find(tag: AuthController().toString());
  ChatController chatController = Get.find(tag: ChatController().toString());

  @override
  void initState() {
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
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Color.fromARGB(255, 56, 171, 216),
        //   title: Text('who_likes_me'.tr),

        // ),
        body: Stack(children: [
          Image.asset("assets/image/Group 163959 (2).png"),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: InkWell(
              onTap: () {
                Get.to(HomePage());
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 130),
            child: Text(
              "Who likes me",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: GetBuilder(
                init: authController,
                builder: (_) {
                  return Container(
                    width: width,
                    height: height,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: db
                              .collection('matches')
                              .doc(authController.user!.value.uid)
                              .collection('matches')
                              .where('me', isEqualTo: false)
                              .where('friend', isEqualTo: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapShot) {
                            if (!snapShot.hasData) {
                              return new Container(
                                height: height * 0.5,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapShot.data?.docs.length == 0) {
                              return Container(
                                height: height * 0.8,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    'there_is_no_someone'.tr,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: new GridView.builder(
                                  itemCount: snapShot.data?.docs.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                          childAspectRatio: 0.75),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Container(
                                      child: StreamBuilder(
                                        stream: db
                                            .collection('users')
                                            .doc(snapShot.data?.docs[index]
                                                ['friendId'])
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                friendSnapShot) {
                                          if (!friendSnapShot.hasData)
                                            return new Container(
                                              alignment: Alignment.center,
                                              child: Text('no_user'.tr),
                                            );
                                          return GestureDetector(
                                            onTap: () {
                                              UserModel _endUsr = UserModel
                                                  .fromJson(friendSnapShot.data!
                                                          .data()
                                                      as Map<String, dynamic>);
                                              Navigator.pushNamed(context,
                                                  RoutePath.user_detail_page,
                                                  arguments: {
                                                    'end_user': _endUsr
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black54
                                                    ],
                                                    begin: Alignment.center,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          friendSnapShot
                                                              .data?['avatar']),
                                                      fit: BoxFit.fill)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, bottom: 16),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                    friendSnapShot.data?[
                                                                            'first_name'] +
                                                                        ' ' +
                                                                        friendSnapShot
                                                                                .data?[
                                                                            'last_name'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w700)),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 5,
                                                      right: 5,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // String chatID = makeChatId(userId, friendSnapShot.data.id);
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(builder: (context) => ChatMessagePage(
                                                          //     selectedUserID: friendSnapShot.data.id, selectedUserName: friendSnapShot.data.data()['firstname'] + ' ' + friendSnapShot.data.data()['lastname'],
                                                          //     chatID: chatID,
                                                          //   )),
                                                          // );
                                                          chatController
                                                              .matchesLike(
                                                                  context,
                                                                  friendSnapShot
                                                                      .data!.id,
                                                                  friendSnapShot
                                                                          .data?[
                                                                      'avatar']);
                                                        },
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                spreadRadius: 7,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Icon(
                                                            Icons.chat,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
