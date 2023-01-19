import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'DrawerScreen.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? originalString;
  List<String>? substring;
  @override
  Widget build(BuildContext context) {
    //  originalString = "This is a test string";
    //  substring = originalString!.split(" ");
    //  print("Mohsinsaleem");
    //  print(substring);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0XFF4E5B81),
        child: DrawerScreen(),
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Group 163959 (1).jpg"),
                    fit: BoxFit.cover),
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 6),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                          'Shop',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                              "assets/Vector Smart Object copy.png"),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(
                            "assets/shopping-cart(1) copy.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 450,
            height: 300,
            child: Image.asset("assets/Vector Smart Object.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 105, left: 200),
          child: Text(
            "LORRM IPSUM \nDOLR",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 240,),
        //   child: Row(
        //     children: [
        //       Container(
        //           height: 200,
        //           width: 200,
        //           child: Image.asset("assets/Rectangleshirt.png")),
        //       Container(
        //           height: 200,
        //           width: 200,
        //           child: Image.asset("assets/Rectangleshirt.png")),
        //     ],
        //   ),
        // ),
      ]),
    );
  }
}
