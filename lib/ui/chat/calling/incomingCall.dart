// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:get/get.dart';
// import 'package:link_up/ui/chat/calling/call.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Incoming extends StatefulWidget {
//   final callInfo;
//   Incoming(this.callInfo);

//   @override
//   _IncomingState createState() => _IncomingState();
// }

// class _IncomingState extends State<Incoming> with TickerProviderStateMixin {
//   CollectionReference callRef = FirebaseFirestore.instance.collection("calls");

//   bool ispickup = false;
//   AnimationController? _controller;
//   bool receivedCall = false;
//   @override
//   void initState() {
//     super.initState();
//     FlutterRingtonePlayer.play(
//       android: AndroidSounds.ringtone,
//       ios: IosSounds.glass,
//       looping: true, // Android only - API >= 28
//       volume: 1, // Android only - API >= 28
//       asAlarm: false, // Android only - all APIs
//     );
//     _controller = AnimationController(
//       vsync: this,
//       lowerBound: 0.5,
//       duration: Duration(seconds: 3),
//     )..repeat();
//   }

//   @override
//   void dispose() async {
//     _controller?.dispose();
//     FlutterRingtonePlayer.stop();
//     ispickup = true;
//     super.dispose();
//     await callRef.doc(widget.callInfo['channel_id']).update({'calling': false});
//   }

//   Future<void> handleCameraAndMic(callType) async {
//     await Permission.camera.request();
//     await Permission.microphone.request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: StreamBuilder<QuerySnapshot>(
//             stream: callRef
//                 .where("channel_id",
//                     isEqualTo: "${widget.callInfo['channel_id']}")
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (receivedCall == true &&
//                   (snapshot.data?.docs.length ?? 0) == 0) {
//                 WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//                   Navigator.pop(context);
//                 });
//               }
//               if (snapshot.hasData && (snapshot.data?.docs.length ?? 0) > 0) {
//                 if (!snapshot.hasData) {
//                   Container();
//                 } else if (snapshot.data?.docs[0]['calling']) {
//                   WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
//                     if (receivedCall != true) {
//                       setState(() {
//                         receivedCall = true;
//                       });
//                     }
//                   });
//                   switch (snapshot.data?.docs[0]['response']) {
//                     case "Awaiting":
//                       {
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               snapshot.data?.docs[0]['call_type'] == "Video"
//                                   ? "Incoming video call"
//                                   : "Incoming audio call",
//                              style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.bold),
//                             ),
//                             AnimatedBuilder(
//                                 animation: CurvedAnimation(
//                                     parent: _controller!,
//                                     curve: Curves.slowMiddle),
//                                 builder: (context, child) {
//                                   return Container(
//                                     height:
//                                         MediaQuery.of(context).size.height * .3,
//                                     child: Stack(
//                                       alignment: Alignment.center,
//                                       children: <Widget>[
//                                         _buildContainer(
//                                             150 * _controller!.value),
//                                         _buildContainer(
//                                             200 * _controller!.value),
//                                         _buildContainer(
//                                             250 * _controller!.value),
//                                         _buildContainer(
//                                             300 * _controller!.value),
//                                         Container(
//                                           height: 100,
//                                           width: 100,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(50),
//                                             image: DecorationImage(
//                                               fit: BoxFit.cover,
//                                               image: NetworkImage(
//                                                   widget.callInfo[
//                                                           'caller_picture'] ??
//                                                       ''),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   "${widget.callInfo['caller_name']} ",
//                                  style: TextStyle(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   "just_calling_you".tr,
//                                  style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   FloatingActionButton(
//                                       heroTag: UniqueKey(),
//                                       backgroundColor: Colors.green,
//                                       child: Icon(
//                                         snapshot.data?.docs[0]['call_type'] ==
//                                                 "Video"
//                                             ? Icons.video_call
//                                             : Icons.call,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () async {
//                                         await handleCameraAndMic(snapshot
//                                             .data?.docs[0]['call_type']);
//                                         ispickup = true;
//                                         await callRef
//                                             .doc(widget.callInfo['channel_id'])
//                                             .update({'response': "Pickup"});
//                                         await FlutterRingtonePlayer.stop();
//                                       }),
//                                   FloatingActionButton(
//                                       heroTag: UniqueKey(),
//                                       backgroundColor: Colors.red,
//                                       child: Icon(Icons.clear,
//                                           color: Colors.white),
//                                       onPressed: () async {
//                                         await FlutterRingtonePlayer.stop();
//                                         await callRef
//                                             .doc(widget.callInfo['channel_id'])
//                                             .update({'response': 'Decline'});
//                                       })
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                     case "Pickup":
//                       {
//                         return CallPage(
//                           channelId: widget.callInfo['channel_id'],
//                           role: ClientRole.Broadcaster,
//                           callType: widget.callInfo['call_type'],
//                         );
//                       }
//                     default:
//                       {
//                         Future.delayed(Duration(milliseconds: 500), () {
//                           Navigator.pop(context);
//                         });
//                         return Container(
//                           child: Text("call_ended".tr),
//                         );
//                       }
//                   }
//                 }
//               }

//               return Container(
//                 child: Text("connecting".tr),
//               );
//             }),
//       ),
//     );
//   }

//   Widget _buildContainer(double radius) {
//     return Container(
//       width: radius,
//       height: radius,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.blue.withOpacity(1 - _controller!.value),
//       ),
//     );
//   }
// }

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/chat/calling/call.dart';
import 'package:link_up/ui/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class Incoming extends StatefulWidget {
  final callInfo;
  Incoming(this.callInfo);

  @override
  _IncomingState createState() => _IncomingState();
}

