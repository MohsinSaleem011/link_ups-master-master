import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationPage extends StatefulWidget {
  const PushNotificationPage({Key? key}) : super(key: key);

  @override
  _PushNotificationPageState createState() => _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {
  bool _isMatches = true,
      _isMessages = true,
      _isMessageLikes = true,
      _isSuperLikes = true,
      _isTopPicks = true,
      _isVibrations = false,
      _isSounds = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'push_notification'.tr,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        elevation: 10,
      ),
      body: Container(
          color: Colors.grey[200],
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'new_matches'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('you_got_new_match'.tr),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isMatches,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isMatches = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'messages'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('someone_sent_new_message'.tr),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isMessages,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isMessages = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'message_likes'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('someone_likes_message'.tr),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isMessageLikes,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isMessageLikes = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'super_likes'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("you_been_super_like".tr),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isSuperLikes,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isSuperLikes = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'top_picks'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('your_dails_top_picks'.tr),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isTopPicks,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isTopPicks = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'in_app_vibration'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isVibrations,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isVibrations = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 0.5))),
                child: ListTile(
                  title: Text(
                    'in_app_sound'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 75,
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Switch(
                      value: _isSounds,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isSounds = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
