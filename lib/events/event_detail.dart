// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:link_up/events/TicketType.dart';
// import 'package:link_up/events/chat_message_new.dart';
// import 'package:link_up/events/eventfile8.dart';
// import 'package:link_up/ui/DrawerScreen.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'getcontroller.dart';
// import 'map.dart';

// class EventDetail extends StatefulWidget {
//    String? title;
//   String? description;
//   String? start_time;
//   String? end_time;
//   String? country;
//   String? state;
//   String? venue;
//   String? uuid;
//   String? disclai;
//   String? nameorganizer;
//   Uint8List? image;

//   EventDetail(
//       {
//       this.image,
//       this.nameorganizer,
//       this.disclai,
//       this.title,
//       this.description,
//       this.end_time,
//       this.start_time,
//       this.country,
//       this.state,
//       this.venue,
//       this.uuid,
//       });
//   @override
//   State<EventDetail> createState() => _EventDetailState();
// }

// class _EventDetailState extends State<EventDetail> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//    EventController entcontroller=Get.put(EventController());

//   TextEditingController number = TextEditingController();
// String stripHtmlIfNeededd(String text) {
//     return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
//   }
//   Future<void> _dialCall() async {
//     String phoneNumber = number.text.toString();
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launch(launchUri.toString());
//   }

// CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(20.5937, 78.9629));
// // GoogleMapController googleMapController;
// late GoogleMapController _controller;
//   // const Massege({super.key});
//   @override
//   Widget build(BuildContext context) {
//      var appSize = MediaQuery.of(context).size;
//     final _scaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Drawer(
//         backgroundColor: Color(0XFF4E5B81),
//         child: DrawerScreen(),
//       ),
//       body: Stack(
//         children: [
//           // Image.asset(
//           //   "assets/top (2).png",
//           // ),
//           Container(
//             height: appSize.height * 0.25,
//             width: appSize.width * 1,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: MemoryImage(widget.image as Uint8List),
//                   fit: BoxFit.fill),
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: IconButton(
//                           onPressed: () {
//                             _scaffoldKey.currentState!.openDrawer();
//                           },
//                           icon: Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           )),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Image.asset("assets/link.png"),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     )
//                   ],
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 20.0, left: 20),
//                 //   child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 15,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           _dialCall();
//                         },
//                         child: Image.asset(
//                           "assets/Call.png",
//                           height: 70,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: (){
// // GoogleMap(
// //   initialCameraPosition: _initialCameraPosition ,
// //   myLocationEnabled: true,
// //   myLocationButtonEnabled: true,
// //   mapType: MapType.normal,
// //   zoomGesturesEnabled: true,
// //   zoomControlsEnabled: true,
// //   onMapCreated: (GoogleMapController c) {
// //     // to control the camera position of the map
// //     _controller = c;
// //   },
// // );
// // print("Google Maps");
// Navigator.push(context, MaterialPageRoute(builder: (_){
//   return  Map1();
// }));
//                         },
//                         child: Image.asset(
//                           "assets/Direct.png",
//                           height: 70,
//                         ),
//                       ),
//                       GestureDetector(
//                         child: Image.asset(
//                           "assets/tickt.png",
//                           height: 70,
//                         ),
//                         onTap: () {
//                           Get.to(Event8(
//                              title: widget.title,
//                         description: widget.description,
//                         end_time: widget.end_time,
//                         start_time: widget.start_time,
//                         country: widget.country,
//                         state: widget.state,
//                         uuid: widget.uuid,
//                         disclai: widget.disclai,
//                         venue: widget.venue,
//                       nameorganizer: widget.nameorganizer,
//                       image: widget.image,
//                           ));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 60,
//                 ),

