import 'package:flutter/material.dart';
import 'package:link_up/ui/DrawerScreen.dart';
// import 'package:link_up/ui/DrawerScreen.dart';

class EventsChatScreen extends StatefulWidget {
  const EventsChatScreen({Key? key}) : super(key: key);

  @override
  State<EventsChatScreen> createState() => _EventsChatScreenState();
}

class _EventsChatScreenState extends State<EventsChatScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text("data"),
      // ),
      drawer: Drawer(
        backgroundColor: Color(0XFF4E5B81),
        child: DrawerScreen(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              // color: Colors.green
              image: DecorationImage(
                  image: AssetImage("assets/Group 163959.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  iconSize: 35,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/camera_white.png"),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone_in_talk_sharp),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "FLORAL SINGING \nINTERNATIONAL PARTY",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Color(0xff38ABD8),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  right: 5.0,
                ),
                child: Container(
                    width: width / 1.5,
                    height: 75,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 56, 171, 216),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: const Text(
                            "Lorem ipsum dolor sit  amet, \n consectetuer adipiscing elit. \n Aen",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontFamily: "OpenSans", color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: const [
                            CircleAvatar(backgroundColor: Colors.grey),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Vida Stuart",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 120.0),
                child: const Text(
                  "01:07 PM",
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 60.0,
                  left: 5.0,
                ),
                child: Container(
                  width: width,
                  height: 58,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(backgroundColor: Colors.grey),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Name",
                            style:
                                TextStyle(fontFamily: "OpenSans", fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Text(
                          "Lorem ipsum dolor sit  am",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  // color: Colors.pink,
                  //   child: ListTile(
                  //     leading: CircleAvatar(backgroundColor: Color(0xff38ABD8)),
                  //     title: Container(
                  //       padding: EdgeInsets.all(12.0),
                  //       decoration: BoxDecoration(
                  //           color: Color.fromARGB(255, 56, 171, 216),
                  //           borderRadius: BorderRadius.circular(20.0)),
                  //       child: Text("LLorem ipsum dolor sit am"),
                  //     ),
                  //   ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 180.0),
                child: const Text(
                  "02:13 PM",
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 60.0,
                  left: 5.0,
                ),
                child: Container(
                  width: width,
                  height: 60,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(backgroundColor: Colors.grey),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            "Name",
                            style:
                                TextStyle(fontFamily: "OpenSans", fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Text(
                          "Lorem ipsum dolor sit  amet, consect",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  // color: Colors.pink,
                  //   child: ListTile(
                  //     leading: CircleAvatar(backgroundColor: Color(0xff38ABD8)),
                  //     title: Container(
                  //       padding: EdgeInsets.all(12.0),
                  //       decoration: BoxDecoration(
                  //           color: Color.fromARGB(255, 56, 171, 216),
                  //           borderRadius: BorderRadius.circular(20.0)),
                  //       child: Text("LLorem ipsum dolor sit am"),
                  //     ),
                  //   ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 250.0),
                child: const Text(
                  "02:13 PM",
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 70, right: 60, top: 10, bottom: 10),
                child: Container(
                  height: 70,
                  width: width / 2,
                  // color: Colors.amber,
                  child: Image.asset("assets/chat_img.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                  left: 20,
                ),
                child: SizedBox(
                    width: width / 2,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 56, 171, 216),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: const Text(
                            "Lorem ipsum dolor sit  amet,  consectetuer \nadipiscing elit Aen",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: const [
                            CircleAvatar(backgroundColor: Colors.grey),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Vida Stuart",
                              style: TextStyle(
                                  fontFamily: "OpenSans", fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )
                    // color: Colors.amber,
                    // child: ListTile(
                    //   trailing: CircleAvatar(backgroundColor: Color(0xff38ABD8)),
                    //   title: Container(
                    //     padding: EdgeInsets.all(12.0),
                    //     decoration: BoxDecoration(
                    //         color: Color.fromARGB(255, 56, 171, 216),
                    //         borderRadius: BorderRadius.circular(20.0)),
                    //     child: Text(
                    //         "Lorem ipsum dolor sit amet,  consectetuer adipiscing elit.  Aen"),
                    //   ),
                    // ),
                    ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50.0),
                child: const Text(
                  "02:15 PM",
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 12),
                ),
              ),
            ],
          )),
          Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      prefixIcon: Image.asset("assets/camera.png"),
                      prefixIconColor: Colors.white,
                      hintText: "Say something...",
                      hintStyle:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                      fillColor: Colors.blue,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 25.0,
                  onPressed: () {},
                )
              ])),
        ],
      ),
    );
  }
}
