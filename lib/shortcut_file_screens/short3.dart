import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Short3 extends StatefulWidget {
  @override
  State<Short3> createState() => _Short3State();
}

class _Short3State extends State<Short3> {
  @override
  Widget build(BuildContext context) {
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
                        Image.asset(
                          "assets/filter-search.png",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Image.asset("assets/Group 163981.png"),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset("assets/Layer 31.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28, top: 430, right: 13),
                        child: Container(
                          height: 200,
                          width: 330,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(1, 4),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListView(
                            children: [
                              Center(
                                child: Text(
                                  "Age Range",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 8, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "22",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Text(
                                      "27",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    )
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "23",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Text(
                                      "24",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    )
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "23",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Text(
                                      "29",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 612, left: 55, right: 52),
                        child: Stack(children: [
                          Image.asset("assets/Rectangle 23327.jpg"),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 115),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: "OpenSans", color: Colors.white),
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
