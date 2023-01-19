import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:get/get.dart';

class CassiusStuart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find(tag: AuthController().toString());
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 210,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/image/Group 163959 (3).png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/image/Vector Smart Objectsss.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListView(
            children: [
              Column(
                children: [
                  Image.asset("assets/image/Vector Smart Object 2 (1).png"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/image/Group 163997 (1).png",
                height: 220,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${authController.user!.value.firstName}",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Color.fromARGB(255, 56, 171, 216),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "40",
                        style: TextStyle(fontFamily: "OpenSans", fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/image/male-gender (1).png"),
                            Text(
                              "Straight Man",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 26,
                        width: 157,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/image/distance (1).png"),
                            Text(
                              "Lives in Bahamas",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 26,
                    width: 137,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/image/location(4) (3).png"),
                        Text(
                          "53 Miles away",
                          style:
                              TextStyle(fontFamily: "OpenSans", fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  const Text(
                    "Photos",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset("assets/image/Group 163989 (3).png"),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Interests",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 23,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Photography",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 79,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Cooking",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 79,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Dancing",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 86,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromARGB(255, 56, 171, 216)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Shopping",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "University",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 24,
                    width: 79,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "FDU",
                          style:
                              TextStyle(fontFamily: "OpenSans", fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 219, 239, 246),
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Job",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      color: Color.fromARGB(255, 56, 171, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 24,
                    width: 79,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          width: 1.5, color: Color.fromARGB(255, 56, 171, 216)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Boss",
                          style:
                              TextStyle(fontFamily: "OpenSans", fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/image/Group 4 (1).png"),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/image/Group 5 (1).png"),
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset("assets/image/Group 164006 (1).png"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
