// ignore_for_file: prefer_const_constructors, unused_element, must_be_immutable, avoid_print, library_prefixes, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

const String _kDefaultAppGroup = 'io.agora';

// class RtmpStreaming extends StatefulWidget {
//   @override
//   _RtmpStreamingState createState() => _RtmpStreamingState();
// }

// // App state class
// class _RtmpStreamingState extends State<RtmpStreaming> {
//   bool _joined = false;
//   int _remoteUid = 0;
//   bool _switch = false;

//   // Init the app
Future<void> initPlatformState() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    await [Permission.microphone, Permission.camera].request();
  }

//     // Create RTC client instance
//     RtcEngineContext context = RtcEngineContext(APP_ID);
//     var engine = await RtcEngine.createWithContext(context);
//     // Define event handling logic
//     engine.setEventHandler(RtcEngineEventHandler(
//         joinChannelSuccess: (String channel, int uid, int elapsed) {
//       print('joinChannelSuccess ${channel} ${uid}');
//       setState(() {
//         _joined = true;
//       });
//     }, userJoined: (int uid, int elapsed) {
//       print('userJoined ${uid}');
//       setState(() {
//         _remoteUid = uid;
//       });
//     }, userOffline: (int uid, UserOfflineReason reason) {
//       print('userOffline ${uid}');
//       setState(() {
//         _remoteUid = 0;
//       });
//     }));
//     // Enable video
//     await engine.enableVideo();
//     // Join channel with channel name as 123
//     await engine.joinChannel(Token, '123', null, 0);
}

//   // Build UI
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter example app'),
//         ),
//         body: Stack(
//           children: [
//             Center(
//               child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.blue,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _switch = !_switch;
//                     });
//                   },
//                   child: Center(
//                     child:
//                         _switch ? _renderLocalPreview() : _renderRemoteVideo(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Local video rendering
//   Widget _renderLocalPreview() {
//     if (_joined && defaultTargetPlatform == TargetPlatform.android ||
//         _joined && defaultTargetPlatform == TargetPlatform.iOS) {
//       return RtcLocalView.SurfaceView();
//     }

//     if (_joined && defaultTargetPlatform == TargetPlatform.windows ||
//         _joined && defaultTargetPlatform == TargetPlatform.macOS) {
//       return RtcLocalView.TextureView();
//     } else {
//       return Text(
//         'Please join channel first',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   // Remote video rendering
//   Widget _renderRemoteVideo() {
//     if (_remoteUid != 0 && defaultTargetPlatform == TargetPlatform.android ||
//         _remoteUid != 0 && defaultTargetPlatform == TargetPlatform.iOS) {
//       return RtcRemoteView.SurfaceView(
//         uid: _remoteUid,
//         channelId: "123",
//       );
//     }

//     if (_remoteUid != 0 && defaultTargetPlatform == TargetPlatform.windows ||
//         _remoteUid != 0 && defaultTargetPlatform == TargetPlatform.macOS) {
//       return RtcRemoteView.TextureView(
//         uid: _remoteUid,
//         channelId: "123",
//       );
//     } else {
//       return Text(
//         'Please wait remote user join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }

/// RtmpStreaming Example
class RtmpStreaming extends StatefulWidget {
  String channel;
  String token;
  bool admin;

