// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:link_up/ui/downloadticket.dart';
import 'package:link_up/ui/pdf_invoice.dart';
import 'package:link_up/widgets/pdf_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:link_up/ui/pdf_ticket.dart';

class ETicket extends StatelessWidget {
  ETicket({this.ticketid});
  // ETicket(
  //     {Key? key,
  //     required this.eventname,
  //     required this.eventdate,
  //     required this.eventlocation,
  //     required this.username,
  //     required this.userphone,
  //     required this.useremail,
  //     required this.nooftickets})
  //     : super(key: key);
  // String eventname;
  // String eventdate;
  // String eventlocation;
  // String username;
  // String userphone;
  // String useremail;
  // String nooftickets;
  String? Event_Name;
  String? Event_Date;
  String? Event_Location;
  String? User_Name;
  String? User_Phone;
  String? User_Email;
  String? No_Of_Tickets;
  String? ticketid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ticketSales')
            .doc(ticketid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            DocumentSnapshot ticketsales = snapshot.data as DocumentSnapshot;
            String eventid = ticketsales['event_id'];
            String userid = ticketsales['user_id'];

            return ListView(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/Group 163959.png",
                          ),
                          fit: BoxFit.cover)),
                  child: Center(
                      child: Text(
                    "E-Ticket",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 22,
                        color: Colors.white),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Name',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('events')
                              .doc(eventid)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot eventSnapshot1) {
                            if (!eventSnapshot1.hasData) {
                              return CircularProgressIndicator();
                            }
                            DocumentSnapshot event =
                                eventSnapshot1.data as DocumentSnapshot;
                            if (eventSnapshot1.hasData) {
                              Event_Name = event['title'].toString();
                              Event_Date = event['start_time'].toString();
                              Event_Location = event['venue'].toString() +
                                  ', ' +
                                  event['country'].toString();
                              return SmallText(event['title'].toString());
                            }
                            return Container(
                              height: 200,
                              child: Text('Loading'),
                            );
                          }),
                      Divider(
                        endIndent: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Date and Hour",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('events')
                              .doc(eventid)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot eventSnapshot1) {
                            if (!eventSnapshot1.hasData) {
                              return CircularProgressIndicator();
                            }
                            DocumentSnapshot event =
                                eventSnapshot1.data as DocumentSnapshot;
                            if (eventSnapshot1.hasData) {
                              return SmallText(event['start_time'].toString());
                            }
                            return Container(
                              height: 200,
                              child: Text('Loading'),
                            );
                          }),
                      Divider(
                        endIndent: 15,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Event Location",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('events')
                              .doc(eventid)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot eventSnapshot1) {
                            if (!eventSnapshot1.hasData) {
                              return CircularProgressIndicator();
                            }
                            DocumentSnapshot event =
                                eventSnapshot1.data as DocumentSnapshot;
                            if (eventSnapshot1.hasData) {
                              return Row(
                                children: [
                                  SmallText(event['venue'].toString()),
                                  SmallText(', '),
                                  SmallText(event['country'].toString()),
                                ],
                              );
                            }
                            return Container(
                              height: 200,
                              child: Text('Loading'),
                            );
                          }),
                      Divider(
                        endIndent: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Ticket Details",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Full name'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userid)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot eventSnapshot1) {
                                  if (!eventSnapshot1.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  DocumentSnapshot user =
                                      eventSnapshot1.data as DocumentSnapshot;
                                  if (eventSnapshot1.hasData) {
                                    User_Name = user['first_name'].toString() +
                                        ' ' +
                                        user['last_name'].toString();
                                    return Row(
                                      children: [
                                        SmallText(
                                            user['first_name'].toString()),
                                        SmallText(' '),
                                        SmallText(user['last_name'].toString()),
                                      ],
                                    );
                                  }
                                  return Container(
                                    height: 200,
                                    child: Text('Loading'),
                                  );
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Phone'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userid)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot eventSnapshot1) {
                                  if (!eventSnapshot1.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  DocumentSnapshot user =
                                      eventSnapshot1.data as DocumentSnapshot;
                                  if (eventSnapshot1.hasData) {
                                    User_Phone =
                                        user['phone_number'].toString();
                                    return SmallText(
                                        user['phone_number'].toString());
                                  }
                                  return Container(
                                    height: 200,
                                    child: Text('Loading'),
                                  );
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Email'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userid)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot eventSnapshot1) {
                                  if (!eventSnapshot1.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  DocumentSnapshot user =
                                      eventSnapshot1.data as DocumentSnapshot;
                                  if (eventSnapshot1.hasData) {
                                    User_Email = user['email'].toString();
                                    return SmallText(user['email'].toString());
                                  }
                                  return Container(
                                    height: 200,
                                    child: Text('Loading'),
                                  );
                                }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Seats'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                SmallText(ticketsales['seat_details'][0]
                                        ['nooftickets']
                                    .toString()),
                                SmallText(' * '),
                                SmallText(ticketsales['seat_details'][0]
                                        ['ticket_type']
                                    .toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Sub Total'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SmallText(
                                '\$ ' + ticketsales['subtotal'].toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Fee'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SmallText(
                                '\$ ' + ticketsales['fee'].toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Tax'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SmallText(
                                '\$ ' + ticketsales['tax'].toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Grand Total'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SmallText(
                                '\$ ' + ticketsales['total'].toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText('Payment Method'),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: SmallText(
                                ticketsales['payment_method'].toString()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      InkWell(
                        onTap: () async {
                          final pdfFile = await PdfInvoiceApi.generate(
                            Event_Name: Event_Name,
                            Event_Date: Event_Date,
                            Event_Location: Event_Location,
                            Username: User_Name,
                            user_email: User_Email,
                            userphoneNumber: User_Phone,
                            TicketType: ticketsales['seat_details'][0]
                                ['ticket_type'],
                            NoOfTickets: ticketsales['seat_details'][0]
                                    ['nooftickets']
                                .toString(),
                            SubTotal: ticketsales['subtotal'].toString(),
                            Fee: ticketsales['fee'].toString(),
                            Tax: ticketsales['tax'].toString(),
                            Discount: ticketsales['discount'].toString(),
                            Grandtotal: ticketsales['total'].toString(),
                          );

                          // opening the pdf file
                          FileHandleApi.openFile(pdfFile);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 56, 171, 216)),
                            child: Center(
                              child: Text(
                                'Download Ticket',
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Text SmallText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontFamily: "OpenSans", fontSize: 16, color: Colors.black38),
    );
  }
}