//                 Text(
//                   widget.title.toString(),
//                  style: TextStyle(
//                     color: Color.fromARGB(255, 56, 171, 216),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // Text(
//                 //   "INTERNATIONAL",
//                 //  style: TextStyle(
//                 //     color: Color.fromARGB(255, 56, 171, 216),
//                 //     fontSize: 20,
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Divider(
//                   color: Color.fromARGB(255, 219, 239, 246),
//                   indent: 20,
//                   endIndent: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/Ellipse 2097 (1).png"),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Organizer: ",
//                            style: TextStyle(
//                               color: Color.fromARGB(255, 56, 171, 216),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                         widget.nameorganizer.toString(),
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 110),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/calendar.png"),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.start_time.toString(),
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 95),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/clock.png"),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.end_time.toString(),
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 65),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/location(4) (1).png"),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.venue.toString(),
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         ",",
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         widget.country.toString(),
//                        style: TextStyle(
//                           color: Color.fromARGB(255, 154, 154, 154)
//                               .withOpacity(0.8),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "MEMBERS",
//                  style: TextStyle(
//                     color: Color.fromARGB(255, 56, 171, 216),
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Image.asset("assets/Group_163989-removebg-preview.png"),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Divider(
//                   color: Color.fromARGB(255, 219, 239, 246),
//                   indent: 20,
//                   endIndent: 20,
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   "About Event",
//                  style: TextStyle(
//                     color: Color.fromARGB(255, 56, 171, 216),
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   stripHtmlIfNeededd(widget.description.toString()),
//                   textAlign: TextAlign.center,
//                  style: TextStyle(
//                       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
//                 ),
//                 SizedBox(
//                   height: 10
//                 ),
//                  Divider(
//                   color: Color.fromARGB(255, 219, 239, 246),
//                   indent: 20,
//                   endIndent: 20,
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   "About Disclaimer",
//                  style: TextStyle(
//                     color: Color.fromARGB(255, 56, 171, 216),
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   stripHtmlIfNeededd(widget.disclai.toString()),
//                   textAlign: TextAlign.center,
//                  style: TextStyle(
//                       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
//                 ),
//                  SizedBox(
//                   height: 10
//                 ),
//                  Divider(
//                   color: Color.fromARGB(255, 219, 239, 246),
//                   indent: 20,
//                   endIndent: 20,
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(
//                   "Sponsers",
//                  style: TextStyle(
//                     color: Color.fromARGB(255, 56, 171, 216),
//                     fontSize: 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding:  EdgeInsets.only(
//                     left: 40
//                   ),
//                   child: SizedBox(
//                           height: 50,
//                           width: 100,
//                           child: StreamBuilder<QuerySnapshot>(
//                               stream: _firestore
//                                   .collection("sponsore")
//                                   .where("event_id",
//                                       isEqualTo:widget.uuid,
//                                           )
//                                   .snapshots(),
//                               builder: (BuildContext context,
//                                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                                 if (snapshot.hasData) {
//                                   return ListView.builder(
//                                       itemCount: snapshot.data!.docs.length,
//                                       itemBuilder: (context, index) {
//                                         final data = snapshot.data!.docs[index];
//                                         final dataaaa = snapshot.data!.docs[index].id;

//                                         return Text(data.get("name",),style: TextStyle(color:Color.fromRGBO(154, 154, 154, 1) ,fontSize: 12),);
//                                       });
//                                 }
//                                 return CircularProgressIndicator();
//                               },
//                               ),
//                         ),
//                 ),
//                 // Text(
//                 //   stripHtmlIfNeededd(widget.uuid.toString()),
//                 //   textAlign: TextAlign.center,
//                 //  style: TextStyle(
//                 //       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
//                 // ),

//                 // Text(widget.id.toString(),),
//                 SizedBox(
//                   height: 20,
//                 ),

//                 // Text(
//                 //   "Nam facere velit id nostrum quas sed quidem repellendus in pariatur fugiat in voluptas asperiores non rerum numquam fuga nesciunt! Aut cupiditate eaque .",
//                 //   textAlign: TextAlign.center,
//                 //  style: TextStyle(
//                 //       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
//                 // ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 50,
//                   width: 317,
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           elevation: 0.0,
//                           primary: Color.fromARGB(255, 213, 220, 22)),
//                       onPressed: () {
//                         // Get.to(EventsChatScreen());
//                       },
//                       child: Text(
//                         "MASSEGE",
//                        style: TextStyle(fontSize: 16),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link_up/events/TicketType.dart';
import 'package:link_up/events/chat_message_new.dart';
import 'package:link_up/events/eventfile8.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'getcontroller.dart';
import 'map.dart';

class EventDetail extends StatefulWidget {
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

  EventDetail({
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
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late DateTime date;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EventController entcontroller = Get.put(EventController());

  TextEditingController number = TextEditingController();
  String stripHtmlIfNeededd(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  Future<void> _dialCall() async {
    String phoneNumber = number.text.toString();
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(20.5937, 78.9629));
// GoogleMapController googleMapController;
  late GoogleMapController _controller;
  // const Massege({super.key});
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.end_time as Timestamp;
    date = timestamp.toDate();
    DateTime dateTime = date; // your DateTime object
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy – h:mm a').format(dateTime);
    print(formattedDate);
    var appSize = MediaQuery.of(context).size;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0XFF4E5B81),
        child: DrawerScreen(),
      ),
      body: Stack(
        children: [
          // Image.asset(
          //   "assets/top (2).png",
          // ),
          Container(
            height: appSize.height * 0.25,
            width: appSize.width * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(widget.image as Uint8List),
                  fit: BoxFit.fill),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset("assets/link.png"),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0, left: 20),
                //   child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          _dialCall();
                        },
                        child: Image.asset(
                          "assets/Call.png",
                          height: 70,
                        ),
                      ),
                      InkWell(
                        onTap: () {
// GoogleMap(
//   initialCameraPosition: _initialCameraPosition ,
//   myLocationEnabled: true,
//   myLocationButtonEnabled: true,
//   mapType: MapType.normal,
//   zoomGesturesEnabled: true,
//   zoomControlsEnabled: true,
//   onMapCreated: (GoogleMapController c) {
//     // to control the camera position of the map
//     _controller = c;
//   },
// );
// print("Google Maps");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Map1();
                          }));
                        },
                        child: Image.asset(
                          "assets/Direct.png",
                          height: 70,
                        ),
                      ),
                      GestureDetector(
                        child: Image.asset(
                          "assets/tickt.png",
                          height: 70,
                        ),
                        onTap: () {
                          Get.to(Event8(
                            title: widget.title,
                            description: widget.description,
                            end_time: widget.end_time,
                            start_time: widget.start_time,
                            country: widget.country,
                            state: widget.state,
                            uuid: widget.uuid,
                            disclai: widget.disclai,
                            venue: widget.venue,
                            nameorganizer: widget.nameorganizer,
                            image: widget.image,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),

                Text(
                  widget.title.toString(),
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 171, 216),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "INTERNATIONAL",
                //  style: TextStyle(
                //     color: Color.fromARGB(255, 56, 171, 216),
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
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
                            widget.nameorganizer.toString(),
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
                        formattedDate.toString(),
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
                  padding: const EdgeInsets.only(left: 65),
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
                SizedBox(height: 10),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "About Disclaimer",
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
                  stripHtmlIfNeededd(widget.disclai.toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Color.fromARGB(255, 219, 239, 246),
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Sponsers",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 171, 216),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection("sponsore")
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

                                return Text(
                                  data.get(
                                    "name",
                                  ),
                                  style: TextStyle(
                                      color: Color.fromRGBO(154, 154, 154, 1),
                                      fontSize: 12),
                                );
                              });
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                // Text(
                //   stripHtmlIfNeededd(widget.uuid.toString()),
                //   textAlign: TextAlign.center,
                //  style: TextStyle(
                //       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
                // ),

                // Text(widget.id.toString(),),
                SizedBox(
                  height: 20,
                ),

                // Text(
                //   "Nam facere velit id nostrum quas sed quidem repellendus in pariatur fugiat in voluptas asperiores non rerum numquam fuga nesciunt! Aut cupiditate eaque .",
                //   textAlign: TextAlign.center,
                //  style: TextStyle(
                //       color: Color.fromRGBO(154, 154, 154, 1), fontSize: 12),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 317,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Color.fromARGB(255, 213, 220, 22)),
                      onPressed: () {
                        // Get.to(EventsChatScreen());
                      },
                      child: Text(
                        "MASSEGE",
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
