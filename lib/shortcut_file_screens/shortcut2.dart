import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Short2 extends StatefulWidget {
  // const Short2({super.key});

  @override
  State<Short2> createState() => _Short2State();
}

class _Short2State extends State<Short2> {
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
                    padding: const EdgeInsets.only(
                      left: 127,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/Vector Smart Object 2.png",
                          width: 130,
                          height: 120,
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
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                            left: 25, top: 420, right: 13),
                        child: Container(
                          height: 240,
                          width: 340,
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
                              Text(
                                "Show Me",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Center(
                                    child: Text(
                                  "Whichgender(s) would you like to see?",
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 15, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Women",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                    left: 20, top: 8, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Men",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                    left: 20, top: 8, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Everyone",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 645, left: 55, right: 52),
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
              )
            ],
          ),
        ]),
      ),
    );
  }
}
