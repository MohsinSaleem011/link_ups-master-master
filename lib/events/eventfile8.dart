import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:link_up/events/CurrentLocation.dart';
import 'package:link_up/events/event9.dart';
import 'package:link_up/events/event_detail.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class Event8 extends StatefulWidget {
  String? title;
  String? description;
  String? start_time;
  Timestamp? end_time;
  String? country;
  String? state;
  String? venue;
  String? uuid;
  String? disclai;
  String? nameorganizer;
  Uint8List? image;

  Event8({
    this.image,
    this.nameorganizer,
    this.disclai,
    this.title,
    this.description,
    this.end_time,
    this.start_time,
    this.country,
    this.state,
    this.venue,
    this.uuid,
  });
  // const Event8({super.key});

  @override
  State<Event8> createState() => _Event8State();
}

class _Event8State extends State<Event8> {
  late DateTime date;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.end_time as Timestamp;
    date = timestamp.toDate();
    DateTime dateTime = date; // your DateTime object
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy – h:mm a').format(dateTime);
    print(formattedDate);
    var appSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // backgroundColor: Colors.green.shade900,
        child: DrawerScreen(),
      ),
      body: Stack(children: [
        Image.asset("assets/bck.jpg"),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    iconSize: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(child: Image.asset("assets/Link 1.png")),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "EVENTS",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Image.asset("assets/newlogoevent.png"),
                ),
                Column(
                  children: [
                    Container(
                      height: appSize.height * 0.22,
                      width: appSize.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: MemoryImage(widget.image as Uint8List),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.title.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Row(
                        children: [
                          Text(
                            "Organizer:",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.nameorganizer.toString(),
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.start_time.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.venue.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(","),
                          Text(
                            widget.country.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      formattedDate.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      width: 90,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection("tickets")
                            .where(
                              "event_id",
                              isEqualTo: widget.uuid,
                            )
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  final dataaaa = snapshot.data!.docs[index].id;

                                  return PrettyQr(
                                    typeNumber: 2,
                                    size: 10,
                                    data: data.get("qrcode").toString(),
                                    errorCorrectLevel: QrErrorCorrectLevel.M,
                                    roundEdges: true,
                                  );
                                });
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            // Stack(children: [
            //   Padding(
            //     padding: const EdgeInsets.only(left: 50, right: 50),
            //     child: Image.asset("assets/Rectangle 23327.jpg"),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.only(top: 7),
            //     child: Center(
            //       child: Text(
            //         "My Bookings",
            //        style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   )
            // ]),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                child: Container(
                  height: 35,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: AssetImage("assets/Rectangle 23327.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Text(
                      "My Bookings",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(CurrentLocation());
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}
