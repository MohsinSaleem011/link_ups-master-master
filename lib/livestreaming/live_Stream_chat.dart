import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class LiveStreamChat extends StatefulWidget {
  String? channel;
  LiveStreamChat({Key? key,this.channel}) : super(key: key);
  @override
  State<LiveStreamChat> createState() => _LiveStreamChatState();


}

class _LiveStreamChatState extends State<LiveStreamChat> {
  bool _isLogin = false;
  bool _isInChannel = false;
  String APP_ID = 'ab9d499a4f5345fda450b66bb0a108f4';
  final _userNameController = TextEditingController();
  final _peerUserIdController = TextEditingController();
  final _peerMessageController = TextEditingController();
  final _invitationController = TextEditingController();
  final _channelNameController = TextEditingController();
  final _channelMessageController = TextEditingController();

  final _infoStrings = <String>[];

  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;

  @override
  void initState() {
    super.initState();
    _createClient();
    _toggleJoinChannel(widget.channel!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.1,
      padding: const EdgeInsets.all(16),
      child: _buildSendChannelMessage(),
    );
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
    _client?.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      _log("Peer msg: " + peerId + ", msg: " + (message.text));
    };
    _client?.onConnectionStateChanged = (int state, int reason) {
      _log('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client?.logout();
        _log('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    };
    _client?.onLocalInvitationReceivedByPeer =
        (AgoraRtmLocalInvitation invite) {
      _log(
          'Local invitation received by peer: ${invite.calleeId}, content: ${invite.content}');
    };
    _client?.onRemoteInvitationReceivedByPeer =
        (AgoraRtmRemoteInvitation invite) {
      _log(
          'Remote invitation received by peer: ${invite.callerId}, content: ${invite.content}');
    };
  }

  Future<AgoraRtmChannel?> _createChannel(String name) async {
    AgoraRtmChannel? channel = await _client?.createChannel(name);
    if (channel != null) {
      channel.onMemberJoined = (AgoraRtmMember member) {
        _log("Member joined: " +
            member.userId +
            ', channel: ' +
            member.channelId);
      };
      channel.onMemberLeft = (AgoraRtmMember member) {
        _log(
            "Member left: " + member.userId + ', channel: ' + member.channelId);
      };
      channel.onMessageReceived =
          (AgoraRtmMessage message, AgoraRtmMember member) {
        _log("Channel msg: " + member.userId + ", msg: " + message.text);
      };
    }
    return channel;
  }

  static TextStyle textStyle = TextStyle(fontSize: 18,);

  Widget _buildLogin() {
    return Row(children: <Widget>[
      _isLogin
          ? new Expanded(
          child: new Text('User Id: ' + _userNameController.text,
              style: textStyle))
          : new Expanded(
          child: new TextField(
              controller: _userNameController,
              decoration: InputDecoration(hintText: 'Input your user id'))),
      new ElevatedButton(
        child: Text(_isLogin ? 'Logout' : 'Login', style: textStyle),
        onPressed: _toggleLogin,
      )
    ]);
  }







  Widget _buildJoinChannel() {
    // if (!_isLogin) {
    //   return Container();
    // }
    return Row(children: <Widget>[
      _isInChannel
          ? new Expanded(
          child: new Text('Channel: ' + _channelNameController.text,
              style: textStyle))
          : new Expanded(
          child: new TextField(
              controller: _channelNameController,
              decoration: InputDecoration(hintText: 'Input channel id'))),
      new ElevatedButton(
        child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
            style: textStyle),
        onPressed: (){},
      )
    ]);
  }

  Widget _buildSendChannelMessage() {
    // if (!_isLogin || !_isInChannel) {
    //   return Container();
    // }
    return Row(children: <Widget>[
      new Expanded(
          child: new TextField(
              controller: _channelMessageController,
              decoration: InputDecoration(hintText: 'Type message..',
                  filled: true,fillColor: Colors.white,
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color:Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color:Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color:Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ), disabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color:Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                      borderSide:const BorderSide(
                          color: Colors.transparent,
                          width: 0
                      ),


                      borderRadius: BorderRadius.circular(10)
                  )

              ))),
      new ElevatedButton(
        child: Text('Send', style: textStyle),
        onPressed: _toggleSendChannelMessage,
      )
    ]);
  }

  Widget _buildGetMembers() {
    if (!_isLogin || !_isInChannel) {
      return Container();
    }
    return Row(children: <Widget>[
      new ElevatedButton(
        child: Text('Get Members in Channel', style: textStyle),
        onPressed: _toggleGetMembers,
      )
    ]);
  }

  Widget _buildInfoList() {
    return Expanded(
        child: Container(
            child: ListView.builder(
              itemExtent: 24,
              itemBuilder: (context, i) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  title: Text(_infoStrings[i]),
                );
              },
              itemCount: _infoStrings.length,
            )));
  }

  void _toggleLogin() async {
    if (_isLogin) {
      try {
        await _client?.logout();
        _log('Logout success.');

        setState(() {
          _isLogin = false;
          _isInChannel = false;
        });
      } catch (errorCode) {
        _log('Logout error: ' + errorCode.toString());
      }
    } else {
      String userId = _userNameController.text;
      if (userId.isEmpty) {
        _log('Please input your user id to login.');
        return;
      }

      try {
        await _client?.login(null, userId);
        _log('Login success: ' + userId);
        setState(() {
          _isLogin = true;
        });
      } catch (errorCode) {
        _log('Login error: ' + errorCode.toString());
      }
    }
  }



  void _toggleJoinChannel(String channel_id) async {
    if (_isInChannel) {
      try {
        await _channel?.leave();
        _log('Leave channel success.');
        if (_channel != null) {
          _client?.releaseChannel(_channel!.channelId!);
        }
        _channelMessageController.clear();

        setState(() {
          _isInChannel = false;
        });
      } catch (errorCode) {
        _log('Leave channel error: ' + errorCode.toString());
      }
    } else {


      try {
        _channel = await _createChannel(widget.channel!);
        await _channel?.join();


        setState(() {
          _isInChannel = true;
        });
      } catch (errorCode) {
        _log('Join channel error: ' + errorCode.toString());
      }
    }
  }

  void _toggleGetMembers() async {
    try {
      List<AgoraRtmMember>? members = await _channel?.getMembers();
      _log('Members: ' + members.toString());
    } catch (errorCode) {
      _log('GetMembers failed: ' + errorCode.toString());
    }
  }

  void _toggleSendChannelMessage() async {
    String text = _channelMessageController.text;
    if (text.isEmpty) {
      _log('Please input text to send.');
      return;
    }
    try {
      await _channel?.sendMessage(AgoraRtmMessage.fromText(text));
      _log(text);
    } catch (errorCode) {
      _log('Send channel message error: ' + errorCode.toString());
    }
  }

  void _log(String info) {
    print(info);
    setState(() {
      _infoStrings.insert(0, info);
    });
  }
}
