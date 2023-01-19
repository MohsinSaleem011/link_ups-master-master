import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/user_model.dart';

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
        //   backgroundColor: Colors.green.shade900,
        //   title: Text('who_likes_me'.tr),
        // ),
        body: ListView(children: [
          Stack(children: [
            Image.asset("assets/image/Group 163959 (2).png"),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 110),
              child: Text(
                "who_likes_me".tr,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ]),
          GetBuilder(
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
                                  style: TextStyle(
                                      fontFamily: "OpenSans", fontSize: 16),
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
                                itemBuilder: (BuildContext context, int index) {
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
                                                borderRadius: BorderRadius.all(
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
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 120,
                                                              child: Text(
                                                                  friendSnapShot
                                                                              .data?[
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
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
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
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 7,
                                                              blurRadius: 7,
                                                              offset: Offset(0,
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
        ]),
      ),
    );
  }
}
