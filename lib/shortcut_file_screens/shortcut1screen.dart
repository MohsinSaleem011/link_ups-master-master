import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/shortcut_file_screens/short3.dart';
import 'package:link_up/shortcut_file_screens/short4.dart';
import 'package:link_up/shortcut_file_screens/short5.dart';
import 'package:link_up/shortcut_file_screens/shortcut2.dart';

class Short1 extends StatefulWidget {
  // const Short1({super.key});

  @override
  State<Short1> createState() => _Short1State();
}

class _Short1State extends State<Short1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Image.asset("assets/appbar-removebg-preview.png"),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 127, top: 0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/Vector Smart Object 2.png",
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        GestureDetector(
                          child: Image.asset(
                            "assets/filter-search.png",
                            width: 30,
                            height: 30,
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              barrierColor: Colors.transparent,
                              backgroundColor: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Link Up",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        0),
                                                child: Image.asset(
                                                    "assets/arrow.jpg"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0, right: 20),
                                          child: GestureDetector(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Show me",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                ),
                                                Text("Women"),
                                                ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          0),
                                                  child: Image.asset(
                                                      "assets/arrow.jpg"),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.to(Short2());
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0, right: 20),
                                          child: GestureDetector(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Age range",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                ),
                                                Text(
                                                  "23-30",
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          0),
                                                  child: Image.asset(
                                                      "assets/arrow.jpg"),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.to(Short3());
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0, right: 20),
                                          child: GestureDetector(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Distance (M)",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Whole Country",
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          0),
                                                  child: Image.asset(
                                                      "assets/arrow.jpg"),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.to(Short4());
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Divider(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 20, right: 20),
                                          child: GestureDetector(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Additional options",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          0),
                                                  child: Image.asset(
                                                      "assets/arrow.jpg"),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.to(Short5());
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
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Image.asset("assets/Group 163981.png"),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Stack(
                  //   children: [
                  // Image.asset(
                  //   "assets/Layer 31.png",
                  //   height: height / 1.2,
                  //   width: width,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 30, top: 410, right: 13),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 237,
                  //     width: 330,
                  //     decoration: BoxDecoration(
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             offset: Offset(1, 4),
                  //             blurRadius: 10,
                  //             spreadRadius: 5,
                  //           ),
                  //         ],
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: ListView(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, top: 0, right: 20),
                  //           child: Row(
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "Link Up",
                  //                style: TextStyle(
                  //                     fontSize: 15,
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               ClipRRect(
                  //                 borderRadius:
                  //                     new BorderRadius.circular(0),
                  //                 child: Image.asset("assets/arrow.jpg"),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Divider(),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, top: 0, right: 20),
                  //           child: GestureDetector(
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Show me",
                  //                  style: TextStyle(
                  //                       fontSize: 15,
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 120,
                  //                 ),
                  //                 Text("Women"),
                  //                 ClipRRect(
                  //                   borderRadius:
                  //                       new BorderRadius.circular(0),
                  //                   child: Image.asset("assets/arrow.jpg"),
                  //                 ),
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               Get.to(Short2());
                  //             },
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Divider(),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, top: 0, right: 20),
                  //           child: GestureDetector(
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Age range",
                  //                  style: TextStyle(
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 15),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 100,
                  //                 ),
                  //                 Text(
                  //                   "23-30",
                  //                 ),
                  //                 ClipRRect(
                  //                   borderRadius:
                  //                       new BorderRadius.circular(0),
                  //                   child: Image.asset("assets/arrow.jpg"),
                  //                 ),
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               Get.to(Short3());
                  //             },
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Divider(),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, top: 0, right: 20),
                  //           child: GestureDetector(
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Distance (M)",
                  //                  style: TextStyle(
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 15),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 40,
                  //                 ),
                  //                 Text(
                  //                   "Whole Country",
                  //                 ),
                  //                 ClipRRect(
                  //                   borderRadius:
                  //                       new BorderRadius.circular(0),
                  //                   child: Image.asset("assets/arrow.jpg"),
                  //                 ),
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               Get.to(Short4());
                  //             },
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Divider(),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 20, bottom: 20, right: 20),
                  //           child: GestureDetector(
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   "Additional options",
                  //                  style: TextStyle(
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 15),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 40,
                  //                 ),
                  //                 ClipRRect(
                  //                   borderRadius:
                  //                       new BorderRadius.circular(0),
                  //                   child: Image.asset("assets/arrow.jpg"),
                  //                 ),
                  //               ],
                  //             ),
                  //             onTap: () {
                  //               Get.to(Short5());
                  //             },
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 40,
                  //         ),
                  //       ],
                  //     ),x
                  //   ),
                  // ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              //   ],
              // ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
