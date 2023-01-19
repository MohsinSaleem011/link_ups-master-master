import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/model/user_model.dart';
import 'package:link_up/ui/chat/calling/call.dart';
import 'package:link_up/ui/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialCall extends StatefulWidget {
  final String channelId;
  final UserModel? receiver;
  final String callType;
  final String receiverId;
  const DialCall(
      {required this.channelId,
      this.receiver,
      required this.callType,
      required this.receiverId});

  @override
  _DialCallState createState() => _DialCallState();
}

class _DialCallState extends State<DialCall> {
  bool ispickup = false;
  CollectionReference callRef = FirebaseFirestore.instance.collection("calls");
  @override
  void initState() {
    _addCallingData();
    super.initState();
  }

  _addCallingData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';
    await callRef.doc(widget.channelId).delete();
    await callRef.doc(widget.channelId).set({
      'call_type': widget.callType,
      'calling': true,
      'response': "Awaiting",
      'channel_id': widget.channelId,
      'caller': usrID,
      'receiver': widget.receiver?.uid,
      'last_call': FieldValue.serverTimestamp()
    });
  }

  @override
  void dispose() async {
    super.dispose();
    ispickup = true;
    await callRef.doc(widget.channelId).set({'calling': false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: callRef
              .where("channel_id", isEqualTo: "${widget.channelId}")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            Future.delayed(Duration(seconds: 30), () async {
              if (!ispickup) {
                await callRef
                    .doc(widget.channelId)
                    .update({'response': 'Not-answer'});
              }
            });
            if (!snapshot.hasData) {
              return Container();
            } else
              try {
                switch (snapshot.data?.docs[0]['response']) {
                  case "Awaiting":
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      widget.receiver?.avatar ?? '')),
                            ),
                          ),
                          Text(
                            "${'waiting_for_replay'.tr} \n${widget.receiver?.firstName}...",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              icon: Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                              label: Text(
                                "End",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                await callRef
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {'response': "Call_Cancelled"},
                                );
                                await callRef.doc(widget.receiverId).update(
                                  {'response': "Call_Cancelled"},
                                );
                                Navigator.pop(context);
                              })
                        ],
                      );
                    }
                  case "Pickup":
                    {
                      ispickup = true;
                      return CallPage(
                          channelId: widget.channelId,
                          role: ClientRole.Broadcaster,
                          callType: widget.callType);
                    }
                  case "Decline":
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("${widget.receiver?.firstName} is not available",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Return",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                Get.offAll(() => HomePage());
                                // Navigator.pop(context);
                              })
                        ],
                      );
                    }
                  case "Not-answer":
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.receiver?.firstName} ${'didnt_answer_call'.tr}",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: Text(
                                "return".tr,
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              })
                        ],
                      );
                    }
                  default:
                    {
                      print('------------ popping screen');
                      Future.delayed(Duration(milliseconds: 500), () {
                        Navigator.pop(context);
                      });
                      return Container(
                        child: Text("call_ended".tr),
                      );
                    }
                }
              } catch (e) {
                return Container();
              }
          },
        ),
      ),
    );
  }
}