  /// Construct the [RtmpStreaming]
  RtmpStreaming(
      {Key? key,
      required this.channel,
      required this.token,
      required this.admin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtmpStreamingState();
}

class _RtmpStreamingState extends State<RtmpStreaming> {
  // late final RtcEngine _engine;
  String channelId = 'test';
  bool isJoined = false;
  bool switchCamera = true;
  // TextEditingController? _channelIdController;
  // late TextEditingController _rtmpUrlController;
  // bool _isStreaming = false;
  int _remoteUid = 0;
  String appId = '3f0cb77c9fc149a8bfb97a23dfde8f55';
  @override
  void initState() {
    initPlatformState();

    _initEngine();
    _joinChannel();
    // widget.admin ?
    // getToken();
    // : null;
    print('====================================');
    // print(widget.twitch);
    print(widget.token);
    // print(widget.admin);
    print(widget.channel);
    // Wakelock.enable();
    super.initState();
  }

  var channel = 'test';
  var token = '';
  var twitchkey = 'live_798308626_UtdryLvcVzAmcY3wU9Snj7BL6OhuYU';
  var twitchUrl = 'rtmp://live.twitch.tv/app/';
  var youtubeKey = 'fxbt-sa6z-4pqh-quv8-73hj';
  // 'fxbt-sa6z-4pqh-quv8-73hj';
  var youtubeUrl = 'rtmp://a.rtmp.youtube.com/live2/';
  //'rtmp://a.rtmp.youtube.com/live2/';
  var fbUrl = 'rtmps://live-api-s.facebook.com:443/rtmp/';
  var fbKey = 'FB-103897675692199-0-AbxbhoAeRlwPV2wB';
  var clubName = '';
  // void getToken() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   FirebaseFirestore.instance
  //       .collection('Token')
  //       .doc('9r7PBruaEDipiZYNBfdF')
  //       .snapshots()
  //       .listen((event) {
  //     setState(() {
  //       token = event.data()!['token'];
  //       channel = event.data()!['channel'];
  //       twitchkey = event.data()!['twitchStreamKey'];
  //       twitchUrl = event.data()!['twitchUrl'];
  //       youtubeKey = event.data()!['youtubeStreamKey'];
  //       youtubeUrl = event.data()!['youtubeUrl'];
  //       appId = event.data()!['appId'];
  //       clubName = '';
  //     });
  //   });
  // }

  @override
  void dispose() {
    //  widget.admin? removeStream():null;
    leaveChannel();
    // Wakelock.disable();
    super.dispose();
  }

  leaveChannel() async {
    print('channel leaved by audience');
    RtcEngine _engine =
        await RtcEngine.createWithContext(RtcEngineContext(appId));


    await _engine.leaveChannel();
  }

  Future<void> _initEngine() async {
    RtcEngine _engine =
        await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(
        widget.admin ? ClientRole.Broadcaster : ClientRole.Audience);
  }

  void _addListeners() async {
    RtcEngine _engine =
        await RtcEngine.createWithContext(RtcEngineContext(appId));

    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        // logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        // logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        // logSink.log('joinChannelSuccess $channel $uid $elapsed');

        setState(() {
          isJoined = true;
        });

        // _startTranscoding();
      },
      userJoined: (uid, elapsed) {
        // logSink.log('userJoined  $uid $elapsed');
        // if (_remoteUid == 0) {
        setState(() {
          _remoteUid = uid;
        });
        // }
        // _startTranscoding(isRemoteUser: true);
      },
      userOffline: (uid, reason) {
        // logSink.log('userOffline  $uid $reason');
        setState(() {
          _remoteUid = 0;
        });
      },
      leaveChannel: (stats) {
        // logSink.log('leaveChannel ${stats.toJson()}');

          isJoined = false;

      },
      rtmpStreamingStateChanged: (String url, RtmpStreamingState state,
          RtmpStreamingErrorCode errCode) {
        print('this is state $state');
        // logSink.log(
        //     'rtmpStreamingStateChanged url: $url, state: $state, errCode: $errCode');
      },
      rtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        // logSink.log(
        //     'rtmpStreamingEvent url: $url, eventCode: ${eventCode.toString()}');
      },
    ));
  }

