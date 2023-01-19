import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/widgets/exit_dialog.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        Stack(
          children: [
            Image.asset(
              'assets/blue.png',
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset("assets/LinkUp App Login 2.png"),
                Text(
                  "Explorer the\nTopics",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Link and Vibe with Carribean & Latin\n American people Around you",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                          width: 351,
                          height: 268,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.8,
                                  padding: EdgeInsets.only(top: 10, bottom: 50),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: ElevatedButton(
                                            // color: Colors.red[700],
                                            child: Text(
                                              'sign_in_with_phone'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xffD6DC16),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutePath
                                                      .phone_verification_page);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text('or'.tr),
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  RoutePath.login_screen);
                                            },
                                            child:
                                                Text('sign_in_with_email'.tr),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'by_tapping_login_you_agree'.tr,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Center(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'privacy policy',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              RoutePath
                                                                  .pdf_view,
                                                              arguments: {
                                                                "key":
                                                                    "privacy_policy"
                                                              }),
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' | ',
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'term and condition',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          Navigator.pushNamed(
                                                              context,
                                                              RoutePath
                                                                  .pdf_view,
                                                              arguments: {
                                                                "key":
                                                                    "term_and_condition"
                                                              }),
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
