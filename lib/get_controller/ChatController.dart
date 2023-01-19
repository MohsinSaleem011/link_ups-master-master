import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/get_controller/base_controller.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/choice_model.dart';
import 'package:link_up/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatController extends BaseController {
  AuthController authController = Get.find(tag: AuthController().toString());
  FirebaseFirestore db = FirebaseFirestore.instance;

  // List<ContactModel> contactsList = [];
  UserModel? endUser;

  List<Choice> choices = const <Choice>[
    const Choice(name: 'Wi-Fi', icon: Icons.wifi),
    const Choice(name: 'Bluetooth', icon: Icons.bluetooth),
    const Choice(name: 'Battery', icon: Icons.battery_alert),
    const Choice(name: 'Storage', icon: Icons.storage),
  ];

  List matchList = [];
  List recentChatList = [];

  Future<void> getMatchList() async {
    FirebaseFirestore.instance
        .collection('matches')
        .doc(authController.user?.value.uid)
        .collection('matches')
        .where('me', isEqualTo: true)
        .where('friend', isEqualTo: true)
        .snapshots()
        .listen((event) async {
      matchList.clear();
      try {
        for (var match in event.docs) {
          var d = await FirebaseFirestore.instance
              .collection('users')
              .doc(match.data()['friendId'])
              .get();
          Map<String, dynamic> _u = d.data()!;
          _u.addAll({"chat_id": match.id});
          matchList.add(_u);
          update();
        }
      } catch (e) {
        print(e);
      }
      update();
    });
  }

  Future<void> getMessageList() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(authController.user?.value.uid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((event) {
      recentChatList.clear();
      for (var rChat in event.docs) {
        recentChatList.add(rChat.data());
      }
      update();
    });
  }

  void updateEndUser(UserModel user) {
    endUser = user;
    update();
  }

  // Future<void> contactsData() async {
  //   contactsList.clear();
  //   int index = 0;

  //   new Timer(const Duration(seconds: 5), () async {
  //     SharedPreferences pref = await SharedPreferences.getInstance();
  //     var _userid = pref.getString('user_id');
  //     String usrID = _userid ?? '';
  //     FirebaseFirestore.instance
  //         .collection('matches')
  //         .doc(usrID)
  //         .collection('matches')
  //         .where('me', isEqualTo: true)
  //         .where('friend', isEqualTo: true)
  //         .get()
  //         .then((result) {
  //       result.docs.forEach((doc) {
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(doc.data()['friendId'])
  //             .get()
  //             .then((value) {
  //           contactsList.insert(
  //             index,
  //             ContactModel(
  //               contactId: doc.data()['friendId'],
  //               name: value.data()?['firstname'] +
  //                   ' ' +
  //                   value.data()?['lastname'],
  //               avatar: value.data()?['avatar'],
  //             ),
  //           );
  //           index++;
  //         });
  //       });
  //     });
  //   });
  // }

  String makeChatId(myID, selectedUserID) {
    String chatID;
    if (myID.hashCode > selectedUserID.hashCode) {
      chatID = '$selectedUserID-$myID';
    } else {
      chatID = '$myID-$selectedUserID';
    }
    return chatID;
  }

  matchesDislike(BuildContext context, String friendId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';
    String userId = usrID;
    String matchID = makeChatId(userId, friendId);
    await FirebaseFirestore.instance
        .collection('matches')
        .doc(userId)
        .collection('matches')
        .doc(matchID)
        .get()
        .then((value) {
      // db.collection('swipes').doc(userId).update({
      //   'seen': FieldValue.arrayUnion([friendId])
      // });
      if (value.exists) {
        FirebaseFirestore.instance
            .collection('matches')
            .doc(userId)
            .collection('matches')
            .doc(matchID)
            .update({
          'friendId': friendId,
          'me': false,
          'matchingStatus': false,
        });
        FirebaseFirestore.instance
            .collection('matches')
            .doc(friendId)
            .collection('matches')
            .doc(matchID)
            .update({
          'friendId': userId,
          'friend': false,
          'matchID': matchID,
          'matchingStatus': false,
        });
      } else {
        FirebaseFirestore.instance
            .collection('matches')
            .doc(friendId)
            .collection('matches')
            .doc(matchID)
            .get()
            .then((val) {
          if (val.exists) {
            FirebaseFirestore.instance
                .collection('matches')
                .doc(userId)
                .collection('matches')
                .doc(matchID)
                .update({
              'friendId': friendId,
              'me': false,
              'matchID': matchID,
              'matchingStatus': false,
            });
            FirebaseFirestore.instance
                .collection('matches')
                .doc(friendId)
                .collection('matches')
                .doc(matchID)
                .update({
              'friendId': userId,
              'friend': false,
              'matchID': matchID,
              'matchingStatus': false,
            });
          } else {
            FirebaseFirestore.instance
                .collection('matches')
                .doc(userId)
                .collection('matches')
                .doc(matchID)
                .set({
              'friendId': friendId,
              'me': false,
              'friend': false,
              'matchID': matchID,
              'matchingStatus': false,
            });
            FirebaseFirestore.instance
                .collection('matches')
                .doc(friendId)
                .collection('matches')
                .doc(matchID)
                .set({
              'friendId': userId,
              'friend': false,
              'me': false,
              'matchID': matchID,
              'matchingStatus': false,
            });
          }
        });
      }
    });
  }

  // matchesDialog(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;
  //   double height = MediaQuery.of(context).size.height;
  //   showDialog(
  //     // barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Scaffold(
  //         backgroundColor: Colors.transparent,
  //         body: Container(
  //           width: width,
  //           height: height,
  //           decoration: BoxDecoration(
  //               image: new DecorationImage(
  //                   image: AssetImage('assets/profile/a.jpg'),
  //                   fit: BoxFit.fill)),
  //           child: Column(
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.only(left: 30, top: 40),
  //                         alignment: Alignment.centerLeft,
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: Container(
  //                             width: 30,
  //                             height: 30,
  //                             decoration: BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(30)),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                   color: Colors.grey.withOpacity(0.3),
  //                                   spreadRadius: 7,
  //                                   blurRadius: 7,
  //                                   offset: Offset(
  //                                       0, 3), // changes position of shadow
  //                                 ),
  //                               ],
  //                             ),
  //                             child: Icon(Icons.clear),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: height * 0.3,
  //                       ),
  //                       Text(
  //                         'Bingo!',
  //                        style: TextStyle(
  //                             color: Colors.tealAccent[400],
  //                             fontSize: 100,
  //                             fontWeight: FontWeight.bold,
  //                             fontStyle: FontStyle.italic),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Text(
  //                         "You've got a Match!",
  //                        style: TextStyle(
  //                             color: Colors.tealAccent[400],
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  addSeenToDb({required String userId, required String friendId}) {
    db
        .collection('swipes')
        .doc(userId)
        .collection('seen_by_date')
        .add({"date": AppConstant().getTodaysDate(), "swipe_id": friendId});
  }

  matchesLike(
      BuildContext context, String friendId, String friendAvatar) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';
    String userId = usrID;
    String matchID = makeChatId(userId, friendId);

    await db
        .collection('matches')
        .doc(userId)
        .collection('matches')
        .doc(matchID)
        .get()
        .then((value) {
      // db.collection('swipes').doc(userId).update({
      //   'seen': FieldValue.arrayUnion([friendId])
      // });
      if (value.exists) {
        db
            .collection('matches')
            .doc(userId)
            .collection('matches')
            .doc(matchID)
            .update({
          'friendId': friendId,
          'me': true,
          'matchID': matchID,
          'timestamp': Timestamp.now().millisecondsSinceEpoch,
        });
        db
            .collection('matches')
            .doc(friendId)
            .collection('matches')
            .doc(matchID)
            .update({
          'friendId': userId,
          'matchID': matchID,
          'friend': true,
        });
      } else {
        db
            .collection('matches')
            .doc(friendId)
            .collection('matches')
            .doc(matchID)
            .get()
            .then((val) {
          if (val.exists) {
            db
                .collection('matches')
                .doc(userId)
                .collection('matches')
                .doc(matchID)
                .update({
              'friendId': friendId,
              'me': true,
              'matchID': matchID,
              'timestamp': Timestamp.now().millisecondsSinceEpoch,
            });
            db
                .collection('matches')
                .doc(friendId)
                .collection('matches')
                .doc(matchID)
                .update({
              'friendId': userId,
              'matchID': matchID,
              'friend': true,
            });
          } else {
            db
                .collection('matches')
                .doc(userId)
                .collection('matches')
                .doc(matchID)
                .set({
              'friendId': friendId,
              'me': true,
              'friend': false,
              'matchID': matchID,
              'timestamp': Timestamp.now().millisecondsSinceEpoch,
            });
            db
                .collection('matches')
                .doc(friendId)
                .collection('matches')
                .doc(matchID)
                .set({
              'friendId': userId,
              'friend': true,
              'matchID': matchID,
              'me': false,
            });
          }
        });
      }
    });

    db
        .collection('matches')
        .doc(userId)
        .collection('matches')
        .doc(matchID)
        .get()
        .then((result) {
      if (result.data() != null &&
          result.data()?['me'] == true &&
          result.data()?['friend'] == true) {
        if (result.data()?['matchingStatus'] == null ||
            result.data()?['matchingStatus'] == false) {
          db
              .collection('matches')
              .doc(userId)
              .collection('matches')
              .doc(matchID)
              .update({
            'matchingStatus': true,
            'matchingTime': Timestamp.now().millisecondsSinceEpoch,
          });
          db
              .collection('matches')
              .doc(friendId)
              .collection('matches')
              .doc(matchID)
              .update({
            'matchingStatus': true,
            'matchingTime': Timestamp.now().millisecondsSinceEpoch,
          });

          // matchesDialog(context);
          Navigator.pushNamed(context, RoutePath.matching_page,
              arguments: {'friend_id': friendId, 'avatar': friendAvatar});
        }
      }
    });
  }

  Future<void> sendGotMatchEmail(String to, String text, String subject) async {
    var response = await http.post(
        Uri.parse(
            'https://us-central1-linkup-cfa21.cloudfunctions.net/sendMail'),
        body: {
          "to": to,
          "subject": subject,
          "text": text,
        });
  }
}
