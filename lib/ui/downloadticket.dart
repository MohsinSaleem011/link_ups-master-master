// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:link_up/ui/eticket.dart';

class DownloadTicket extends StatefulWidget {
  const DownloadTicket({Key? key}) : super(key: key);

  @override
  State<DownloadTicket> createState() => _DownloadTicketState();
}

class _DownloadTicketState extends State<DownloadTicket> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;
  String? Ticketid;
  late final _subscription;
  List show = [];
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');
  void getsubsciptiondata() {
    _subscription = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        Timestamp enddate = element.data()['end_time'];
        print(enddate);
        print(enddate.compareTo(Timestamp.now()));
        show.add(enddate.compareTo(Timestamp.now()));
      });
      print(show);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(user.uid.toString());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Color.fromARGB(255, 211, 228, 212),
            child: DrawerScreen(),
          ),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              "assets/Group 163959 (3).png",
              fit: BoxFit.cover,
            )),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Text("Tickets"),
                ),
                SizedBox(
                  width: 120,
                ),
                Icon(Icons.search)
              ],
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white30,
              labelStyle: TextStyle(fontSize: 16),
              indicatorColor: Color.fromARGB(255, 56, 171, 216),
              padding: EdgeInsets.only(bottom: 60),
              tabs: [
                Tab(
                  text: "Upcomming",
                ),
                Tab(text: "Completed"),
                Tab(text: "Cancelled")
              ],
            ),
            toolbarHeight: 140,
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ticketSales')
                    .where('ticket_status', isEqualTo: 'not canceled')
                    .where('user_id', isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  print(snapshot.data!.docs.length);
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ticket = snapshot.data!.docs[index];
                      String eventId = ticket['event_id'];

                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .get(),
                        builder: (context, eventSnapshot) {
                          if (!eventSnapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          DocumentSnapshot event =
                              eventSnapshot.data as DocumentSnapshot;
                          Timestamp enddate = event['end_time'];
                          print(enddate.compareTo(Timestamp.now()));

                          final storageRef = FirebaseStorage.instance.ref();
                          Reference? imagesRef = storageRef.child("events");

                          return enddate.compareTo(Timestamp.now()) == 1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color.fromARGB(
                                                      255, 56, 171, 216),
                                                ),
                                                child: FutureBuilder(
                                                    future: imagesRef
                                                        .child(event
                                                            .get("image_object")
                                                            .split('/')[1])
                                                        .getData(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var snapshott =
                                                            snapshot.data;

                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: MemoryImage(
                                                                    snapshott
                                                                        as Uint8List),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        );
                                                      } else
                                                        return SizedBox();
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      event['start_time'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      event['title'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          event['venue'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          ',',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          event['country'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(ETicket(
                                                    ticketid: ticket.id,
                                                  ));
                                                },
                                                child: Icon(
                                                  Icons.arrow_right,
                                                  size: 34,
                                                  color: Color.fromARGB(
                                                      255, 56, 171, 216),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    smallcontainer(
                                      ticketId: ticket.id,
                                    ),
                                    Divider(
                                      endIndent: 15,
                                      indent: 15,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : SizedBox();
                        },
                      );
                    },
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ticketSales')
                    .where('ticket_status', isEqualTo: 'not canceled')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ticket = snapshot.data!.docs[index];
                      String eventId = ticket['event_id'];

                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .get(),
                        builder: (context, eventSnapshot) {
                          if (!eventSnapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          DocumentSnapshot event =
                              eventSnapshot.data as DocumentSnapshot;
                          Timestamp enddate = event['end_time'];
                          print(enddate.compareTo(Timestamp.now()));

                          final storageRef = FirebaseStorage.instance.ref();
                          Reference? imagesRef = storageRef.child("events");

                          return enddate.compareTo(Timestamp.now()) == -1
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color.fromARGB(
                                                      255, 56, 171, 216),
                                                ),
                                                child: FutureBuilder(
                                                    future: imagesRef
                                                        .child(event
                                                            .get("image_object")
                                                            .split('/')[1])
                                                        .getData(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var snapshott =
                                                            snapshot.data;

                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image: MemoryImage(
                                                                    snapshott
                                                                        as Uint8List),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        );
                                                      } else
                                                        return SizedBox();
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      event['start_time'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      event['title'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          event['venue'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          ',',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          event['country'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(ETicket(
                                                    ticketid: ticket.id,
                                                  ));
                                                },
                                                child: Icon(
                                                  Icons.arrow_right,
                                                  size: 34,
                                                  color: Color.fromARGB(
                                                      255, 56, 171, 216),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    View_e_ticket_button(
                                      ticketId: ticket.id,
                                    ),
                                    Divider(
                                      endIndent: 15,
                                      indent: 15,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : SizedBox();
                        },
                      );
                    },
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ticketSales')
                    .where('ticket_status', isEqualTo: 'canceled')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ticket = snapshot.data!.docs[index];
                      String eventId = ticket['event_id'];
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .get(),
                        builder: (context, eventSnapshot) {
                          if (!eventSnapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          DocumentSnapshot event =
                              eventSnapshot.data as DocumentSnapshot;
                          final storageRef = FirebaseStorage.instance.ref();
                          Reference? imagesRef = storageRef.child("events");
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color.fromARGB(
                                                255, 56, 171, 216),
                                          ),
                                          child: FutureBuilder(
                                              future: imagesRef
                                                  .child(event
                                                      .get("image_object")
                                                      .split('/')[1])
                                                  .getData(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  var snapshott = snapshot.data;

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: MemoryImage(
                                                              snapshott
                                                                  as Uint8List),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  );
                                                } else
                                                  return SizedBox();
                                              }),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                event['start_time'],
                                                style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                event['title'],
                                                style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    event['venue'],
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    ',',
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    event['country'],
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(ETicket(
                                              ticketid: ticket.id,
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Icon(
                                              Icons.arrow_right,
                                              size: 34,
                                              color: Color.fromARGB(
                                                  255, 56, 171, 216),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              View_e_ticket_button(
                                ticketId: ticket.id,
                              ),
                              Divider(
                                endIndent: 15,
                                indent: 15,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding smallcontainer({String? ticketId}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              FirebaseFirestore.instance
                  .collection('ticketSales')
                  .doc(ticketId)
                  .update({'ticket_status': 'canceled'});
            },
            child: Container(
              height: 20,
              width: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromARGB(255, 198, 203, 46),
              ),
              child: Center(
                child: Text(
                  'Cancel Booking',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.white,
                      fontSize: 12),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 7,
          ),
          View_e_ticket_button(ticketId: ticketId)
        ],
      ),
    );
  }
}

class View_e_ticket_button extends StatelessWidget {
  View_e_ticket_button({this.ticketId});
  final String? ticketId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ETicket(
          ticketid: ticketId,
        ));
      },
      child: Container(
        height: 20,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color.fromARGB(255, 56, 171, 216),
        ),
        child: Center(
          child: Text(
            'View E-Ticket',
            style: TextStyle(
                fontFamily: "OpenSans", color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}