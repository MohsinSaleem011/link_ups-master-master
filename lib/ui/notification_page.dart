import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'DrawerScreen.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  AuthController authController = Get.find(tag: AuthController().toString());

  @override
  void initState() {
    authController.fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<AuthController>(
        init: authController,
        builder: (_) {
          if (authController.listNotification.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: Text('notification'.tr),
                actions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            authController.clearNotification();
                          },
                          child: Row(
                            children: [
                              Text(
                                'Clear',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.delete, color: Colors.red)
                            ],
                          )),
                    ],
                  )
                ],
              ),
              drawer: Drawer(
                backgroundColor: Color(0XFF4E5B81),
                child: DrawerScreen(),
              ),
              body: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                itemCount: authController.listNotification.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 84,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 2),
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authController.listNotification[index]['notification']
                              ['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authController.listNotification[index]['notification']
                              ['body'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(),
                        ),
                        if (authController.listNotification[index]['time'] !=
                            null)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              DateTime.fromMillisecondsSinceEpoch(
                                    authController.listNotification[index]
                                        ['time'],
                                  ).year.toString() +
                                  '-' +
                                  DateTime.fromMillisecondsSinceEpoch(
                                    authController.listNotification[index]
                                        ['time'],
                                  ).month.toString() +
                                  '-' +
                                  DateTime.fromMillisecondsSinceEpoch(
                                    authController.listNotification[index]
                                        ['time'],
                                  ).day.toString(),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   flexibleSpace: Container(
            //     height: 150,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/Group 163959.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(60, 40, 0, 0),
            //       child: Text(
            //         "Notification",
            //        style: TextStyle(color: Colors.white, fontSize: 24),
            //       ),
            //     ),
            //   ),
            //   // title: Text('notification'.tr),
            //   elevation: 0,
            // ),
            drawer: Drawer(
              backgroundColor: Color(0XFF4E5B81),
              child: DrawerScreen(),
            ),
            // body: Container(
            //   width: width,
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Container(
            //         height: height * 0.8,
            //         alignment: Alignment.center,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'no_new_notification'.tr,
            //              style: TextStyle(
            //                   fontSize: 24,
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.black),
            //             ),
            //             SizedBox(
            //               height: 5,
            //             ),
            //             Text(
            //               'check_back_see'.tr,
            //               textAlign: TextAlign.center,
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            body: ListView(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Group 163959.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        iconSize: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Notification",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  leading: CircleAvatar(backgroundColor: Colors.blue),
                  title: Text("Vida want to connect"),
                  subtitle: Text("Lorem Ipsum is simply ....................."),
                  trailing: Text(
                    "Now",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  leading: CircleAvatar(backgroundColor: Colors.blue),
                  title: Text("Vida want to connect"),
                  subtitle: Text("Lorem Ipsum is simply ....................."),
                  trailing: Text(
                    "Now",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  leading: CircleAvatar(backgroundColor: Colors.blue),
                  title: Text("Vida want to connect"),
                  subtitle: Text("Lorem Ipsum is simply ................."),
                  trailing: Text(
                    "Yesterday",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  leading: CircleAvatar(backgroundColor: Colors.blue),
                  title: Text("Vida want to connect"),
                  subtitle: Text("Lorem Ipsum is simply .................."),
                  trailing: Text(
                    "Yesterday",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  leading: CircleAvatar(backgroundColor: Colors.blue),
                  title: Text("Vida want to connect"),
                  subtitle: Text("Lorem Ipsum is simply ................."),
                  trailing: Text(
                    "Yesterday",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          );
        });
  }
}
