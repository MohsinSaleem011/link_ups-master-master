import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/ui/home_page.dart';

class WhyAre extends StatefulWidget {
  const WhyAre({Key? key}) : super(key: key);

  @override
  State<WhyAre> createState() => _WhyAreState();
}

class _WhyAreState extends State<WhyAre> {
  AuthController authController = Get.find(tag: AuthController().toString());
  Location location = Location.livingRoom;
  String actualLocation = 'Here to Party';
  // final TextEditingController locationOthersController =
  //     new TextEditingController();

  // Widget selectLocationWidget() {
  //   return Column(
  //     children: <Widget>[
  //       RadioListTile<Location>(
  //         title: const Text('Living Room'),
  //         value: Location.livingRoom,
  //         groupValue: location,
  //         onChanged: (value) {
  //           setState(() {
  //             location = value!;
  //             actualLocation = 'Living Room';
  //           });
  //         },
  //       ),
  //       RadioListTile<Location>(
  //         title: const Text('Bedroom'),
  //         value: Location.bedroom,
  //         groupValue: location,
  //         onChanged: (value) {
  //           setState(() {
  //             location = value!;
  //             actualLocation = 'Bedroom';
  //           });
  //         },
  //       ),
  //       RadioListTile<Location>(
  //         title: const Text('Kitchen'),
  //         value: Location.kitchen,
  //         groupValue: location,
  //         onChanged: (value) {
  //           setState(() {
  //             location = value!;
  //             actualLocation = 'Kitchen';
  //           });
  //         },
  //       ),

  //       RadioListTile<Location>(
  //         title: const Text('others'),
  //         value: Location.kitchen,
  //         groupValue: location,
  //         onChanged: (value) {
  //           setState(() {
  //             location = value!;
  //             actualLocation = 'others';
  //           });
  //         },
  //       ),

  //       RadioListTile<Location>(
  //         title: const Text('mohsin'),
  //         value: Location.kitchen,
  //         groupValue: location,
  //         onChanged: (value) {
  //           setState(() {
  //             location = value!;
  //             actualLocation = 'mohsin';
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: ListView(
        children: [
          Container(
            width: 230,
            height: 243,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/appbar.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 300,
                    child: Image.asset("assets/LinkUp App Login 2.png")),
                Text(
                  "Why are you here",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.white,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Tell People why are you here",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 29,
              top: 18,
            ),
            child: Text(
              "We’ll share this on your profile. You can",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 17,
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 65,
              top: 10,
            ),
            child: Text(
              "change it whenever you want.",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 17,
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<Location>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Here to Party',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "I'm looking for good fete",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                      value: Location.livingRoom,
                      groupValue: location,
                      onChanged: (value) {
                        setState(() {
                          location = value!;
                          authController.actLocation.value = 'Here to Party';
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Radio(value: 0, groupValue: 0, onChanged: (_) {})
              // SizedBox(
              //    width: 120,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/Tell People.png"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<Location>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Here to Link Up',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "I'm looking for someone nice nothing serious",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                      value: Location.bedroom,
                      groupValue: location,
                      onChanged: (value) {
                        setState(() {
                          location = value!;
                          authController.actLocation.value = 'Here to Link Up';
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Radio(value: 0, groupValue: 0, onChanged: (_) {})
              // SizedBox(
              //   width: 40,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/Tell People (1).png"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<Location>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Here for Casual Chat',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "I'm here for nothing serious",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                      value: Location.kitchen,
                      groupValue: location,
                      onChanged: (value) {
                        setState(() {
                          location = value!;
                          authController.actLocation.value =
                              'Here for Casual Chat';
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Radio(value: 0, groupValue: 0, onChanged: (_) {})
              // SizedBox(
              //   width: 105,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/Tell People (2).png"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<Location>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Here to make friends',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "I'm here to meet friends from the region",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                      value: Location.others,
                      groupValue: location,
                      onChanged: (value) {
                        setState(() {
                          location = value!;
                          authController.actLocation.value =
                              'Here to make friends';
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Radio(value: 0, groupValue: 0, onChanged: (_) {})
              // SizedBox(
              //   width: 66,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/Tell People (3).png"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<Location>(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Look for something serious',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "I'm here looking for serious relationship",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.grey,
                                fontSize: 12),
                          )
                        ],
                      ),
                      value: Location.mohsin,
                      groupValue: location,
                      onChanged: (value) {
                        setState(() {
                          location = value!;
                          authController.actLocation.value =
                              'Look for something serious';
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Radio(value: 0, groupValue: 0, onChanged: (_) {})
              // SizedBox(
              //   width: 50,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset("assets/Tell People (4).png"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
              onPressed: () {
                authController.updateProfile(context: context);
                print("Mohsin");
                new Timer(const Duration(seconds: 1), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return HomePage();
                  }));
                });
              },
              child: Text(
                "Add To Profile",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.white,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff38ABD8)),
            ),
          )
        ],
      ),
    );
  }
}

enum Location { livingRoom, bedroom, kitchen, others, mohsin }
