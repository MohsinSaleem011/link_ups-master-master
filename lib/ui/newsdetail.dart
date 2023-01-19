import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'DrawerScreen.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key? key}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0XFF4E5B81),
        child: DrawerScreen(),
      ),
      body: Stack(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image/Rectangle.png"),
                  fit: BoxFit.cover),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'News Detail',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ]),
          ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Image.asset("assets/Group 1.png"),
                )

        ],
      ),
    );
  }
}