class _IncomingState extends State<Incoming> with TickerProviderStateMixin {
  CollectionReference callRef = FirebaseFirestore.instance.collection("calls");

  bool ispickup = false;
  AnimationController? _controller;
  bool receivedCall = false;
  @override
  void initState() {
    super.initState();
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() async {
    _controller?.dispose();
    FlutterRingtonePlayer.stop();
    ispickup = true;
    super.dispose();
    await callRef.doc(widget.callInfo['channel_id']).update({'calling': false});
  }

  Future<void> handleCameraAndMic(callType) async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Object?>>(
            stream:
                callRef.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                Container();
              } else if (snapshot.data?['receiver'] ==
                  FirebaseAuth.instance.currentUser!.uid) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (receivedCall != true) {
                    setState(() {
                      receivedCall = true;
                    });
                  }
                });
                switch (snapshot.data?['response']) {
                  case "Awaiting":
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            snapshot.data?['call_type'] == "Video"
                                ? "Incoming video call"
                                : "Incoming audio call",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          AnimatedBuilder(
                              animation: CurvedAnimation(
                                  parent: _controller!,
                                  curve: Curves.slowMiddle),
                              builder: (context, child) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      _buildContainer(150 * _controller!.value),
                                      _buildContainer(200 * _controller!.value),
                                      _buildContainer(250 * _controller!.value),
                                      _buildContainer(300 * _controller!.value),
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(widget.callInfo[
                                                    'caller_picture'] ??
                                                ''),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${widget.callInfo['caller_name']} ",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "just_calling_you".tr,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FloatingActionButton(
                                    heroTag: UniqueKey(),
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      snapshot.data?['call_type'] == "Video"
                                          ? Icons.video_call
                                          : Icons.call,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      await handleCameraAndMic(
                                          snapshot.data?['call_type']);
                                      ispickup = true;
                                      await callRef
                                          .doc(widget.callInfo['channel_id'])
                                          .update({'response': "Pickup"});
                                      await FlutterRingtonePlayer.stop();
                                    }),
                                FloatingActionButton(
                                    heroTag: UniqueKey(),
                                    backgroundColor: Colors.red,
                                    child:
                                        Icon(Icons.clear, color: Colors.white),
                                    onPressed: () async {
                                      await FlutterRingtonePlayer.stop();
                                      await callRef
                                          .doc(widget.callInfo['channel_id'])
                                          .update({'response': 'Decline'});
                                      await callRef
                                          .doc(widget.callInfo['caller_uid'])
                                          .update({'response': 'Decline'});
                                    })
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  case "Pickup":
                    {
                      return CallPage(
                        channelId: widget.callInfo['channel_id'],
                        role: ClientRole.Broadcaster,
                        callType: widget.callInfo['call_type'],
                      );
                    }
                  default:
                    {
                      Future.delayed(Duration(milliseconds: 500), () {
                        Get.offAll(() => HomePage());
                        // Navigator.pop(context);
                      });
                      return Container(
                        child: Text("call_ended".tr),
                      );
                    }
                }
              }
              return Container(
                child: Text("connecting".tr),
              );
            }),
      ),
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(1 - _controller!.value),
      ),
    );
  }
}
