import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:link_up/ui/setting/account_setting_page.dart';
import 'package:link_up/ui/setting/email_setting_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AuthController authController = Get.find(tag: AuthController().toString());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<AuthController>(
        init: authController,
        builder: (_) {
          if (authController.loading.value == true) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return SafeArea(
            left: false,
            right: false,
            bottom: false,
            top: false,
            child: Scaffold(

//

                // appBar: AppBar(
                // title: Text('settings'.tr),
                // backgroundColor: Colors.green.shade900,
                // ),
                drawer: Drawer(
                  backgroundColor: Colors.white,
                  // boundaryColor: Colors.blue,
                  // boundaryWidth: 4.0,
                  child: DrawerScreen(),
                ),
                body: SafeArea(
                  child: ListView(children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/Group 163959.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
                        child: Text(
                          "Account Settings",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    // Image.asset("assets/Group 163959.jpg"),
                    Container(
                      color: Colors.white,
                      width: width,
                      height: height,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccountSettingPage(),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black38, width: 0.5))),
                              child: ListTile(
                                title: Text(
                                  'account_setting'.tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text('please_set_your_account_env'.tr),
                                // trailing: Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: Colors.black,
                                // ),
                                trailing: Image.asset("assets/arrow.jpg"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSettingPage(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black38, width: 0.5))),
                              child: ListTile(
                                title: Text(
                                  'email_settings'.tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text('please_set_email_func'.tr),
                                // trailing: Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: Colors.black,
                                // ),
                                trailing: Image.asset("assets/arrow.jpg"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final dynamicLinkParams = DynamicLinkParameters(
                                link: Uri.parse("https://www.example.com/"),
                                uriPrefix: "https://example.page.link",
                                androidParameters: const AndroidParameters(
                                    packageName: "com.example.app.android"),
                                iosParameters: const IOSParameters(
                                    bundleId: "com.example.app.ios"),
                              );
                              final dynamicLink = await FirebaseDynamicLinks
                                  .instance
                                  .buildLink(dynamicLinkParams);

                              print('--------dynamic link-----');
                              print(dynamicLink);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black38, width: 0.5))),
                              child: ListTile(
                                title: Text(
                                  'invite_friends'.tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text('sent_invitation'.tr),
                                // trailing: Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: Colors.black,
                                // ),
                                trailing: Image.asset("assets/arrow.jpg"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'are_you_sure_delete_acc'.tr,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 16,
                                    ),
                                  ),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => Colors.red),
                                        ),
                                        child: Text(
                                          'cancel'.tr,
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          authController.deleteUser(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => Colors.green),
                                        ),
                                        child: Text(
                                          'delete'.tr,
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black38, width: 0.5))),
                              child: ListTile(
                                title: Text(
                                  'delete_account'.tr,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // subtitle: Text(
                                //   'delete_acc_permanantly'.tr,
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                // trailing: Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: Colors.black,
                                // ),
                                trailing: Image.asset("assets/arrow.jpg"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                )),
          );
        });
  }
}
