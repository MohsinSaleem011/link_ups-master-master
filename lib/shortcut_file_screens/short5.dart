import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Short5 extends StatefulWidget {
  // const Short5({super.key});

  @override
  State<Short5> createState() => _Short5State();
}

class _Short5State extends State<Short5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
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
                      padding:
                          const EdgeInsets.only(left: 28, top: 420, right: 13),
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
                              padding: const EdgeInsets.only(top: 22),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Text(
                                    "Which Caribbean or Latin country are you linked with?",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 10),
                              child: Row(
                                children: [
                                  Image.asset("assets/Ellipse 2117.jpg"),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "Brasil",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Text(
                                    "Which Caribbean or Latin country would you like to meet people from?",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, top: 10, right: 18),
                              child: Row(
                                children: [
                                  Image.asset("assets/Ellipse 2117.jpg"),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "All",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Image.asset("assets/Ellipse 2117.jpg"),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Text(
                                    "Other",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 600, left: 50, right: 50),
                      child: Stack(
                        children: [
                          Image.asset("assets/Rectangle 23327.jpg"),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 120),
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: "OpenSans", color: Colors.white),
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
    );
  }
}
