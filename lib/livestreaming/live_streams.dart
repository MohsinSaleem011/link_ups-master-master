// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_print, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:link_up/livestreaming/live_streaming.dart';
import 'package:link_up/model/appGlobal.dart';

class LiveHomePage extends StatefulWidget {
  LiveHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<LiveHomePage> createState() => LiveHomePageState();
}

class LiveHomePageState extends State<LiveHomePage> {
  int value = 0;
  bool? isChecked = false;
  String url = '';
  TextEditingController keyController = TextEditingController();
  bool youtubeSelected = false;
  bool twitchSelected = false;
  String apptoken = '';
  bool isloading = false;
  // final _infoStrings = <String>[];
  Future<String> getTokenFromServer() async {
    print('this is token ');
    // print('https://agora-node-tokenserver.digixdev.repl.co/access_token?channelName=${profileController.usersername.value}');
    try {
      setState(() {
        isloading = true;
      });
      var response = await http.get(
        Uri.parse(
            'https://agora-node-tokenserver.ahmadrazadigix.repl.co/access_token?channelName=test'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          apptoken = data['token'].toString();
          getToken(apptoken);
        });
        print('My token $apptoken');
      } else {
        print(response.statusCode);
        print('Failed to fetch the token');
      }
    } catch (e) {
      print(e.toString());
      print("error aya hy ${e.toString()}");
    } finally {
      setState(() {
        isloading = false;
      });
    }
    return apptoken;
  }

  @override
  void initState() {
    getTokenFromServer();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    _showDialog();
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.dispose();
  }

  // final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(9),
              width: Get.width,
              height: Get.height * .25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Group 163959.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * .035,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: Get.height * .04,
                      ),
                      Text(
                        'Meet People',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white,
                            fontSize: Get.width * .06,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          //Image.asset('assets/img_3.png',height: Get.height * .04,width: Get.height * .04,),

                          Transform.rotate(
                            angle: 180 * math.pi / 360,
                            child: Icon(
                              Icons.candlestick_chart_outlined,
                              color: Colors.white,
                              size: Get.height * .04,
                            ),
                          ),
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: Get.height * .04,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/img_4.png',
                        height: Get.height * .07,
                      ),
                      Image.asset(
                        'assets/img_5.png',
                        height: Get.height * .07,
                      ),
                      Image.asset(
                        'assets/img_6.png',
                        height: Get.height * .07,
                      ),
                      Image.asset(
                        'assets/img_7.png',
                        height: Get.height * .07,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: Get.height * 0.15,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8)),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(LiveStreaming(
                            admin: false,
                            channelName: 'test',
                            token: apptoken,
                          ));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: Get.height * .02,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: Text(
                                  'NAME HERE',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      insetPadding: EdgeInsets.only(left: 8, right: 8),
                      contentPadding: EdgeInsets.zero,
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    height: Get.height * 0.2,
                                    child: ClipRRect(
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(
                                            4), //add border radius
                                        child: Image.asset(
                                          'assets/Group 163959.png',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 15, 8, 8),
                                    child: Text(
                                      'Let’s Get Livestreamingive',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 0, 20, 48),
                                    child: Text(
                                      'Show off your talents and introduce the real you, but do not stream;',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Icon(
                                    Icons.block_outlined,
                                    size: 70,
                                    color: Color(0xFF9A9A9A),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                                    child: Text(
                                      'Nudity or pornography',
                                      style: GoogleFonts.openSans(
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                                    child: Text(
                                      'Hate speech or bullying',
                                      style: GoogleFonts.openSans(
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                                    child: Text(
                                      'Illegal activity',
                                      style: GoogleFonts.openSans(
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                                    child: Text(
                                      'Minors',
                                      style: GoogleFonts.openSans(
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          activeColor: Color(0xFF38ABD8),
                                          value: isChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          }),
                                      Expanded(
                                          child: Text(
                                        'I agree to the Terms of Service and the livestreaming Content and Conduct Policy and understand that breaking the rules may result in account removal',
                                        style: GoogleFonts.openSans(
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      isChecked == true
                                          ? Navigator.pop(context)
                                          : null;

                                      isChecked == true
                                          ? Get.dialog(
                                              AlertDialog(
                                                elevation: 0,
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                contentPadding: EdgeInsets.zero,
                                                content: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: Get.height * 0.5,
                                                      width: Get.width,
                                                      child: ClipRRect(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15), //add border radius
                                                          child: Image.asset(
                                                            'assets/img_1.png',
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/img.png',
                                                          height:
                                                              Get.height * 0.25,
                                                          width:
                                                              Get.width * 0.25,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  16.0,
                                                                  0,
                                                                  8,
                                                                  16),
                                                          child: Text(
                                                            'Hang out with streamers near you or around the world! There’s always fun conversation happening here.',
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    color: Color(
                                                                        0xFF9A9A9A),
                                                                    fontSize:
                                                                        11),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              isChecked = false;
                                                              Get.off(
                                                                  LiveStreaming(
                                                                admin: true,
                                                                channelName:
                                                                    'test',
                                                                token: apptoken,
                                                              ));
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Color(
                                                                      0xFFD6DC16,
                                                                    ),
                                                                    minimumSize: Size(
                                                                        Get.width *
                                                                            0.8,
                                                                        Get.height *
                                                                            0.06)),
                                                            child: const Text(
                                                                'Get Started!')),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : null;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(
                                          0xFFD6DC16,
                                        ),
                                        minimumSize: Size(Get.width * 0.8,
                                            Get.height * 0.06)),
                                    child: const Text('Get it!'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(
                      0xFFD6DC16,
                    ),
                    minimumSize: Size(Get.width * 0.8, Get.height * 0.06)),
                child: const Text('GO LIVE')),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/Meet 1.png',
                        height: Get.height * .07,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/Chat.png',
                          height: Get.height * .07,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.only(left: 8, right: 8),
                              contentPadding: EdgeInsets.zero,
                              content: StatefulBuilder(
                                builder: (context, setState) {
                                  return Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            height: Get.height * 0.2,
                                            child: ClipRRect(
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4), //add border radius
                                                child: Image.asset(
                                                  'assets/Group 163959.png',
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5))),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 15, 8, 8),
                                            child: Text(
                                              'Let’s Get Livestreamingive',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 0, 20, 48),
                                            child: Text(
                                              'Show off your talents and introduce the real you, but do not stream;',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Icon(
                                            Icons.block_outlined,
                                            size: 70,
                                            color: Color(0xFF9A9A9A),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8, 8, 8),
                                            child: Text(
                                              'Nudity or pornography',
                                              style: GoogleFonts.openSans(
                                                  color: Color(0xFF9A9A9A),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8, 8, 8),
                                            child: Text(
                                              'Hate speech or bullying',
                                              style: GoogleFonts.openSans(
                                                  color: Color(0xFF9A9A9A),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8, 8, 8),
                                            child: Text(
                                              'Illegal activity',
                                              style: GoogleFonts.openSans(
                                                  color: Color(0xFF9A9A9A),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 8, 8, 8),
                                            child: Text(
                                              'Minors',
                                              style: GoogleFonts.openSans(
                                                  color: Color(0xFF9A9A9A),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                  activeColor:
                                                      Color(0xFF38ABD8),
                                                  value: isChecked,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isChecked = value!;
                                                    });
                                                  }),
                                              Expanded(
                                                  child: Text(
                                                'I agree to the Terms of Service and the livestreaming Content and Conduct Policy and understand that breaking the rules may result in account removal',
                                                style: GoogleFonts.openSans(
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              isChecked == true
                                                  ? Navigator.pop(context)
                                                  : null;

                                              isChecked == true
                                                  ? Get.dialog(
                                                      AlertDialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        content: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              height:
                                                                  Get.height *
                                                                      0.5,
                                                              width: Get.width,
                                                              child: ClipRRect(
                                                                  clipBehavior: Clip
                                                                      .antiAlias,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15), //add border radius
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/img_1.png',
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/img.png',
                                                                  height:
                                                                      Get.height *
                                                                          0.25,
                                                                  width:
                                                                      Get.width *
                                                                          0.25,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          16.0,
                                                                          0,
                                                                          8,
                                                                          16),
                                                                  child: Text(
                                                                    'Hang out with streamers near you or around the world! There’s always fun conversation happening here.',
                                                                    style: GoogleFonts.openSans(
                                                                        color: Color(
                                                                            0xFF9A9A9A),
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      isChecked =
                                                                          false;
                                                                      Get.off(
                                                                          LiveStreaming(
                                                                        admin:
                                                                            true,
                                                                        channelName:
                                                                            'test',
                                                                        token:
                                                                            apptoken,
                                                                      ));
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                            backgroundColor:
                                                                                Color(
                                                                              0xFFD6DC16,
                                                                            ),
                                                                            minimumSize: Size(
                                                                                Get.width *
                                                                                    0.8,
                                                                                Get.height *
                                                                                    0.06)),
                                                                    child: const Text(
                                                                        'Get Started!')),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : null;
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xFFD6DC16,
                                                ),
                                                minimumSize: Size(
                                                    Get.width * 0.8,
                                                    Get.height * 0.06)),
                                            child: const Text('Get it!'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/Live.png',
                          height: Get.height * .07,
                        ),
                      ),
                      Image.asset(
                        'assets/Matches.png',
                        height: Get.height * .07,
                      ),
                      // bottomWidget(Icon(Icons.meeting_room), 'Meet'),
                      // bottomWidget(Icon(Icons.chat_bubble), 'Chat'),
                      // bottomWidget(Icon(Icons.live_tv), 'Live', onTap: () {}),
                      // bottomWidget(Icon(Icons.sports), 'Matches'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // Scaffold(
    //     appBar: AppBar(
    //       toolbarHeight: Get.height * .2,
    //       elevation: .5,
    //       backgroundColor: Colors.amber,
    //       leading: GestureDetector(
    //         onTap: () {
    //           Get.back();
    //         },
    //         child: Icon(Icons.arrow_back,
    //             color: Colors.black, size: Get.width * .05),
    //       ),
    //       title: Row(
    //         children: [
    //           // FlutterSwitch(
    //           //   toggleSize: 20,
    //           //   inactiveTextColor: Colors.white,
    //           //   activeTextColor: Colors.white,
    //           //   inactiveColor: Appcolors.blackColor,
    //           //   activeColor: Appcolors.blackColor,
    //           //   activeText: "LIVE",
    //           //   inactiveText: "LIVE",
    //           //   value: true,
    //           //   activeToggleColor: Appcolors.primaryColor,
    //           //   inactiveToggleColor: Appcolors.primaryColor,
    //           //   activeIcon: Icon(Icons.play_arrow),
    //           //   inactiveIcon: Icon(Icons.play_arrow),
    //           //   valueFontSize: Get.width * .01,
    //           //   width: AppConfig(context).width * .09,
    //           //   height: Get.height * .08,
    //           //   borderRadius: 100,
    //           //   showOnOff: true,
    //           //   onToggle: (value) {},
    //           // ),
    //           Padding(
    //             padding: EdgeInsets.only(left: 10),
    //             child: Text(
    //               'Chose where you want to live stream',
    //               // color: Appcolors.blackFonts,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
    //       child: isloading
    //           ? Center(
    //               child: CircularProgressIndicator(
    //                 color: Colors.blue,
    //               ),
    //             )
    //           : SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   // Padding(
    //                   //   padding:
    //                   //       EdgeInsets.symmetric(vertical: Get.height * 0.1),
    //                   //   child: Row(
    //                   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   //     children: [
    //                   //       // Image.asset(
    //                   //       //   AppImages.fbIcon,
    //                   //       //   height: Get.height * 0.15,
    //                   //       // ),
    //                   //       // Image.asset(
    //                   //       //   AppImages.instaIcon,
    //                   //       //   height: Get.height * 0.15,
    //                   //       // ),
    //                   //       GestureDetector(
    //                   //         onTap: () {
    //                   //           getTokenFromServer();

    //                   //           setState(() {
    //                   //             url = 'rtmp://a.rtmp.youtube.com/live2/';
    //                   //             youtubeSelected = !youtubeSelected;
    //                   //             twitchSelected = false;
    //                   //           });
    //                   //         },
    //                   //         child: Image.asset(
    //                   //           AppImages.youtubeIcon,
    //                   //           color: youtubeSelected == true
    //                   //               ? Appcolors.primaryColor
    //                   //               : Appcolors.blackColor,
    //                   //           height: Get.height * 0.15,
    //                   //         ),
    //                   //       ),
    //                   //       GestureDetector(
    //                   //         onTap: () {
    //                   //           getTokenFromServer();
    //                   //           setState(() {
    //                   //             twitchSelected = !twitchSelected;
    //                   //             youtubeSelected = false;
    //                   //             url = 'rtmp://live.twitch.tv/app/';
    //                   //           });
    //                   //         },
    //                   //         child: Image.asset(
    //                   //           AppImages.twitchIcon,
    //                   //           height: Get.height * 0.15,
    //                   //           color: twitchSelected
    //                   //               ? Appcolors.primaryColor
    //                   //               : Appcolors.blackColor,
    //                   //         ),
    //                   //       ),
    //                   //     ],
    //                   //   ),
    //                   // ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       // Container(
    //                       //     width: Get.width * 0.6,
    //                       //     decoration: BoxDecoration(
    //                       //         border: Border.all(
    //                       //             color: Appcolors.blackColor.withOpacity(.82)),
    //                       //         borderRadius: BorderRadius.circular(30)),
    //                       //     child: TextField(
    //                       //       controller: keyController,
    //                       //       cursorColor: Appcolors.greyColor,
    //                       //       decoration: InputDecoration(
    //                       //         hintText: 'Key of the Streaming',
    //                       //         contentPadding: EdgeInsets.only(
    //                       //             left: Get.width * 0.03,
    //                       //             right: Get.width * 0.03),
    //                       //         hintStyle: TextStyle(
    //                       //           color: Appcolors.blackColor,
    //                       //         ),
    //                       //         border: InputBorder.none,
    //                       //         focusedBorder: InputBorder.none,
    //                       //         enabledBorder: InputBorder.none,
    //                       //         errorBorder: InputBorder.none,
    //                       //         disabledBorder: InputBorder.none,
    //                       //       ),
    //                       //     )),
    //                       // Spacer(),

    //                       AppButton(
    //                           buttonRadius: BorderRadius.circular(30),
    //                           buttonName: 'Start',
    //                           buttonColor: Appcolors.primaryColor,
    //                           textColor: Appcolors.blackColor,
    //                           buttonWidth: Get.width * .25,
    //                           buttonHeight: Get.height * .1,
    //                           onTap: () {
    //                             getTokenFromServer();
    //                             playmodeController.upDateLiveStreamStatus(
    //                                 'ongoing', widget.docId);
    //                             // liveController.updateStreamStatus('ongoing');
    //                             // keyController.text.isEmpty
    //                             //     ? Get.snackbar('Error', '',
    //                             //         messageText: AppText(
    //                             //           title: 'Please enter stream key',
    //                             //         ),
    //                             //         snackPosition: SnackPosition.BOTTOM,
    //                             //         backgroundColor: Appcolors.primaryColor)
    //                             //     :
    //                             Get.to(LiveStreaming(
    //                               admin: true,
    //                               channelName:
    //                                   profileController.usersername.value,
    //                               twitch: twitchSelected,
    //                               youtube: youtubeSelected,
    //                               team1: widget.team1,
    //                               team2: widget.team2,
    //                               clubName: widget.club,
    //                               matchId: widget.docId,
    //                               token: apptoken,
    //                             ));
    //                           }),
    //                     ],
    //                   ),
    //                   // Padding(
    //                   //   padding: EdgeInsets.symmetric(
    //                   //       vertical: Get.height * 0.03,
    //                   //       horizontal: Get.width * 0.01),
    //                   //   child: AppText(
    //                   //       title: 'Ejm, ReballutionCluo Round Robin Match 2',
    //                   //       size: Get.width * .02,
    //                   //       color: Appcolors.greyColor),
    //                   // )
    //                 ],
    //               ),
    //             ),
    //     ));
  }

  Widget bottomWidget(Icon icon, String text, {VoidCallback? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
              radius: Get.width * .06,
              child: CircleAvatar(
                  radius: Get.width * .055,
                  backgroundColor: Colors.white,
                  child: icon)),
        ),
        SizedBox(
          height: Get.height * .01,
        ),
        Text(text)
      ],
    );
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    Get.dialog(
        AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.only(left: 8, right: 8),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        height: Get.height * 0.2,
                        child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius:
                                BorderRadius.circular(4), //add border radius
                            child: Image.asset(
                              'assets/Group 163959.png',
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Welcome To Linkup Live',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                                child: Center(
                                    child: Image.asset(
                              'assets/img_2.png',
                              height: 100,
                              width: 100,
                            )))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 80, 8, 8),
                        child: Text(
                          'Linkup live allows you to fete and vibe around the world virtually. Show your friends where the coolest fetes, carnivals or parties are. Connect and party! on linkup live.',
                          style: GoogleFonts.openSans(
                              color: Color(0xFF9A9A9A),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                              0xFFD6DC16,
                            ),
                            minimumSize:
                                Size(Get.width * 0.8, Get.height * 0.06)),
                        child: const Text('Get Started!'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        barrierDismissible: false);
  }
}
