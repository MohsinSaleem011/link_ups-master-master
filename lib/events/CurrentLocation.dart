import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/events/AllEvents.dart';
import 'package:link_up/events/eachcategory.dart';
import 'package:link_up/events/getcontroller.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import '../get_controller/ChatController.dart';
import '../get_controller/auth_controller.dart';
import '../get_controller/home_controller.dart';
import 'BuyTicket.dart';

class CurrentLocation extends StatefulWidget {
  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  String stripHtmlIfNeededd(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController controller = TextEditingController();

  DateTime dt1 = DateTime.parse("2022-12-27 14:00:00");
  DateTime dt2 = DateTime.parse("2022-12-27 14:00:00");

  //  String string = DateFormat.Format(DateTime.now());
  List endtimecheck = [];
  List earlybirdcheck = [];
  late final _subscription;
  late final _subscription2;

  void getsubsciptiondata() {
    _subscription = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (element.data()['end_time'].runtimeType == Timestamp) {
          //   print(element.data()['end_time']);
          Timestamp enddate = element.data()['end_time'];

          // print(enddate);
          // print(enddate.compareTo(Timestamp.now()));
          endtimecheck.add(enddate.compareTo(Timestamp.now()));
        } else {
          endtimecheck.add(0);
        }
      });
      // print(endtimecheck);
    });
  }

  void getearlybrddata() {
    _subscription2 = FirebaseFirestore.instance
        .collection('events')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (element.data()['early_bird_price_date_limit'].runtimeType ==
            Timestamp) {
          // print(element.data()['early_bird_price_date_limit']);
          Timestamp earlydate = element.data()['early_bird_price_date_limit'];
          element.data()['title'];
          // print(earlydate.compareTo(Timestamp.now()));
          earlybirdcheck.add(earlydate.compareTo(Timestamp.now()));
        } else {
          earlybirdcheck.add(0);
        }
      });
      // print(earlybirdcheck);
    });
  }

  @override
  void initState() {
    getsubsciptiondata();
    getearlybrddata();
    super.initState();
  }

  dynamic snapshott;
  Timestamp? t;
  DateTime? myDateTime;
  String? changedate;
  String? endtime;

  @override
  Widget build(BuildContext context) {
    late double? eventfee;

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    AuthController authController = Get.find(tag: AuthController().toString());
    HomeController homeController = Get.find(tag: HomeController().toString());
    ChatController chatController = Get.find(tag: ChatController().toString());
    var appSize = MediaQuery.of(context).size;
    EventController entcontroller = Get.put(EventController());
    entcontroller.getCurrentLocation();
    DateTime dateToday = DateTime.now();
    // DateTime _now = DateTime.now();
    // DateTime _start = DateTime(_now.year, _now.month, _now.day, 0, 0);
    // DateTime _end = DateTime(_now.year, _now.month, _now.day, 23, 59, 59);

    return Scaffold(
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 230,
              color: Color.fromARGB(255, 56, 171, 216),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Current Location",
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            // Text(
                            //   // "Lat:" + entcontroller.currentlatitude.toString(),
                            //   "",
                            //   style:
                            //       TextStyle(
                            //  fontFamily: 'OpenSans',color: Colors.white, fontSize: 15),
                            // ),

                            //  (dt1.compareTo(dt2) == 0)?Text("Both date time are at same moment."):Text("DT1 is After DT2..........."),

                            // Text(

                            //   // "Long:" +
                            //   //     entcontroller.currrentlongitude.toString(),
                            //   dateToday.toString(),
                            //   style:
                            //       TextStyle(
                            // fontFamily: 'OpenSans',color: Colors.white, fontSize: 15),
                            // ),
                            Row(
                              children: [
                                Text(
                                  authController.countryName.toString(),
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                Text(
                                  ",",
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
                                ),
                                Text(
                                  authController.countryCode.toString(),
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset("assets/search-normal.png"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CarouselSlider(
                      items: [
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/party.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Party/Fete",
                                countryid: authController.countryName.value));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/image/all_events_pic (4).png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(AllEvents(
                              country: authController.countryName.toString(),
                            ));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/arts.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Arts",
                                countryid: authController.countryName.value));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/sports.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Sport",
                                countryid: authController.countryName.value));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/music.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Music",
                                countryid: authController.countryName.value));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/food.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Food",
                                countryid: authController.countryName.value));
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/other.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.to(EachCategory(
                                id: "Other",
                                countryid: authController.countryName.value));
                          },
                        ),
                      ],
                      options: CarouselOptions(
                        height: 70.0,
                        enlargeCenterPage: false,
                        autoPlay: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 400),
                        viewportFraction: 0.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 232,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/Group 163959.png",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Upcomming Events",
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: appSize.height * 0.4,
                      width: appSize.width * 1,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection("events")
                              .where("country",
                                  isEqualTo:
                                      authController.countryName.toString())
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final storageRef = FirebaseStorage.instance.ref();
                              Reference? imagesRef = storageRef.child("events");
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                primary: false,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data!.docs[index];
                                  final dataa = snapshot.data!.docs[index].id;
                                  // Try to parse the string as a double
                                  double? parsed =
                                      double.tryParse(data.get('event_fee'));

