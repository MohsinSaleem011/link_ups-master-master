import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/events/couponscreen.dart';
import 'package:link_up/events/event9.dart';
import 'package:link_up/events/getcontroller.dart';

import '../ui/DrawerScreen.dart';

class TicketType extends StatefulWidget {
  String? ticket_id;
  String? title;
  String? description;
  String? start_time;
  Timestamp? end_time;
  String? country;
  String? state;
  String? venue;
  String? uid;
  String? disclaimer;
  String? organizer;
  String? economy;
  String? vip_price;
  double? fees;

  Uint8List? image;
  String? discount;
  String? category;
  String? momo;
  String? dicountcode;
  TicketType({
    this.momo,
    this.category,
    this.discount,
    this.image,
    this.vip_price,
    this.fees,
    this.economy,
    this.organizer,
    this.disclaimer,
    this.title,
    this.description,
    this.end_time,
    this.start_time,
    this.country,
    this.state,
    this.venue,
    this.uid,
    this.dicountcode,
  });

  @override
  State<TicketType> createState() => _TicketTypeState();
}

class _TicketTypeState extends State<TicketType> {
  String? ticket_id;
  String? pop = '';
  int? discountt = 0;
  int? vip = 0;
  int? ecnmy;
  int? butn = 0;
  int? equal = 0;
  double? equal2;
  double? fee;
  double? tax1;
  String? total;
  String? tax = "7.5";
  int? tax3 = 0;
  String? resultfes;
  double? total1 = 0.0;
  int? total2 = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _counter = 1;
  String? button;
  String? dropdownvalue;
  String? dropdownvalue2;
  EventController entcontroller = Get.put(EventController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  late final _subscription3;
  List endate2 = [];

  void gettickettime() {
    _subscription3 = FirebaseFirestore.instance
        .collection('tickets')
        .where("event_id", isEqualTo: widget.uid)
        .snapshots()
        .listen((ticket) {
      ticket.docs.forEach((element) {
        if (element.data()['available_to'].runtimeType == Timestamp) {
          Timestamp enddate = element.data()['available_to'];
          endate2.add(enddate.compareTo(Timestamp.now()));
        } else {
          endate2.add(0);
        }
      });
    });
  }

  @override
  void initState() {
    gettickettime();
    // print('ticket_id_check');
    // print(ticket_id);
    var _collection = FirebaseFirestore.instance
        .collection('coupons')
        .where('ticket_id', isEqualTo: ticket_id)
        .where('code', isEqualTo: entcontroller.discountcode.value.toString());
    // Get the data from the collection
    _collection.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        // print(doc.data());
        if (doc.data()['discount_type'] == "amount") {
          entcontroller.discount!.value = doc.data()['discount'];
          entcontroller.percentage!.value = '';
        }
        else if (doc.data()['discount_type'] == "percentage") {
        entcontroller.percentage!.value = doc.data()['discount'];
        entcontroller.discount!.value = '';
          // print('percentage');
          // print(entcontroller.percentage!.value);
        }
      });
    });

    vip = int.parse(widget.vip_price.toString());
    ecnmy = int.parse(widget.economy.toString());

    tax1 = double.parse(tax.toString());

    tax3 = tax1!.toInt();
    // print(widget.fees);