//  String Token = '00664d7f7dcbbbd4272a4fba5f779d53cfcIABCkR6TInj53mWMxk9+ybPV5bCqte5vMCh+czg9JfhqNUeO+aIAAAAAEABF5qhU9bGlYgEAAQD1saVi';
  // final liveController = Get.put(LiveStreamController());

  Future<void> _joinChannel() async {
    RtcEngine _engine =
        await RtcEngine.createWithContext(RtcEngineContext(appId));


    // Get.snackbar('Message', 'message',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Appcolors.primaryColor,
    //     messageText: Text('Live streaming started'));

    // widget.admin
    //     ? liveController.createLiveStream(widget.channel, widget.token)
    //     : null;

    if (defaultTargetPlatform == TargetPlatform.android) {
      // await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(widget.token, widget.channel, null, 0);

    // widget.admin
    //     ? await _engine.addPublishStreamUrl(
    //         widget.twitch == true
    //             ? twitchUrl + twitchkey
    //             : youtubeUrl + youtubeKey,
    //         true)
    //     : null;
    // _startScreenShare();
    // await _engine.addPublishStreamUrl('rtmp://live.twitch.tv/app/live_695469491_nxEnDOAYUKJDib5hEzKQD73QJqfvD3', true);
  }

//rtmp://live.twitch.tv/app/live_695469491_nxEnDOAYUKJDib5hEzKQD73QJqfvD3
  // Future<void> removeStream() async {
  //   RtcEngine _engine =
  //       await RtcEngine.createWithContext(RtcEngineContext(appId));

  //   await _engine.leaveChannel();
  //   // await _engine.removePublishStreamUrl(
  //   //   // widget.twitch == true ? twitchUrl + twitchkey : youtubeUrl + youtubeKey,
  //   // );
  //   await _engine.destroy();
  // }

  void _switchCamera() async {
    RtcEngine _engine =
        await RtcEngine.createWithContext(RtcEngineContext(appId));

    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      debugPrint('switchCamera $err');
    });
  }

  // Future<void> _startTranscoding({bool isRemoteUser = false}) async {
  //   RtcEngine _engine =
  //       await RtcEngine.createWithContext(RtcEngineContext(appId));
  //   var config = VideoEncoderConfiguration();
  //   config.orientationMode = VideoOutputOrientationMode.FixedLandscape;
  //   _engine.setVideoEncoderConfiguration(config);
  //   if (_isStreaming && !isRemoteUser) return;
  //   // final streamUrl = _rtmpUrlController.text;
  //   if (_isStreaming && isRemoteUser) {
  //     widget.admin
  //         ? await _engine.removePublishStreamUrl(
  //             widget.twitch == true
  //                 ? twitchUrl + twitchkey
  //                 : youtubeUrl + youtubeKey,
  //           )
  //         : null;
  //     // await _engine.removePublishStreamUrl('rtmp://live.twitch.tv/app/live_695469491_nxEnDOAYUKJDib5hEzKQD73QJqfvD3');
  //   }
