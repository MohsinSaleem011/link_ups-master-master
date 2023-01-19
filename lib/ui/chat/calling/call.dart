import 'dart:async';
import 'dart:convert';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

RtcEngine? _engine;

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelId;

  /// non-modifiable client role of the page
  final ClientRole role;
  final String callType;

  /// Creates a call page with given channel name.
  const CallPage(
      {Key? key,
      required this.channelId,
      required this.role,
      required this.callType})
      : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  List<int> _users = <int>[];
  List<String> _infoStrings = <String>[];
  bool muted = false;
  bool disable = true;
  bool isJoined = false;
  int? remoteUid;
  bool switchCamera = true;

  @override
  void dispose() {
    _users.clear();
    _engine?.destroy();
    super.dispose();
  }

  void stopRinging() async {
    await FlutterRingtonePlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    stopRinging();
    initialize();
  }

  Future<void> initialize() async {
    await initAgoraRtcEngine();
    _addListeners();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(height: 1920, width: 1080);
    await _engine?.setVideoEncoderConfiguration(configuration);
    _joinChannel();
  }

  Future<void> initAgoraRtcEngine() async {
    _engine = await RtcEngine.create("3f0cb77c9fc149a8bfb97a23dfde8f55");
    if (widget.callType == 'Video') {
      await _engine?.enableVideo();
      await _engine?.enableAudio();
    } else {
      await _engine?.enableAudio();
    }
  }

  _joinChannel() async {
    print("Joined...................1");

    await [Permission.microphone, Permission.camera].request();

    String _channel = "test";
    var tokenResponse = await http.get(Uri.parse(AppConstant.tokenServerUrl +
        "channel=test&role=publisher&tokentype=uid"));
    var resJson = jsonDecode(tokenResponse.body);
    String newToken = resJson['rtcToken'];
    await _engine?.joinChannel(newToken, _channel, null, 0);
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
    List<String> _users = widget.channelId.split('-');
    String me = FirebaseAuth.instance.currentUser!.uid;
    String endUsr = _users.firstWhere((element) => element != me);
    FirebaseFirestore.instance
        .collection('calls')
        .doc(endUsr)
        .update({'response': 'ended'});
    FirebaseFirestore.instance
        .collection('calls')
        .doc(me)
        .update({'response': 'ended'});
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print(
            "joinChannelSuccess.................................................................");
        setState(() {
          isJoined = true;
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          remoteUid = uid;
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          if (_users.contains(uid) == false) {
            _users.add(uid);
          }
        });
      },
      userOffline: (uid, reason) {
        print(
            "userOffline.................................................................");
        if (uid == remoteUid) {
          setState(() {
            remoteUid = null;
            final info = 'userOffline: $uid';
            _infoStrings.add(info);
            _users.remove(uid);
          });
          Navigator.pop(context);
        }
      },
      leaveChannel: (stats) async {
        print(
            "leaveChannel.................................................................");
        await FlutterRingtonePlayer.stop();
        setState(() {
          isJoined = false;
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
        Navigator.pop(context);
      },
    ));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(
          uid: uid,
          channelId: "",
        )));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Stack(
          children: <Widget>[
            Column(
              children: [
                _expandedVideoRow([views[1]]),
              ],
            ),
            Container(
              alignment: Alignment.topRight,
              child: Container(
                width: 140,
                height: 200,
                child: Column(
                  children: [
                    _expandedVideoRow([views[0]]),
                  ],
                ),
              ),
            )
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _videoToolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: _disVideo,
            child: Icon(
              disable ? Icons.videocam : Icons.videocam_off,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  Widget _audioToolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    _leaveChannel();
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine?.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine?.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {});
  }

  _disVideo() {
    setState(() {
      disable = !disable;
    });
    _engine?.enableLocalVideo(disable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            widget.callType == "Video"
                ? _viewRows()
                : Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 60,
                    ),
                  ),
            widget.callType == "Video" ? _videoToolbar() : _audioToolbar()
          ],
        ),
      ),
    );
  }
}
