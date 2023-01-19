import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/get_controller/home_controller.dart';
import 'package:link_up/helper/app_config.dart';
import 'package:link_up/helper/app_config.dart' as config;
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/helper/drawer_manager.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/model/user_model.dart';
import 'package:link_up/package/swipe_card_stack.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:link_up/ui/chat/calling/incomingCall.dart';
import 'package:link_up/ui/notification_page.dart';
import 'package:link_up/ui/profile/profile_page.dart';
import 'package:link_up/ui/why_we_are_here.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../events/splash_events.dart';
import '../livestreaming/live_streams.dart';
import 'chat/chat_home_page.dart';
import 'chat/chat_message_new.dart';

class HomePage extends StatefulWidget {
  String? whyare;
  final String? gender;
  final String? age;
  String? distance;

  HomePage({this.whyare, this.gender, this.distance, this.age});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late String? why = widget.whyare;
  AuthController authController = Get.find(tag: AuthController().toString());
  HomeController homeController = Get.find(tag: HomeController().toString());
  ChatController chatController = Get.find(tag: ChatController().toString());
  AppLifecycleState appLifecycleState = AppLifecycleState.resumed;

  AppLifecycleState get getAppLifecycleState => appLifecycleState;

  String? selectedUserID, _selectAbuse;
  final GlobalKey<SwipeCardStackState> _swipeKey =
      GlobalKey<SwipeCardStackState>();

  Location location = Location.Men;
  String actLocation = 'Men';

  Location1 location1 = Location1.twenty2;
  String actLocation1 = '22-27';

  Location2 location2 = Location2.hundred1;
  String actLocation2 = '100';

  Location3 location3 = Location3.all;
  String actLocation3 = 'all';

