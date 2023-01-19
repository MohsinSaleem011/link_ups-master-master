import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:link_up/events/TicketType.dart';
import '../ui/DrawerScreen.dart';
import 'getcontroller.dart';

class BuyTicket extends StatefulWidget {
  String? title;
  String? description;
  String? start_time;
  Timestamp? end_time;
  String? country;
  String? state;
  String? venue;
  String? id;
  String? disclaimer;
  String? organizername;
  String? economy;
  String? vip_price;
  String? Latitude;
  String? longitude;
  double? fees;
  String? object;
  String? image;
  String? category;

  BuyTicket({
    this.category,
    this.economy,
    this.image,
    this.object,
    this.vip_price,
    this.fees,
    this.Latitude,
    this.longitude,
    this.organizername,
    this.disclaimer,
    this.title,
    this.description,
    this.end_time,
    this.start_time,
    this.country,
    this.state,
    this.venue,
    this.id,
  });

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  // late var date;
  dynamic snapshott;
  EventController entcontroller = Get.put(EventController());

  String stripHtmlIfNeededd(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getData() async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child("events");

    snapshott = await imagesRef.child(widget.image!.split('/')[1]).getData();

    setState(() {
      snapshott;
    });
  }

  var date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.end_time as Timestamp;
    date = timestamp.toDate();
    DateTime dateTime = date; // your DateTime object
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy – h:mm a').format(dateTime);
    print(formattedDate);
    var appSize = MediaQuery.of(context).size;

    final storageRef = FirebaseStorage.instance.ref();

    return Scaffold(
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            height: appSize.height * 0.22,
            width: appSize.width * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(snapshott ?? Uint8List(0) as Uint8List),
                  fit: BoxFit.fill),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset("assets/link.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 70,
                  ),
                  child: Image.asset(
                    "assets/Group_163989-removebg-preview.png",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Text(
                        "+49 Going",
                        style: TextStyle(
                          color: Color.fromARGB(255, 56, 171, 216),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        height: 18,
                        width: 69,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: Color.fromRGBO(214, 220, 22, 1),
                            ),
                            onPressed: () {},
                            child: Text(
                              "INVITE",
                              style: TextStyle(fontSize: 8),
                            )),
                      ),
                      // Text(widget.fees.toString()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  widget.title.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 171, 216),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 6,
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Image.asset("assets/Ellipse 2097 (1).png"),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Organizer: ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 56, 171, 216),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.organizername.toString(),
                            style: TextStyle(
                              color: Color.fromARGB(255, 154, 154, 154)
                                  .withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: Row(
                    children: [
                      Image.asset("assets/calendar.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.start_time.toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 154, 154, 154)
                              .withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95),
                  child: Row(
                    children: [
                      Image.asset("assets/clock.png"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Color.fromARGB(255, 154, 154, 154)
                              .withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Image.asset("assets/location(4) (1).png"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.venue.toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 154, 154, 154)
                              .withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ",",
                        style: TextStyle(
                          color: Color.fromARGB(255, 154, 154, 154)
                              .withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.country.toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 154, 154, 154)
                              .withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(widget.disclaimer.toString()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "MEMBERS",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 171, 216),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset("assets/Group_163989-removebg-preview.png"),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "About Event",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 171, 216),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  stripHtmlIfNeededd(widget.description.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
                ),
                // Text(widget.category.toString()),
                // Text(widget.economy.toString()),

                //  Text(
                //   "Event Latitude/Longitude",
                //  style: TextStyle(
                //     color: Color.fromARGB(255, 56, 171, 216),
                //     fontSize: 22,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text("Lat:"+widget.Latitude!.toString(),style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1)),),
                // Text("Long:"+widget.longitude!.toString(),style: TextStyle(color: Color.fromRGBO(154, 154, 154, 1))),
                // Text(widget.id.toString(),),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 317,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Color.fromRGBO(56, 171, 216, 1)),
                      onPressed: () {
                        Get.to(
                          TicketType(
                            fees: widget.fees,
                            title: widget.title,
                            description: widget.description,
                            end_time: widget.end_time,
                            start_time: widget.start_time,
                            country: widget.country,
                            state: widget.state,
                            uid: widget.id,
                            disclaimer: widget.disclaimer,
                            venue: widget.venue,
                            organizer: widget.organizername,
                            vip_price: widget.vip_price,
                            economy: widget.economy,
                            image: snapshott,
                            category: widget.category,
                          ),
                        );
                      },
                      child: Text(
                        "Buy Ticket",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
