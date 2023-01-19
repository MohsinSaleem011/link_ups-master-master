// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_field, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, sized_box_for_whitespace
// ignore_for_file: unused_import, library_prefixes, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, prefer_const_constructors, unused_element, prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:link_up/livestreaming/live_Stream_chat.dart';
import 'package:link_up/livestreaming/live_streaming_yt.dart';
// import 'package:meet_people/appModules/Live_Stream/Views/live_streaming_yt.dart';

// import 'live_Stream_chat.dart';

class LiveStreaming extends StatefulWidget {
  bool admin;
  String channelName;

  String token;
  LiveStreaming(
      {Key? key,
      required this.admin,
      required this.channelName,
      this.token = ''})
      : super(key: key);
  @override
  _LiveStreamingState createState() => _LiveStreamingState();
}

class _LiveStreamingState extends State<LiveStreaming> {
  // late final RtcEngine _engine;
  String channelId = 'test';
  bool isJoined = false;
  bool switchCamera = true;
  TextEditingController? _channelIdController;
  late TextEditingController _rtmpUrlController;
  bool _isStreaming = false;
  int _remoteUid = 0;
  String appId = '3f0cb77c9fc149a8bfb97a23dfde8f55';
  bool _enterStreaming=false;

  bool _joined = false;
  // int _remoteUid = 0;
  bool _switch = false;
  String APP_ID = '3f0cb77c9fc149a8bfb97a23dfde8f55';
  // final playerController = Get.put(AddplayerController());

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    // getTokenFromServer();
    // initPlatformState();
    print('token =============');
    print(widget.token);
    // startOnYoutube();
    // getToken();
    // liveController.createLiveStream(widget.channelName, widget.token);
    // widget.admin == false ? null : liveController.updateStreamStatus('ongoing');
    // matchController.getMatchDetails('1');
    // AutoOrientation.landscapeLeftMode();
    super.initState();
  }

  // final liveController = Get.put(LiveStreamController());
  // final playmodeController = Get.put(PlaymodeController());

  List<int> users = [];
  String clubName = '';
  // final liveController = Get.put(LiveStreamController());

  // Future<void> initPlatformState() async {
  //   await [Permission.camera, Permission.microphone].request();
  //   RtcEngineContext context = RtcEngineContext(APP_ID);
  //   // AgoraRtmClient client = await AgoraRtmClient.createInstance(APP_ID);
  //   var engine = await RtcEngine.createWithContext(context);
  //   await engine.enableAudio();
  //   await engine.enableVideo();
  //   //  engine.enableLocalAudio(true);
  //   //   engine.enableLocalVideo(true);

  //   await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  //   await engine.setClientRole(
  //       widget.admin == true ? ClientRole.Broadcaster : ClientRole.Audience);
  //   await engine.joinChannel(widget.token, channel, 'Pickleball streaming', 0);

  //   engine.setEventHandler(RtcEngineEventHandler(
  //       joinChannelSuccess: (String channel, int uid, int elapsed) {
  //     print('joinChannelSuccess ${channel} ${uid}');
  //     users.add(uid);
  //   // startOnYoutube();
  //     setState(() {
  //       _joined = true;
  //     });
  //   }, userJoined: (int uid, int elapsed) {
  //     print('userJoined ${uid}');
  //     setState(() {
  //       _remoteUid = uid;
  //     });
  //   }, userOffline: (int uid, UserOfflineReason reason) {
  //     print('userOffline ${uid}');
  //     setState(() {
  //       _remoteUid = 0;
  //     });
  //   }));

  //   print('token passwd ${widget.token}');

  //   await engine.switchCamera();
  //   List<TranscodingUser> transcodingUsers = [];
  //   // EncryptionConfig config =EncryptionConfig();
  //   // await engine.disableVideo();
  //   // await engine.enableEncryption(true, config);
  //   transcodingUsers.add(TranscodingUser(1));
  //   LiveTranscoding transcoding = LiveTranscoding(transcodingUsers);
  //   await engine.setLiveTranscoding(transcoding);
  //   // await engine.createDataStream(true, true);
  //   // DataStreamConfig confi = DataStreamConfig(true, true);
  //   // await engine.createDataStreamWithConfig(confi);
  // }

  // int uid = 0;

  // startOnYoutube() async {
  //   await [Permission.camera, Permission.microphone].request();
  //   RtcEngineContext context = RtcEngineContext(APP_ID);
  //   var engine = await RtcEngine.createWithContext(context);
  //   try {
  //     //rtmp://youtube.com/app/mczh-gatd-ab4j-t4ch-3x99
  //     // engine.startPreview();

  //     // engine.stopPreview();
  //     await engine.addPublishStreamUrl(
  //         widget.youtube == true
  //             ? '$youtubeUrl$youtubeKey'
  //             : '$twitchUrl$twitchkey',
  //         true);
  //     // VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
  //     // configuration.dimensions = VideoDimensions(height: 640, width: 720);
  //     // LiveInjectStreamConfig config = LiveInjectStreamConfig();
  //     // await engine.addInjectStreamUrl(
  //     //     widget.youtube == true
  //     //         ? '$youtubeUrl$youtubeKey'
  //     //         : '$twitchUrl$twitchkey',
  //     //     config);

  //   } catch (e) {
  //     print(
  //         '========================================================================');
  //     print(e.toString());
  //     print(
  //         '========================================================================');
  //   }
  // }

  // bool switchCamera = true;

  // void _switchCamera() async {
  //   RtcEngineContext context = RtcEngineContext(APP_ID);
  //   var engine = await RtcEngine.createWithContext(context);
  //   engine.switchCamera().then((value) {
  //     setState(() {
  //       switchCamera = !switchCamera;
  //     });
  //   }).catchError((err) {
  //     debugPrint('switchCamera $err');
  //   });
  // }

  // closeStreaming() async {
  //   RtcEngineContext context = RtcEngineContext(APP_ID);
  //   var engine = await RtcEngine.createWithContext(context);
  //
  //   engine.removePublishStreamUrl('$youtubeUrl$youtubeKey');
  //   engine.removePublishStreamUrl('$twitchUrl$twitchkey');
  //   print('stream removed');
  //   await engine.destroy();
  // }

  @override
  void dispose() {
    // widget.admin == false ? null : liveController.updateStreamStatus('end');
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    // AutoOrientation.portraitUpMode();
    // widget.admin == false
    //     ?
    // AutoOrientation.portraitUpMode();
    // :
    // SystemChrome.setPreferredOrientations([
    //         DeviceOrientation.landscapeRight,
    //         DeviceOrientation.landscapeLeft,
    //       ]);
    super.dispose();
  }

  int matchNo = 0;
  // final matchController = Get.put(MyMatchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Appcolors.primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [


            Center(
                child: RtmpStreaming(

                  channel: widget.channelName,
                  token: widget.token,
                  admin: widget.admin,
                )
              // widget.admin == false
              //     ? _renderRemoteVideo()
              //     : _renderLocalPreview(),
            ),
            _enterStreaming? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LiveStreamChat(channel: channelId,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LiveChatMenuButtons(path: 'assets/heart.png'),
                    LiveChatMenuButtons(path: 'assets/live-streaming.png'),
                    LiveChatMenuButtons(path: 'assets/versus.png'),
                    LiveChatMenuButtons(path: 'assets/letter-u.png'),
                    LiveChatMenuButtons(path: 'assets/magic-wand.png'),
                    LiveChatMenuButtons(path: 'assets/add.png'),

                  ],
                ),
              ],
            ):Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8,8,50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.block_outlined,color: Color(0xFF9A9A9A)),
                      SizedBox(width: 10,),
                      Expanded(child: Text('Do not stream nudity or obscene/voilent behaviour Never stream while driving or under unsafe conditions',style: GoogleFonts.openSans(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),)),

                    ],
                  ),
                  Column(

                    children: [
                      Stack(
                        alignment: Alignment.center,

                        children: [
                          Container(

                            margin: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            height: Get.height*0.15,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child:    Text('Notify your fans with a blast from the favourite menu!',style: GoogleFonts.openSans(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),

                          ),
                          Positioned(
                            top: -5,

                            child: Container(
                              padding: EdgeInsets.all(8),




                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  shape: BoxShape.circle
                              ),
                              child: Icon(Icons.star,size: 40,color: Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: Get.height*0.07,
                        width: Get.height*0.7,
                        child: TextFormField(

                          decoration: InputDecoration(
                            filled: true,
                            focusColor: Colors.white,
                            fillColor: Colors.white,
                            hintText: 'Add description or tag to your livestream',

                            hintStyle: TextStyle(),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(7),


                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(7),


                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        setState(() {

                          _enterStreaming=true;

                        });


                      }, style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD6DC16,),
                          minimumSize: Size(Get.width*0.8, Get.height*0.06)

                      ),child:const Text('Start'),),
                    ],
                  )


                ],
              ),
            )


          ],
        ),

        //      Column(
        //   children: [
        //     Container(
        //       height: Get.height * .91,
        //       // color: Appcolors.primaryColor,
        //       width: double.infinity,
        //       child:
        //       StreamBuilder(
        //           stream: FirebaseFirestore.instance
        //               .collection('Matches')
        //               .where('tournament_id', isEqualTo: widget.matchId)
        //               .snapshots(),
        //           builder: (BuildContext context,
        //               AsyncSnapshot<QuerySnapshot> snapshot) {
        //             if (snapshot.connectionState == ConnectionState.waiting) {
        //               return Center(
        //                   child: CircularProgressIndicator(
        //                 // color: Appcolors.blackColor,
        //               ));
        //             }
        //             if (snapshot.hasData) {
        //               return ListView(
        //                 physics: NeverScrollableScrollPhysics(),
        //                 children:
        //                     snapshot.data!.docs.map((DocumentSnapshot document) {
        //                   return Container(
        //                     height: Get.height * .91,
        //                     width: Get.width,
        //                     // color: Colors.amber,
        //                     child: Column(
        //                       children: [
        //                         // Obx(
        //                         //   () => Visibility(
        //                         //     visible: liveController.scoreBoard.isTrue,
        //                         //     child: rotateAppbar(
        //                         //       context,
        //                         //       (value) {
        //                         //         return value;
        //                         //       },
        //                         //       customBack: true,
        //                         //       back: () {
        //                         //         // liveController.updateStreamStatus(
        //                         //         //   'end',
        //                         //         // );
        //                         //         // playmodeController.upDateLiveStreamStatus(
        //                         //         //     'end', document['tournament_id']);
        //                         //         Get.back();
        //                         //       },
        //                         //       goProfile: () {
        //                         //         Get.to(ProfileScreen());
        //                         //       },
        //                         //       showTable: document['set'] == '1 Set'
        //                         //           ? false
        //                         //           : true,
        //                         //       t1p1: document['t1p1'],
        //                         //       t1p2: document['t1p2'],
        //                         //       t2p1: document['t2p1'],
        //                         //       t2p2: document['t2p2'],
        //                         //       dynamicScore1: document[
        //                         //               't1s${document['match'].toString()}'] ??
        //                         //           0,
        //                         //       dynamicScore2: document[
        //                         //               't2s${document['match'].toString()}'] ??
        //                         //           0,
        //                         //       teamOneScore1:
        //                         //           int.parse(document['t1s1'].toString()),
        //                         //       teamOneScore2:
        //                         //           int.parse(document['t1s2'].toString()),
        //                         //       teamTwoScore1:
        //                         //           int.parse(document['t2s1'].toString()),
        //                         //       teamTwoScore2:
        //                         //           int.parse(document['t2s2'].toString()),
        //                         //     ),
        //                         //   ),
        //                         // ),
        //                         Expanded(
        //                           child: Stack(
        //                             children: [
        //                               // Positioned(
        //                               //     bottom: 0,
        //                               //     right: 0,
        //                               //     child: ElevatedButton(
        //                               //         onPressed: () {
        //                               //           _switchCamera();
        //                               //         },
        //                               //         child: Text('switchCamera'))),
        //                               // Align(
        //                               //   alignment: Alignment.topLeft,
        //                               //   child: Padding(
        //                               //     padding: const EdgeInsets.all(8.0),
        //                               //     child: Container(
        //                               //       width: double.infinity,
        //                               //       height: double.infinity,
        //                               //       color: Appcolors.primaryColor,
        //                               //       child: GestureDetector(
        //                               //         onTap: () {
        //                               //           setState(() {
        //                               //             _switch = !_switch;
        //                               //           });
        //                               //         },
        //                               //         child: Center(
        //                               //           child: _switch
        //                               //               ? _renderLocalPreview()
        //                               //               : _renderRemoteVideo(),
        //                               //         ),
        //                               //       ),
        //                               //     ),
        //                               //   ),
        //                               // ),
        //                               Obx(() {
        //                                 return !liveController.scoreBoard.isTrue
        //                                     ? Container()
        //                                     : Padding(
        //                                         padding:
        //                                             const EdgeInsets.symmetric(
        //                                                 vertical: 2),
        //                                         child: Container(
        //                                           width: double.infinity,
        //                                           // height: Get.height * .09,
        //                                           color: Appcolors.blackColor,
        //                                           child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceEvenly,
        //                                             children: [
        //                                               AppText(
        //                                                   title:
        //                                                       //{widget.admin == false ? widget.clubName : clubName}
        //                                                       '${document['clubName']} Match ${document['match']}',
        //                                                   color: Appcolors
        //                                                       .whiteFonts,
        //                                                   size: Get.width * .017),
        //                                               AppText(
        //                                                   title: '/',
        //                                                   color: Appcolors
        //                                                       .whiteFonts,
        //                                                   size: Get.width * .017),
        //                                               Container(
        //                                                 padding: EdgeInsets.only(
        //                                                     top: 10),
        //                                                 color:
        //                                                     Appcolors.blackColor,
        //                                                 height: Get.height * .1,
        //                                                 width: Get.width * .12,
        //                                                 child: ListView.builder(
        //                                                     physics:
        //                                                         BouncingScrollPhysics(),
        //                                                     itemCount: widget
        //                                                         .team1.length,
        //                                                     itemBuilder:
        //                                                         (context, index) {
        //                                                       return AppText(
        //                                                         maxLines: 1,
        //                                                         overflow:
        //                                                             TextOverflow
        //                                                                 .ellipsis,
        //                                                         title: widget
        //                                                             .team1[index],
        //                                                         color: Appcolors
        //                                                             .whiteFonts,
        //                                                         size: AppConfig(
        //                                                                     context)
        //                                                                 .width *
        //                                                             .018,
        //                                                       );
        //                                                     }),
        //                                               ),
        //                                               AppText(
        //                                                   title: 'VS',
        //                                                   color: Appcolors
        //                                                       .whiteFonts,
        //                                                   size: Get.width * .017),
        //                                               Container(
        //                                                 padding: EdgeInsets.only(
        //                                                     top: 10),
        //                                                 color:
        //                                                     Appcolors.blackColor,
        //                                                 height: Get.height * .1,
        //                                                 width: Get.width * .12,
        //                                                 child: ListView.builder(
        //                                                     physics:
        //                                                         BouncingScrollPhysics(),
        //                                                     itemCount: widget
        //                                                         .team2.length,
        //                                                     itemBuilder:
        //                                                         (context, index) {
        //                                                       return AppText(
        //                                                         maxLines: 1,
        //                                                         overflow:
        //                                                             TextOverflow
        //                                                                 .ellipsis,
        //                                                         title: widget
        //                                                             .team2[index],
        //                                                         color: Appcolors
        //                                                             .whiteFonts,
        //                                                         size: AppConfig(
        //                                                                     context)
        //                                                                 .width *
        //                                                             .018,
        //                                                       );
        //                                                     }),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                       );
        //                               }),
        //                               Obx(() {
        //                                 return Positioned(
        //                                   bottom: 0,
        //                                   child: Padding(
        //                                       padding: const EdgeInsets.all(.0),
        //                                       child: AppButton(
        //                                         buttonName: 'Score',
        //                                         buttonColor:
        //                                             Appcolors.primaryColor,
        //                                         textColor: Appcolors.blackColor,
        //                                         onTap: () {
        //                                           liveController.showScoreBoard();
        //                                         },
        //                                         isIcon: true,
        //                                         icon: liveController.scoreBoard ==
        //                                                 true
        //                                             ? Icons.hide_source
        //                                             : Icons.panorama_fish_eye,
        //                                         iconColor: Appcolors.blackColor,
        //                                         buttonRadius:
        //                                             BorderRadius.circular(10),
        //                                         buttonWidth: Get.width * .18,
        //                                       )
        //                                       // ElevatedButton(
        //                                       //         style: ElevatedButton.styleFrom(
        //                                       //             primary:
        //                                       //                 Appcolors.primaryColor,
        //                                       //             onPrimary:
        //                                       //                 Appcolors.blackFonts),
        //                                       //         onPressed: () {
        //                                       //           liveController
        //                                       //               .showScoreBoard();
        //                                       //         },
        //                                       //         child: Text('Score'),
        //                                       //       )
        //                                       ),
        //                                 );
        //                               }),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   );
        //                 }).toList(),
        //               );
        //             }
        //             return CircularProgressIndicator();
        //           }),
        //     ),
        //     // rotateAppbar(context, (valu) {
        //     //   // Get.to(LiveStreaming());
        //     //   return valu;
        //     // }
        //     // ),
        //   ],
        // )
      ),


    );
  }

  // Local preview
  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: "test",
      );
    } else {
      return Text(
        'No live stream',
        textAlign: TextAlign.center,
      );
    }
  }
}
Widget LiveChatMenuButtons({
  required String path,
  VoidCallback? onTap
}){

  return GestureDetector(
    onTap: onTap,
      child: Image.asset(path,height: 50,width: 50,));

}