//  _addRenderView(client.uid, (viewId) {
//       _engine.setupLocalVideo(viewId, VideoRenderMode.Fit);
//       _engine.startPreview();
//     });
  // _isStreaming = true;

  // final List<TranscodingUser> transcodingUsers = [
  //   TranscodingUser(
  //     0,
  //     x: 0,
  //     y: 0,
  //     width: 360,
  //     height: 640,
  //     audioChannel: AudioChannel.Channel0,
  //     alpha: 1.0,
  //   )
  // ];

  // if (isRemoteUser) {
  //   transcodingUsers.add(TranscodingUser(
  //     _remoteUid,
  //     x: 360,
  //     y: 0,
  //     width: 360,
  //     height: 640,
  //     audioChannel: AudioChannel.Channel0,
  //     alpha: 1.0,
  //   ));
  // }

  //   try {
  //     widget.admin
  //         ? await _engine.addPublishStreamUrl(
  //             widget.twitch == true
  //                 ? twitchUrl + twitchkey
  //                 : youtubeUrl + youtubeKey,
  //             false)
  //         : null;
  //     // await _engine.addPublishStreamUrl('rtmp://live.twitch.tv/app/live_695469491_nxEnDOAYUKJDib5hEzKQD73QJqfvD3', false);

  //   } catch (e) {
  //     print("publish streamutl ${e.toString()}");
  //     // logSink.log('addPublishStreamUrl error: ${e.toString()}');
  //   }
  // }
  // bool screenSharing=false;
  // _startScreenShare() async {
  //   print('screen is shared');
  //   RtcEngine _engine =
  //       await RtcEngine.createWithContext(RtcEngineContext(appId));
  //   final helper = await _engine.getScreenShareHelper(
  //       appGroup:  _kDefaultAppGroup);
  //       print('helper completed $helper');

  //   helper.setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (String channel, int uid, int elapsed) {
  //       // logSink.log('ScreenSharing joinChannelSuccess $channel $uid $elapsed');
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content:
  //             Text('ScreenSharing joinChannelSuccess $channel $uid $elapsed'),
  //       ));
  //     },

  //     localVideoStateChanged:
  //         (LocalVideoStreamState localVideoState, LocalVideoStreamError error) {
  //       // logSink.log(
  //       //     'ScreenSharing localVideoStateChanged $localVideoState $error');
  //       if (error == LocalVideoStreamError.ScreenCaptureWindowClosed) {
  //         _stopScreenShare();
  //       }
  //     },
  //   ));

  //   await helper.disableAudio();
  //   await helper.enableVideo();
  //   await helper.setChannelProfile(ChannelProfile.LiveBroadcasting);
  //   await helper.setClientRole(ClientRole.Broadcaster);
  //   var windowId = 0;
  //   var random = Random();
  //   if (!kIsWeb &&
  //       (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {
  //         print('platform chek');

  //     final windows = _engine.enumerateDisplays();
  //     if (windows.isNotEmpty) {
  //       final index = random.nextInt(windows.length - 1);
  //       // logSink.log('ScreenSharing window with index $index');
  //       windowId = windows[index].id;
  //     }
  //   }
  //   await helper.startScreenCaptureByWindowId(windowId);
  //   setState(() {
  //     screenSharing = true;
  //   });
  //   await helper.joinChannel(
  //       token, channelId, null, 10);
  // }

  // _stopScreenShare() async {
  //   RtcEngine _engine =
  //       await RtcEngine.createWithContext(RtcEngineContext(appId));
  //   final helper = await _engine.getScreenShareHelper();
  //   await helper.destroy().then((value) {
  //     setState(() {
  //       screenSharing = false;
  //     });
  //   }).catchError((err) {
  //     // logSink.log('_stopScreenShare $err');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: widget.admin == false
              ? _renderRemoteVideo()
              : _renderLocalPreview(),
        ),
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,150),
              child: widget.admin
                  ? CircleAvatar(
                      radius: Get.width * .05,
                      backgroundColor: Colors.white,
                      child: InkWell(
                          onTap: _switchCamera,
                          child: Icon(Icons.switch_camera,
                              size: Get.width * .04, color: Colors.black)),
                    )
                  : Container(),
            ),
          )
      ],
    );
  }

  Widget _renderLocalPreview() {
    if (isJoined) {
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
          uid: _remoteUid, channelId: widget.channel);
    } else {
      return Text(
        'No live stream',
        textAlign: TextAlign.center,
      );
    }
  }

  // Widget _renderVideo() {
  //   return Expanded(
  //     child: Stack(
  //       children: [
  //         Container(
  //           child: kIsWeb
  //               ? rtc_local_view.SurfaceView()
  //               : rtc_local_view.TextureView(),
  //         ),
  //         if (_remoteUid != 0)
  //           Align(
  //             alignment: Alignment.topLeft,
  //             child: SizedBox(
  //               width: 120,
  //               height: 120,
  //               child: kIsWeb
  //                   ? rtc_remote_view.SurfaceView(
  //                       uid: _remoteUid,
  //                       channelId: widget.channel,
  //                     )
  //                   : rtc_remote_view.TextureView(
  //                       uid: _remoteUid,
  //                       channelId: widget.channel,
  //                     ),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }
}
