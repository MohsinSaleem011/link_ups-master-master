import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/newsdetail.dart';
import '../ui/DrawerScreen.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Color(0XFF4E5B81),
          child: DrawerScreen(),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Group 163959 (1).jpg"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          'NEWS',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),
              ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),
              ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
              SizedBox(height: 15,),
              ListTile(
                leading: Image.asset(
                  "assets/image/Vector.png",
                  height: 60,
                  width: 60,
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "5th Sept, 2022",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            110,
                            110,
                            110,
                          ),
                          fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "News Heading",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("adipiscing elit. Aenean commodo ligula eget dolor.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 11)),
                  ],
                ),
                onTap: () {
                  Get.to(NewsDetail());
                },
              ),
            ],
          ),
        ));
  }
}