// resultfes=widget.fees!.replaceFirst("%","");
    fee = widget.fees!;
    total2 = total1!.toInt();

    // getsubsciptiondata();
    // button = '';
    // dropdownvalue = "" + widget.earlybrdVip.toString();
    // dropdownvalue2 = "" + widget.vip_price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      try {
        discountt = int.parse(entcontroller.discount.toString());
        // // // print(discountt);
      } catch (e) {
        // Handle the exception here
      }
    });
    // // // print(discountt);
    // // // print(entcontroller.discount.toString());
    setState(() {
      equal = butn! * _counter;
      equal2 = (butn! * _counter * (100 - discountt!)) / 100;
      // // print(equal2);
    });
    setState(() {
      total1 = equal2! + ((equal! * tax3!) / 100) + ((equal! * fee!) / 100);
      // // print(total1);
    });

    // var items = [
    //   // "" + widget.earlybrdVip.toString(),
    //   // "" + widget.earlybirtheconomy.toString(),
    // ];

    // var items2 = [
    //   // "" + widget.economy_price.toString(),
    //   // "" + widget.vip_price.toString(),
    // ];

    var appSize = MediaQuery.of(context).size;
    var appSize2 = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0XFF4E5B81),
        child: DrawerScreen(),
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Group 163959 (1).jpg"),
                  fit: BoxFit.cover)),
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
                    iconSize: 35,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Ticket Type',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    color: Color.fromARGB(255, 56, 171, 216),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            butn = vip;
                          });
                        },
                        child: Text(
                          "\$${vip.toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  Container(
                    width: 100,
                    color: Color.fromRGBO(214, 220, 22, 1),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          butn = ecnmy;
                        });
                      },
                      child: Text(
                        "\$${ecnmy.toString()}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // (widget.earlybrdVip.toString()==null || widget.earlybirtheconomy.toString()==null)?
            // Padding(
            //   padding: const EdgeInsets.only(top: 140),
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(widget.vip_price.toString()),
            //         Text(widget.economy_price.toString()),
            //       ]
            //       ),
            // ):
            //  Padding(
            //   padding: const EdgeInsets.only(top: 140),
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(widget.earlybirtheconomy.toString()),
            //         Text(widget.earlybrdVip.toString()),
            //       ]
            //       ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 190),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         color: Color.fromARGB(255, 56, 171, 216),
            //         child: DropdownButton(
            //             value: dropdownvalue,
            //             icon: const Icon(Icons.keyboard_arrow_down),
            //             items: items.map((String items) {
            //               return DropdownMenuItem(
            //                 value: items,
            //                 child: Text(items),
            //               );
            //             }).toList(),
            //             onChanged: (String? newValue) {
            //               setState(() {
            //                 button = dropdownvalue = newValue.toString();
            //                 // // print(button);
            //               });
            //             }),
            //       ),

            //       SizedBox(
            //         width: 5,
            //       ),
            //       Container(
            //         color: Color.fromRGBO(214, 220, 22, 1),
            //         child: DropdownButton(
            //             value: dropdownvalue2,
            //             icon: const Icon(Icons.keyboard_arrow_down),
            //             items: items2.map((String items2) {
            //               return DropdownMenuItem(
            //                 value: items2,
            //                 child: Text(items2),
            //               );
            //             }).toList(),
            //             onChanged: (String? newValue) {
            //               setState(() {
            //                 button = dropdownvalue2 = newValue.toString();
            //                 // // print(button);
            //               });
            //             }),
            //       ),

            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       button = widget.earlybrdVip.toString();
            //       // // print(button);
            //     });
            //   },
            //   child: Container(
            //     height: 40,
            //     width: 160,
            //     decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 56, 171, 216),
            //         borderRadius: BorderRadius.circular(3)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "Early Bird VIP",
            //          style: TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         // Text(widget.earlybrdVip.toString(),
            //             // style:
            //                 // TextStyle(color: Colors.white, fontSize: 15)),
            //         Icon(
            //           Icons.arrow_drop_down,
            //           color: Colors.white,
            //           size: 30,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            //  SizedBox(
            //   width: 10,
            //  ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       button = widget.earlybirtheconomy.toString();
            //       // // print(button);
            //     });
            //   },
            //   child: Container(
            //     height: 40,
            //     width: 160,
            //     decoration: BoxDecoration(
            //         color: Color.fromRGBO(214, 220, 22, 1),
            //         borderRadius: BorderRadius.circular(3)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "Regular VIP",
            //          style: TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         // Icon(
            //         //   Icons.arrow_drop_down,
            //         //   color: Colors.white,
            //         //   size: 30,
            //         // ),
            //         Text(widget.earlybirtheconomy.toString(),
            //             style:
            //                 TextStyle(color: Colors.white, fontSize: 15)),
            //       ],
            //     ),
            //   ),
            // )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: _decrementCounter,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(251, 217, 217, 217),
                          borderRadius: BorderRadius.circular(3)),
                      child: Center(
                          child: Text(
                        '-',
                        style: TextStyle(fontSize: 30),
                      )),
                    ),
                  ),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: _incrementCounter,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(251, 217, 217, 217),
                          borderRadius: BorderRadius.circular(3)),
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    "Event Category:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    widget.category.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 30,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('tickets')
                      .where('event_id', isEqualTo: widget.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          return (endate2[index] == 1)
                              ? InkWell(
                                  onTap: () {
                                    var ticket_id1 = snapshot.data.docs[0].id;
                                    // print(ticket_id1);

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return CouponScreen(
                                        id: ticket_id.toString(),
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Apply Coupon",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.arrow_right,
                                            color: Color.fromARGB(
                                                255, 56, 171, 216),
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Ticket Date Expired",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black38),
                                  ),
                                );
                        },
                      );
                    } else {
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "No Coupon Available on this Ticket",
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.transparent,
                    ));
                  }),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 10,
            ),
            (discountt == 0)
                ? SizedBox()
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Coupon Discount",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),

                      Obx(
                        () => Text("-" +
                                    " \$ " +
                                    entcontroller.discount!.value.toString() ==
                                ''
                            ? entcontroller.percentage!.value.toString()
                            : entcontroller.discount!.value.toString()),
                      ),
                      // Text(FirebaseAuth.instance.currentUser!.uid.toString()),
                    ],
                  ),
            (discountt == 0)
                ? SizedBox()
                : Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (total1 == 0.0)
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$" + equal2.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                  (total1 == 0.0)
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "!Tax:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "%",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 56, 171, 216),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  tax1.toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 56, 171, 216),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                  (total1 == 0.0)
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "!Fees:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "%${fee}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                  (total1 == 0.0)
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$" + total1.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 56, 171, 216),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(widget.uid.toString()),
            Center(
              child: InkWell(
                  onTap: () {
                    if (total1 == 0.0) {
                      Text(":");
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Event9(
                          totalprice: total1,
                          title: widget.title,
                          description: widget.description,
                          end_time: widget.end_time,
                          start_time: widget.start_time,
                          country: widget.country,
                          state: widget.state,
                          uid: widget.uid,
                          Disclaimer: widget.disclaimer,
                          venue: widget.venue,
                          Organizer: widget.organizer,
                          image: widget.image,
                        );
                      }));
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 260,
                    decoration: BoxDecoration(
                        color: total1 == 0.0
                            ? Color.fromRGBO(214, 220, 22, 1)
                            : Color.fromRGBO(214, 220, 22, 1),
                        borderRadius: BorderRadius.circular(3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            total1 == 0.0 ? "Select Ticket Price" : "CONTINUE",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ]),
    );
  }
}
