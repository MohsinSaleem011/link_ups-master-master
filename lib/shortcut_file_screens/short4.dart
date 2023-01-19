import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Short4 extends StatefulWidget {
  // const Short4({super.key});

  @override
  State<Short4> createState() => _Short4State();
}

class _Short4State extends State<Short4> {
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
                            left: 29, top: 420, right: 13),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Text(
                                    "Distance (km)",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Center(
                                  child: Text(
                                    "How far would you like to search",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Center(
                                  child: Text(
                                    "160",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Center(
                                  child: Text(
                                    "Which Country",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 600, left: 50, right: 50),
                        child: Stack(
                          children: [
                            Image.asset("assets/Rectangle 23327.jpg"),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, left: 120),
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
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