  var title = "Enter Your Address";
  var isLoading = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> checkToken(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');

    if (_userid == null || _userid == '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamed(context, RoutePath.login_screen);
      });
    }
    if (authController.user?.value.uid == null) {
      if (_userid != null && _userid != '') {
        authController.getUser(_userid, context);
      }
    }
  }

  selectAbuse(BuildContext context, UserModel toUser) async {
    await db.collection('flaggedUsers').doc().set({
      'fromId': authController.user!.value.uid,
      'fromFirstName': authController.user!.value.firstName,
      'fromLastName': authController.user!.value.lastName,
      'toId': toUser.uid,
      'toFirstName': toUser.firstName,
      'toLastName': toUser.lastName,
      'message': _selectAbuse,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    });
  }

  _selectAbuseDialog(
      BuildContext context, UserModel data, height, width, padding) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState2) {
            return AlertDialog(
              title: Text(
                'choose_cat'.tr,
                textAlign: TextAlign.center,
              ),
              content: Container(
                width: double.maxFinite,
                height: 360,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: config.App(context, height, width,
                          padding.vertical, padding.horizontal)
                      .abuseList
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      child: RadioListTile(
                        title: Text(config.App(context, height, width,
                                padding.vertical, padding.horizontal)
                            .abuseList[index]),
                        value: config.App(context, height, width,
                                padding.vertical, padding.horizontal)
                            .abuseList[index],
                        groupValue: _selectAbuse,
                        onChanged: (value) {
                          setState2(() {
                            _selectAbuse = value.toString();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('yes'.tr),
                  onPressed: () async {
                    await selectAbuse(context, data);
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('no'.tr),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  void gotoPlaceListPage(String title) {
    Navigator.pushNamed(context, RoutePath.place_list_screen,
        arguments: {'title': title});
  }

  void superLike(String friendId) {
    print("Love It");
  }

  void topShelf() {
    authController.alert1('Your profile set as top shelf to this user');
  }

  void _getCurrentUserLocation() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      }
    });

    LocationSettings locationSettings =
        LocationSettings(accuracy: LocationAccuracy.best);
    await GeolocatorPlatform.instance
        .getCurrentPosition(locationSettings: locationSettings)
        .then((Position position) async {
      DrawerManager.shared.latitude = position.latitude.toString();
      DrawerManager.shared.longitude = position.longitude.toString();
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  void fetchProfiles() async {
    if (authController.user != null) {
      await homeController.fetchExploreList(
          linkMeWith: authController.user!.value.linkMeWith,
          nationality: authController.user!.value.countryCode.toString(),
          userID: authController.user!.value.uid!);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      appLifecycleState = state;
    });
    print(appLifecycleState);
  }
  String? replaceagerange;
  String? agerange;
  String? result;
  String? replacedistancerange;
  String? distancerange;
  String? result2;



  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkToken(context);
    fetchProfiles();
    homeController.missedMessage();
    _getCurrentUserLocation();
    super.initState();
     replaceagerange = "${authController.ageRangeValues.toString()}";
    agerange = authController.ageRangeValues.toString();
    result = replaceagerange!
        .replaceAll(authController.ageRangeValues.toString(), agerange!)
        .replaceAll("RangeValues", "");
    replacedistancerange = "${authController.distanceRangeValue.toString()}";
    distancerange = authController.distanceRangeValue.toString();
    result2 = replacedistancerange!
        .replaceAll(
            authController.distanceRangeValue.toString(), distancerange!)
        .replaceAll("RangeValues", "");

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    homeController.timer?.value.cancel();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('calls')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((e) {
      if (getAppLifecycleState == AppLifecycleState.resumed) {
        print(getAppLifecycleState);
        if (e.data() != null) {
          var jsonObject = e.data()!;
          if (jsonObject['receiver'] ==
                  FirebaseAuth.instance.currentUser!.uid &&
              jsonObject['response'] == 'Awaiting') {
            Map<String, dynamic> callInfo = {
              "channel_id": jsonObject['receiver'],
              "caller_picture": jsonObject['caller_picture'],
              "caller_name": jsonObject['caller_name'],
              "caller_uid": jsonObject['caller_uid'],
              "call_type": jsonObject['call_type'],
              "channel_name": jsonObject['channel_name']
            };
            Get.to(() => Incoming(callInfo));
          }

          // if (jsonObject['caller_uid'] == FirebaseAuth.instance.currentUser!.uid &&
          //     jsonObject['response'] == 'Awaiting') {
          //   Navigator.pushNamed(context, RoutePath.dial_call, arguments: {
          //     'call_type': jsonObject['call_type'],
          //     'channel_id': jsonObject['channel_id'],
          //     'receiver': chatController.endUser,
          //     'receiver_id': jsonObject['receiver']
          //   });
          // }
        }
      }
    });

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    // replaceagerange = "${authController.ageRangeValues.toString()}";
    // agerange = authController.ageRangeValues.toString();
    // result = replaceagerange!
    //     .replaceAll(authController.ageRangeValues.toString(), agerange!)
    //     .replaceAll("RangeValues", "");
    // replacedistancerange = "${authController.ageRangeValues.toString()}";
    // distancerange = authController.ageRangeValues.toString();
    // result2 = replaceagerange!
    //     .replaceAll(
    //         authController.distanceRangeValue.toString(), distancerange!)
    //     .replaceAll("RangeValues", "");
    // print(result);

    return GetBuilder(
      init: authController,
      builder: (_) {
        if (authController.user?.value == null) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Stack(
            children: [
              WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                      backgroundColor: Color.fromARGB(255, 240, 245, 248),
                      appBar: AppBar(
                        elevation: 0,
                        centerTitle: true,
                        title: Image.asset(
                          "assets/Vector Smart Object 2.png",
                          height: 60,
                          width: 70,
                        ),
                        backgroundColor: Color.fromARGB(255, 56, 171, 216),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(Short1());
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return HomePage();
                                    }));
                                    showModalBottomSheet(
                                      context: context,
                                      barrierColor: Colors.transparent,
                                      backgroundColor: Colors.white,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          margin: EdgeInsets.all(20.0),
                                          height: 200,
                                          width: 300,
                                          child: Center(
                                            child: ListView(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          top: 0,
                                                          right: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                              barrierColor: Colors
                                                                  .transparent,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              elevation: 10,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            15)),
                                                              ),
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return Container(
                                                                    height: 250,
                                                                    width: 330,
                                                                    decoration: BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                            offset:
                                                                                Offset(1, 4),
                                                                            blurRadius:
                                                                                10,
                                                                            spreadRadius:
                                                                                5,
                                                                          ),
                                                                        ],
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(width: double.infinity),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8.0),
                                                                                child: Text(
                                                                                  "which_carribbean_or_latin_linkwith".tr,
                                                                                  style: TextStyle(fontFamily: "OpenSans", fontSize: 16, fontWeight: FontWeight.w500),
                                                                                  textAlign: TextAlign.start,
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  CountryCodePicker(
                                                                                    initialSelection: authController.user?.value.whichLatinCountryYouLinkedWith ?? "BS",
                                                                                    onChanged: (e) {
                                                                                      authController.updateNationality(e.name!, e.code!, e.dialCode!);
                                                                                    },
                                                                                    countryList: Utils.carribAndLatinCountry,
                                                                                    hideMainText: false,
                                                                                    textStyle: TextStyle(color: Colors.black),
                                                                                    showOnlyCountryWhenClosed: true,
                                                                                  ),
                                                                                  Image.asset('assets/arrow.jpg'),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),

                                                                        Container(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: double.infinity,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 8.0, top: 10, right: 8.0),
                                                                                child: Text(
                                                                                  "which_carrib_people_meet_from".tr,
                                                                                  style: TextStyle(fontFamily: "OpenSans", fontSize: 16, fontWeight: FontWeight.w500),
                                                                                  textAlign: TextAlign.start,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 160,
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: <Widget>[
                                                                                    Radio(
                                                                                      value: 'all',
                                                                                      groupValue: authController.meetFromPreference.value,
                                                                                      onChanged: (value) {
                                                                                        setState(() {
                                                                                          authController.updateMeetFromValues('', 'all', '');
                                                                                          authController.updateMeetFromPreference("all");
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    Text('all'.tr),
                                                                                    Radio(
                                                                                      value: 'other',
                                                                                      groupValue: authController.meetFromPreference.value,
                                                                                      onChanged: (value) {
                                                                                        setState(() {
                                                                                          authController.updateMeetFromPreference(value.toString());
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    Text('other'.tr),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              if (authController.meetFromPreference.value != "all")
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    CountryCodePicker(
                                                                                      initialSelection: authController.user?.value.linkMeWithCountryCode ?? authController.countryMeetFromCode.value,
                                                                                      onChanged: (e) {
                                                                                        setState(() {
                                                                                          authController.updateMeetFromValues(e.name!, e.code!, e.dialCode!);
                                                                                        });
                                                                                        // authController
                                                                                        //     .updateMeetFromValues(e.name!,
                                                                                        //         e.code!, e.dialCode!);
                                                                                      },
                                                                                      countryList: Utils.carribAndLatinCountry,
                                                                                      hideMainText: false,
                                                                                      textStyle: TextStyle(color: Colors.black),
                                                                                      showOnlyCountryWhenClosed: true,
                                                                                    ),
                                                                                    // Image.asset('assets/arrow.jpg'),
                                                                                  ],
                                                                                ),
                                                                              Center(
                                                                                child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    authController.addSetting(context);
                                                                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                                                      return HomePage();
                                                                                    }));
                                                                                  },
                                                                                  child: Text(
                                                                                    "Apply",
                                                                                    style: TextStyle(
                                                                                      fontFamily: "OpenSans",
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff38ABD8)),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        //
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                              });
                                                        },
                                                        child: Text(
                                                          "Link Up",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(0),
                                                        child: Image.asset(
                                                            "assets/arrow.jpg"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Divider(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          top: 0,
                                                          right: 20),
                                                  child: GestureDetector(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Show me",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 120,
                                                        ),
                                                        Text(
                                                          "${authController.linkmeWith}"
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(0),
                                                          child: Image.asset(
                                                              "assets/arrow.jpg"),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      // Get.to(Short2());
                                                      Navigator.pop(context);
                                                      showModalBottomSheet(
                                                          barrierColor: Colors
                                                              .transparent,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15)),
                                                          ),
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder: ((context,
                                                                    setState) {
                                                              return Container(
                                                                height: 250,
                                                                width: 340,
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        offset: Offset(
                                                                            1,
                                                                            4),
                                                                        blurRadius:
                                                                            10,
                                                                        spreadRadius:
                                                                            5,
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: ListView(
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                            Text(
                                                                      "Show Me",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "OpenSans",
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "Whichgender(s) would you like to see?",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "OpenSans",
                                                                            fontSize:
                                                                                16,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                154,
                                                                                154,
                                                                                154)),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Radio(
                                                                              value: 'Female',
                                                                              groupValue: authController.user?.value.linkMeWith ?? authController.linkmeWith.value,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  authController.updateLinkMeWith(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                            Text('female'.tr),
                                                                          ],
                                                                        ),

                                                                        // SizedBox(
                                                                        //   width: 2,
                                                                        // ),
                                                                        Row(
                                                                          children: [
                                                                            Radio(
                                                                              value: 'Male',
                                                                              groupValue: authController.user?.value.linkMeWith ?? authController.linkmeWith.value,
                                                                              onChanged: (value) {
                                                                                print(value);
                                                                                setState(() {
                                                                                  authController.updateLinkMeWith(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                            Text('male'.tr),
                                                                          ],
                                                                        ),

                                                                        // SizedBox(
                                                                        //   width: 2,
                                                                        // ),
                                                                        Row(
                                                                          children: [
                                                                            Radio(
                                                                              value: 'Both',
                                                                              groupValue: authController.user?.value.linkMeWith ?? authController.linkmeWith.value,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  authController.updateLinkMeWith(value.toString());
                                                                                });
                                                                              },
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text('both'.tr),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              65,
                                                                          right:
                                                                              65),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          authController
                                                                              .addSetting(context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (_) {
                                                                            return HomePage();
                                                                          }));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Apply",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Color(0xff38ABD8)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }));
                                                          });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Divider(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          top: 0,
                                                          right: 20),
                                                  child: GestureDetector(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Age range",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                          ),
                                                          Text(
                                                            result.toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(width: 22),
                                                          ClipRRect(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(0),
                                                            child: Image.asset(
                                                                "assets/arrow.jpg"),
                                                          ),
                                                          // Text(
                                                          //   "23-30",
                                                          // ),
                                                          // ClipRRect(
                                                          //   borderRadius:
                                                          //       new BorderRadius
                                                          //           .circular(0),
                                                          //   child: Image.asset(
                                                          //       "assets/arrow.jpg"),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      // Get.to(Short3());

                                                      Navigator.pop(context);
                                                      showModalBottomSheet(
                                                          barrierColor: Colors
                                                              .transparent,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15)),
                                                          ),
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                height: 250,
                                                                width: 340,
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.5),
                                                                        offset: Offset(
                                                                            1,
                                                                            4),
                                                                        blurRadius:
                                                                            10,
                                                                        spreadRadius:
                                                                            5,
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: ListView(
                                                                  children: [
                                                                    Center(
                                                                        child:
                                                                            Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              30),
                                                                      child:
                                                                          Text(
                                                                        "Age Range",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "OpenSans",
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    )),
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 15,
                                                                              left: 160),
                                                                          child:
                                                                              Text("18 - 100"),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              20),
                                                                      child:
                                                                          RangeSlider(
                                                                        values: authController
                                                                            .ageRangeValues
                                                                            .value,
                                                                        min: 18,
                                                                        max:
                                                                            100,
                                                                        divisions:
                                                                            90,
                                                                        inactiveColor:
                                                                            Colors.grey,
                                                                        activeColor:
                                                                            Color(0xff38ABD8),
                                                                        labels:
                                                                            RangeLabels(
                                                                          authController
                                                                              .ageRangeValues
                                                                              .value
                                                                              .start
                                                                              .round()
                                                                              .toString(),
                                                                          authController
                                                                              .ageRangeValues
                                                                              .value
                                                                              .end
                                                                              .round()
                                                                              .toString(),
                                                                        ),
                                                                        onChanged:
                                                                            (RangeValues
                                                                                values) {
                                                                          setState(
                                                                              () {
                                                                            authController.updateAgeRangeValue(values);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              20,
                                                                          left:
                                                                              65,
                                                                          right:
                                                                              65),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          authController
                                                                              .addSetting(context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (_) {
                                                                            return HomePage(
                                                                                // age: actLocation1,

                                                                                );
                                                                          }));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Apply",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Color(0xff38ABD8)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Divider(),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            top: 0,
                                                            right: 20),
                                                    child: GestureDetector(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Distance (M)",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          SizedBox(
                                                            width: 120,
                                                          ),
                                                          Text(
                                                            result2.toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(0),
                                                            child: Image.asset(
                                                                "assets/arrow.jpg"),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        // Get.to(Short3());

                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                            barrierColor: Colors
                                                                .transparent,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            elevation: 10,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                return Container(
                                                                  height: 250,
                                                                  width: 340,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          offset: Offset(
                                                                              1,
                                                                              4),
                                                                          blurRadius:
                                                                              10,
                                                                          spreadRadius:
                                                                              5,
                                                                        ),
                                                                      ],
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child:
                                                                      ListView(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 10),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Distance (km)",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 6),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "How far would you like to search",
                                                                            style:
                                                                                TextStyle(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 30),
                                                                        child:
                                                                            RangeSlider(
                                                                          values: authController
                                                                              .distanceRangeValue
                                                                              .value,
                                                                          min:
                                                                              1,
                                                                          max:
                                                                              1000,
                                                                          divisions:
                                                                              100,
                                                                          inactiveColor:
                                                                              Colors.grey,
                                                                          activeColor:
                                                                              Color(0xff38ABD8),
                                                                          labels:
                                                                              RangeLabels(
                                                                            authController.distanceRangeValue.value.start.round().toString(),
                                                                            authController.distanceRangeValue.value.end.round().toString(),
                                                                          ),
                                                                          onChanged:
                                                                              (RangeValues values) {
                                                                            setState(() {
                                                                              authController.updateDistanceValue(values);
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                30,
                                                                            left:
                                                                                65,
                                                                            right:
                                                                                65),
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            authController.addSetting(context);

                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (_) {
                                                                              return HomePage();
                                                                            }));
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Apply",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          style:
                                                                              ElevatedButton.styleFrom(backgroundColor: Color(0xff38ABD8)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              });
                                                            });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Divider(),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          bottom: 20,
                                                          right: 20),
                                                  child: GestureDetector(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Additional options",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(0),
                                                          child: Image.asset(
                                                              "assets/arrow.jpg"),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      // Get.to(Short5());
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/candle.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(NotificationPage());
                                  },
                                  child: Icon(
                                    Icons.notifications_none,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      drawer: Drawer(
                        backgroundColor: Color(0XFF4E5B81),
                        child: DrawerScreen(),
                      ),
                      body: Stack(
                        children: [
                          Image.asset("assets/Group 163959.png"),
                          Container(
                              height: 50,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  image:
                                      DecorationImage(image: AssetImage(""))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (_) => LiveHomePage()),
                                      // );
                                      if (authController.user?.value.isClub ==
                                              null ||
                                          authController.user?.value.isClub ==
                                              false) {
                                        authController
                                            .alert1("please_subscribe".tr);
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LiveHomePage()),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/Group 4 copy 3.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                      color:
                                          authController.user?.value.isClub ==
                                                      null ||
                                                  authController
                                                          .user?.value.isClub ==
                                                      false
                                              ? Colors.grey
                                              : Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/Group 4 copy 4.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, RoutePath.profile_page);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ProfilePage();
                                      }));
                                    },
                                  ),
                                  InkWell(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/Group 4 copy 5.png',
                                          width: 50,
                                          fit: BoxFit.fill,
                                        ),
                                        GetBuilder(
                                          init: authController,
                                          builder: (_) {
                                            if (authController.user == null) {
                                              return SizedBox();
                                            }
                                            return Positioned(
                                              right: 0,
                                              top: 0,
                                              child: StreamBuilder(
                                                stream: db
                                                    .collection('matches')
                                                    .doc(authController
                                                        .user!.value.uid)
                                                    .collection('matches')
                                                    .where('me',
                                                        isEqualTo: false)
                                                    .where('friend',
                                                        isEqualTo: true)
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapShot) {
                                                  if (!snapShot.hasData) {
                                                    return new Container();
                                                  } else if (snapShot
                                                          .data?.docs.length ==
                                                      0) {
                                                    return Container();
                                                  }
                                                  return Container(
                                                    width: 18,
                                                    height: 18,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle),
                                                    child: Text(
                                                      snapShot.data?.docs.length
                                                              .toString() ??
                                                          '',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, RoutePath.chat_home_page);
                                      // Navigator.pushNamed(
                                      //     context, RoutePath.like_me_page);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return LikesMePage();
                                      }));
                                    },
                                  ),
                                  InkWell(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/Group 4 copy 5f.png',
                                          width: 50,
                                          fit: BoxFit.fill,
                                        ),
                                        homeController.missedMessageLength
                                                    .value ==
                                                0
                                            ? Container()
                                            : Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 8,
                                                  height: 8,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .greenAccent[700],
                                                      shape: BoxShape.circle),
                                                ),
                                              )
                                      ],
                                    ),
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, RoutePath.chat_message_page);
                                      //  Navigator.pushNamed(
                                      // context, RoutePath.chat_home_page);
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (_) {
                                      //   ChatMessagePage(endUserID: "1", endUserName: "abc", chatID: "1",);
                                      // }));
                                      // Get.to(ChatMessagePage(endUserID: "1", endUserName: "abc", chatID: "1",));
                                      Get.to(ChatHomePage());
                                    },
                                  ),
                                  GetBuilder(
                                      init: authController,
                                      builder: (_) {
                                        return InkWell(
                                          child: Image.asset(
                                              "assets/Group 4 copy 6.png",
                                              // authController.user?.value.isClub !=
                                              //             null &&
                                              //         authController.user?.value
                                              //                 .isClub ==
                                              //             true
                                              //     ? 'assets/Group 4 copy 6.png'
                                              //     : 'assets/Group 4 copy 6.png',

                                              width: 50,
                                              fit: BoxFit.fill,
                                              color: authController
                                                          .user?.value.isClub ==
                                                      true
                                                  ? Color.fromARGB(
                                                      255, 213, 220, 22)
                                                  : Colors.grey),
                                          onTap: authController
                                                          .user?.value.isClub !=
                                                      null &&
                                                  authController
                                                          .user?.value.isClub ==
                                                      true
                                              ? () {
                                                  gotoPlaceListPage('club'.tr);
                                                }
                                              : () {
                                                  authController.alert1(
                                                      'please_enable_in_acc'
                                                          .tr);
                                                },
                                        );
                                      }),
                                  GetBuilder(
                                      init: authController,
                                      builder: (_) {
                                        return InkWell(
                                          child: Image.asset(
                                              // authController.user?.value
                                              //             .isRestaurant ==
                                              //         true
                                              //     ? 'assets/Group 4 copy 6d.png'
                                              //     : 'assets/Group 4 copy 6d.png',
                                              "assets/Group 4 copy 6d.png",
                                              width: 50,
                                              fit: BoxFit.fill,
                                              color: authController.user?.value
                                                              .isRestaurant !=
                                                          null &&
                                                      authController.user?.value
                                                              .isRestaurant ==
                                                          true
                                                  ? Color.fromARGB(
                                                      255, 213, 220, 22)
                                                  : Colors.grey),
                                          onTap: authController.user?.value
                                                          .isRestaurant !=
                                                      null &&
                                                  authController.user?.value
                                                          .isRestaurant ==
                                                      true
                                              ? () {
                                                  gotoPlaceListPage(
                                                      'restaurant'.tr);
                                                }
                                              : () {
                                                  authController.alert1(
                                                      'please_enable_acc'.tr);
                                                },
                                        );
                                      }),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 52),
                            child: GetBuilder(
                                init: homeController,
                                builder: (_) {
                                  return Container(
                                    height: 620,
                                    width: 750,
                                    child: SwipeCardStack(
                                      key: _swipeKey,
                                      children:
                                          homeController.swipeCards.map((data) {
                                        return SwiperItem(builder:
                                            (SwiperPosition position,
                                                double progress) {
                                          if (data.runtimeType == UserModel) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                // color: Color.fromARGB(
                                                //     255, 56, 171, 216),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              ),
                                              child: Card(
                                                child: Stack(
                                                  children: <Widget>[
                                                    SizedBox.expand(
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        child: Image(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            data.avatar,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/${data.whichLatinCountryYouLinkedWith.toLowerCase()}.png'),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(WhyAre());
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 40),
                                                        child: Text(
                                                          data.whyarewehere,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox.expand(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              Colors.black54
                                                            ],
                                                            begin: Alignment
                                                                .center,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: position
                                                                  .toString()
                                                                  .substring(
                                                                      15) ==
                                                              "None"
                                                          ? Container()
                                                          : RotationTransition(
                                                              turns:
                                                                  new AlwaysStoppedAnimation(
                                                                      -15 /
                                                                          360),
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        top: 5,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            5),
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .green,
                                                                        width:
                                                                            3)),
                                                                child: Text(
                                                                  position.toString().substring(
                                                                              15) ==
                                                                          "Up"
                                                                      ? "love_it"
                                                                          .tr
                                                                      : position.toString().substring(15) ==
                                                                              "Right"
                                                                          ? "LinkUp"
                                                                              .tr
                                                                          : "NAH"
                                                                              .tr,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (_) {
                                                          return WhyAre();
                                                        }));
                                                      },
                                                      // child: Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.only(
                                                      //           top: 35, left: 7),
                                                      //   child: Text(
                                                      //   // authController.actLocation.value,
                                                      //     // authController.actLocation.value,
                                                      //    style: TextStyle(
                                                      //  fontFamily: "OpenSans",
                                                      //         color: Colors.white,
                                                      //         fontSize: 16),
                                                      //   ),
                                                      // ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    16.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  constraints:
                                                                      BoxConstraints(
                                                                    maxWidth: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.6,
                                                                  ),
                                                                  child: Text(
                                                                      (data.firstName) +
                                                                          ' ' +
                                                                          (data
                                                                              .lastName),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "OpenSans",
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              24.0,
                                                                          fontWeight:
                                                                              FontWeight.w700)),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                if (!data
                                                                    .showMyAge)
                                                                  GetBuilder(
                                                                      init:
                                                                          authController,
                                                                      builder:
                                                                          (_) {
                                                                        return Text(
                                                                            data.age
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 20.0,
                                                                            ));
                                                                      }),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              width: 250,
                                                              child: Text(
                                                                  (data.aboutMe).length >
                                                                          100
                                                                      ? (data.aboutMe).substring(
                                                                              0,
                                                                              100) +
                                                                          ' . . . '
                                                                      : data
                                                                          .aboutMe,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(data.job,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10.0,
                                                                horizontal:
                                                                    10.0),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: Colors.white,
                                                            size: 30,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RoutePath
                                                                    .user_detail_page,
                                                                arguments: {
                                                                  'end_user':
                                                                      data
                                                                });
                                                            // Get.to(
                                                            //     CurrentLocation());
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color: Colors.black,
                                                            size: 30,
                                                          ),
                                                          onPressed: () {
                                                            _selectAbuseDialog(
                                                                context,
                                                                data,
                                                                height,
                                                                width,
                                                                padding);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              ),
                                              child: Card(
                                                child: Stack(
                                                  children: <Widget>[
                                                    SizedBox.expand(
                                                      child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              data.image,
                                                            ),
                                                          )),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text(
                                                        'ADS',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                        });
                                      }).toList(),
                                      visibleCount: 10,
                                      stackFrom: StackFrom.None,
                                      translationInterval: 6,
                                      scaleInterval: 0.03,
                                      historyCount: 5,
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      onEnd: () => debugPrint("onEnd"),
                                      onSwipe: (int index,
                                          SwiperPosition position) async {
                                        if (homeController.swipeCards[index]
                                                .runtimeType ==
                                            UserModel) {
                                          var totalSwiped =
                                              await FirebaseFirestore.instance
                                                  .collection('swipes')
                                                  .doc(authController
                                                      .user?.value.uid)
                                                  .collection('seen_by_date')
                                                  .where('date',
                                                      isEqualTo: AppConstant()
                                                          .getTodaysDate())
                                                  .get();

                                          if (totalSwiped.docs.length >= 25 &&
                                              authController
                                                      .user?.value.isClub ==
                                                  false) {
                                            _swipeKey.currentState?.rewind();
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  'you_have_reached_free_limit'
                                                      .tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pushNamed(
                                                          context,
                                                          RoutePath
                                                              .subscription_page_one);
                                                    },
                                                    child:
                                                        Text('buy_premium'.tr),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .red)),
                                                    child: Text('close'.tr),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            chatController.addSeenToDb(
                                              userId: authController
                                                  .user!.value.uid!,
                                              friendId: homeController
                                                      .swipeCards[_swipeKey
                                                              .currentState!
                                                              .currentIndex +
                                                          1]
                                                      .uid ??
                                                  '',
                                            );
                                            if (position ==
                                                SwiperPosition.Right) {
                                              chatController.matchesLike(
                                                  context,
                                                  homeController
                                                          .swipeCards[_swipeKey
                                                                  .currentState!
                                                                  .currentIndex +
                                                              1]
                                                          .uid ??
                                                      '',
                                                  homeController
                                                      .swipeCards[_swipeKey
                                                              .currentState!
                                                              .currentIndex +
                                                          1]
                                                      .avatar);
                                            } else if (position ==
                                                SwiperPosition.Left) {
                                              chatController.matchesDislike(
                                                  context,
                                                  homeController
                                                          .swipeCards
                                                          .value[_swipeKey
                                                                  .currentState!
                                                                  .currentIndex +
                                                              1]
                                                          .uid ??
                                                      '');
                                            } else if (position ==
                                                SwiperPosition.Up) {
                                              superLike(homeController
                                                      .swipeCards[_swipeKey
                                                              .currentState!
                                                              .currentIndex +
                                                          1]
                                                      .uid ??
                                                  '');
                                            }
                                          }
                                        } else {
                                          if (position ==
                                              SwiperPosition.Right) {
                                            String url = homeController
                                                .swipeCards[index]['www'];

                                            url = url.contains('www.')
                                                ? url.replaceAll(
                                                    'www.', 'https://')
                                                : url;

                                            launchUrl(Uri.parse(url));
                                          }
                                        }
                                      },
                                      onRewind: (int index,
                                              SwiperPosition position) =>
                                          debugPrint(
                                              "onRewind $index $position"),
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 660),
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: Image.asset(
                                      'assets/Group 4 copy.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      _swipeKey.currentState?.rewind();
                                    },
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/Group 4.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      _swipeKey.currentState?.swipeLeft();
                                    },
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/Group 5.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      _swipeKey.currentState?.swipeRight();
                                    },
                                  ),
                                  InkWell(
                                    child: Image.asset(
                                      'assets/Group 164012.png',
                                      width: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    onTap: () {
                                      _swipeKey.currentState?.swipeUp();
                                    },
                                  ),
                                  GetBuilder(
                                      init: authController,
                                      builder: (_) {
                                        return InkWell(
                                          child: Image.asset(
                                              authController.user?.value
                                                              .isTopShelf !=
                                                          null &&
                                                      authController.user?.value
                                                              .isTopShelf ==
                                                          true
                                                  ? 'assets/topshelf.png'
                                                  : 'assets/topshelf.png',
                                              width: 55,
                                              fit: BoxFit.fill,
                                              color: authController.user?.value
                                                          .isTopShelf ==
                                                      true
                                                  ? Color(0xffD8DD15)
                                                  : Colors.grey),
                                          onTap: authController.user?.value
                                                          .isTopShelf !=
                                                      null &&
                                                  authController.user?.value
                                                          .isTopShelf ==
                                                      true
                                              ? () {
                                                  topShelf();
                                                }
                                              : () {
                                                  authController.alert1(
                                                      'please_enable_acc'.tr);
                                                },
                                        );
                                      }),
                                  GetBuilder(
                                      init: authController,
                                      builder: (_) {
                                        return InkWell(
                                            child: Image.asset(
                                              'assets/event.png',
                                              // authController.user?.value
                                              //                 .isTopShelf !=
                                              //             null &&
                                              //         authController.user?.value
                                              //                 .isTopShelf ==
                                              //             true
                                              //     ? 'assets/topshelf.png'
                                              //     : 'assets/topshelf.png',
                                              width: 55,
                                              fit: BoxFit.fill,
                                              // color: Color(0xffD8DD15),
                                              // color: authController
                                              //             .user?.value.isTopShelf ==
                                              //         true
                                              //     ? Colors.green
                                              // : Color(0xffD8DD15)),
                                            ),
                                            onTap: () {
                                              Get.to(SplashEvents());
                                            }

                                            // authController
                                            //                 .user?.value.isTopShelf !=
                                            //             null &&
                                            //         authController
                                            //                 .user?.value.isTopShelf ==
                                            //             true
                                            //     ? () {
                                            //         topShelf();
                                            //       }
                                            //     : () {
                                            //         authController.alert1(
                                            //             'please_enable_acc'.tr);
                                            // },
                                            );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          );
        }
      },
    );
  }
}

enum Location { Men, Women, Everyone }

enum Location1 {
  twenty2,
  twenty3,
  twenty4,
  twenty5,
  twenty6,
  twenty7,
  twenty8,
  twenty9,
}

enum Location2 {
  hundred1,
  hundred2,
  hundred3,
  hundred4,
  hundred5,
  hundred6,
  hundred7,
  hundred8,
  hundred9,
  hundred10,
  wholecountry,
}

enum Location3 { all, other }