// Check if the string was successfully parsed and if the double is less than 1
                                  if (parsed != null && parsed < 1) {
                                    double parsedagain = double.parse(
                                        '0' + data.get('event_fee'));

                                    eventfee = parsedagain;
                                  } else {
                                    eventfee =
                                        double.parse(data.get('event_fee'));
                                  }
                                  String description = stripHtmlIfNeededd(
                                      "${data.get("description")}");
                                  String descriptiontrimmed =
                                      description.trim();
                                  return (endtimecheck[index] == 1)
                                      ? Container(
                                          height: appSize.height * 0.4,
                                          width: appSize.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: ListView(
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              primary: false,
                                              children: [
                                                FutureBuilder(
                                                    future: imagesRef
                                                        .child(data
                                                            .get("image_object")
                                                            .split('/')[1])
                                                        .getData(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        snapshott =
                                                            snapshot.data!;

                                                        return Container(
                                                          height:
                                                              appSize.height *
                                                                  0.22,
                                                          width: appSize.width *
                                                              0.2,
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
                                                (endtimecheck[index] == 1)
                                                    ? Container(
                                                        height: appSize.height *
                                                            0.13,
                                                        width:
                                                            appSize.width * 0.2,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffD6DC16),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.to(BuyTicket(
                                                              vip_price: earlybirdcheck[
                                                                          index] ==
                                                                      1
                                                                  ? data.get(
                                                                      "early_bird_vip_price")
                                                                  : data.get(
                                                                      "vip_price"),
                                                              economy: earlybirdcheck[
                                                                          index] ==
                                                                      1
                                                                  ? data.get(
                                                                      "early_bird_economy_price")
                                                                  : data.get(
                                                                      "economy_price"),
                                                              title: data
                                                                  .get("title"),
                                                              description: data.get(
                                                                  "description"),
                                                              start_time: data.get(
                                                                  "start_time"),
                                                              end_time: data.get(
                                                                  "end_time"),
                                                              country: data.get(
                                                                  "country"),
                                                              state: data
                                                                  .get("state"),
                                                              venue: data
                                                                  .get("venue"),
                                                              id: dataa
                                                                  .toString(),
                                                              disclaimer: data.get(
                                                                  "disclaimer"),
                                                              organizername:
                                                                  data.get(
                                                                      "organizer_name"),
                                                              Latitude: data.get(
                                                                  "latitude"),
                                                              longitude: data.get(
                                                                  "longtitude"),
                                                              fees: eventfee,
                                                              image: data.get(
                                                                  "image_object"),
                                                              category: data.get(
                                                                  "category"),
                                                            ));
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        data
                                                                            .get("title")
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSans',
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // SizedBox(
                                                                  //   width: 8,
                                                                  // ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          19,
                                                                      width:
                                                                          60.62,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                AssetImage("assets/Group 163989.png"),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        descriptiontrimmed,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSans',
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Location : ",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSans',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      data.get(
                                                                          "venue"),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSans',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      (","),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSans',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Please add events from Admin Pannel",
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 77,
                        width: 334,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 56, 171, 216),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 19),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "INVITE YOUR FRIENDS",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: 18,
                                        width: 69,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(214, 220, 22, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "INVITE",
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 19),
                              child: Text(
                                "Get 20\$ off Tickets",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: appSize.height * 1,
                        width: appSize.width * 1,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _firestore
                                .collection("events")
                                .where("country",
                                    isEqualTo: authController.countryName.value)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                final storageRef =
                                    FirebaseStorage.instance.ref();
                                Reference? imagesRef =
                                    storageRef.child("events");
                                return ListView.builder(
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshot.data!.docs[index];
                                      final dataaaa =
                                          snapshot.data!.docs[index].id;
                                      //
                                      return (endtimecheck[index] == 1)
                                          ? Container(
                                              height: appSize.height * 0.14,
                                              width: appSize.width * 0.1,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: ListView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                left: 10),
                                                        child: Container(
                                                          height: 65,
                                                          width: 65,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            child:
                                                                FutureBuilder(
                                                                    future: imagesRef
                                                                        .child(data.get("image_object").split('/')[
                                                                            1])
                                                                        .getData(),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        snapshott =
                                                                            snapshot.data;
                                                                        return Container(
                                                                          height:
                                                                              appSize.height * 0.1,
                                                                          width:
                                                                              appSize.width * 0.2,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: MemoryImage(snapshott as Uint8List), fit: BoxFit.fill),
                                                                          ),
                                                                        );
                                                                      } else
                                                                        return SizedBox();
                                                                    }),
                                                          ),
                                                        ),
                                                      ),
                                                      (endtimecheck[index] == 1)
                                                          ? InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  BuyTicket(
                                                                    // earlybirtheconomy: data.get(
                                                                    //     "early_bird_economy_price"),
                                                                    // earlybrdVip: data.get(
                                                                    //     "early_bird_vip_price"),
                                                                    vip_price: earlybirdcheck[index] ==
                                                                            1
                                                                        ? data.get(
                                                                            "early_bird_vip_price")
                                                                        : data.get(
                                                                            "vip_price"),
                                                                    economy: earlybirdcheck[index] ==
                                                                            1
                                                                        ? data.get(
                                                                            "early_bird_economy_price")
                                                                        : data.get(
                                                                            "economy_price"),
                                                                    title: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "title"),
                                                                    start_time: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "start_time"),
                                                                    end_time: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "end_time"),

                                                                    venue: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "venue"),
                                                                    description: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "description"),
                                                                    country: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "country"),
                                                                    disclaimer: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "disclaimer"),
                                                                    id: dataaaa
                                                                        .toString(),
                                                                    organizername: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .get(
                                                                            "organizer_name"),
                                                                    Latitude:
                                                                        data.get(
                                                                            "latitude"),
                                                                    longitude:
                                                                        data.get(
                                                                            "longtitude"),
                                                                    fees: data.get(
                                                                        "event_fee"),
                                                                    // vip_price: data.get(
                                                                    //     "vip_price"),
                                                                    // economy_price: data.get(
                                                                    //     "economy_price"),
                                                                    image: data.get(
                                                                        "image_object")!,
                                                                    category:
                                                                        data.get(
                                                                            "category"),
                                                                  ),
                                                                );
                                                              },
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 15),
                                                                          child:
                                                                              Text(
                                                                            data.get("start_time"),
                                                                            style: TextStyle(
                                                                                fontFamily: 'OpenSans',
                                                                                color: Colors.grey,
                                                                                fontSize: 13),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "category"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 1),
                                                                          child: Text(
                                                                              data.get("end_time").toString(),
                                                                              style: TextStyle(fontFamily: 'OpenSans', color: Colors.transparent, fontSize: 1)),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "early_bird_economy_price"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "vip_price"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "economy_price"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "early_bird_vip_price"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        Text(
                                                                          data
                                                                              .get("event_fee")
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          08,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        data.get(
                                                                            "title"),
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'OpenSans',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          06,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 15),
                                                                          child:
                                                                              Text(
                                                                            data.get("venue"),
                                                                            style: TextStyle(
                                                                                fontFamily: 'OpenSans',
                                                                                color: Colors.grey,
                                                                                fontSize: 15),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          data.get(
                                                                              "disclaimer"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                        // Text(
                                                                        //   data.get(
                                                                        //       "latitude"),
                                                                        //  style: TextStyle(
                                                                        //  fontFamily: 'OpenSans',
                                                                        //       color: Colors
                                                                        //           .transparent,
                                                                        //       fontSize: 1),
                                                                        // ),
                                                                        // Text(
                                                                        //   data.get(
                                                                        //       "longtitude"),
                                                                        //  style: TextStyle(
//fontFamily: 'OpenSans',
                                                                        //       color: Colors
                                                                        //           .transparent,
                                                                        //       fontSize: 1),
                                                                        // ),
                                                                        Text(
                                                                          data.get(
                                                                              "organizer_name"),
                                                                          style: TextStyle(
                                                                              fontFamily: 'OpenSans',
                                                                              color: Colors.transparent,
                                                                              fontSize: 1),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    (earlybirdcheck[index] ==
                                                                            1)
                                                                        ? Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  data.get("early_bird_vip_price"),
                                                                                  style: TextStyle(fontFamily: 'OpenSans', color: Colors.transparent, fontSize: 1),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                data.get("early_bird_economy_price"),
                                                                                style: TextStyle(fontFamily: 'OpenSans', color: Colors.transparent, fontSize: 1),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  data.get("economy_price"),
                                                                                  style: TextStyle(fontFamily: 'OpenSans', color: Colors.transparent, fontSize: 1),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                data.get("vip_price"),
                                                                                style: TextStyle(fontFamily: 'OpenSans', color: Colors.transparent, fontSize: 1),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ]),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox();
                                    });
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container Container1() {
    return Container(
      height: 71,
      width: 350,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/Ellipse 2136.png"),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "5th Sept, 2022",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Color.fromARGB(255, 154, 154, 154),
                    fontSize: 9,
                  ),
                ),
                Text(
                  "Singning International",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "41, Jourge Coard Road, Location",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Color.fromARGB(255, 154, 154, 154),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25),
            child: Icon(
              Icons.arrow_right_outlined,
              color: Color.fromARGB(255, 56, 171, 216),
              size: 32,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
