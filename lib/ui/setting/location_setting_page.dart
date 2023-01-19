import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:link_up/get_controller/auth_controller.dart';

class LocationSettingPage extends StatefulWidget {
  const LocationSettingPage({Key? key}) : super(key: key);

  @override
  _LocationSettingPageState createState() => _LocationSettingPageState();
}

class _LocationSettingPageState extends State<LocationSettingPage> {
  Completer<GoogleMapController> _controller = Completer();
  AuthController authController = Get.find(tag: AuthController().toString());
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Marker> markers = <Marker>[];
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  late LatLng currentPosition;
  LatLng? selectedPosition;
  String? street, administrativeArea, postalCode, country;

  void _getCurrentUserLocation() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      }
    });

    await GeolocatorPlatform.instance
        .getCurrentPosition()
        .then((Position position) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: "en");
      Placemark place = placemarks[0];

      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
        selectedPosition = currentPosition;
        street = place.street ?? '';
        administrativeArea = place.administrativeArea ?? '';
        postalCode = place.postalCode ?? '';
        country = place.country ?? '';
      });
    }).catchError((e) {
      print(e);
    });

    if (selectedPosition != null && selectedPosition?.latitude != null) {
      _markers.add(Marker(
        markerId: MarkerId(selectedPosition.toString()),
        position: selectedPosition ?? LatLng(0.0, 0.0),
        infoWindow: InfoWindow(
          title: 'my_location_title'.tr,
          snippet: selectedPosition?.latitude.toString().substring(9) ??
              '' +
                  ',  ' +
                  (selectedPosition?.longitude.toString().substring(10) ?? ''),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
  }

  void addLocation() {
    db
        .collection('users')
        .doc(authController.user!.value.uid)
        .collection('locations')
        .add({
      'latitude': selectedPosition?.latitude,
      'longitude': selectedPosition?.longitude,
      'street': street,
      'administrativeArea': administrativeArea,
      'postalCode': postalCode,
      'country': country,
      'isActive': false,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    });
    Navigator.of(context).pop();
  }

  currentLocationPickerDialog(BuildContext context) {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Container(child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                child: Stack(
                  children: [
                    currentPosition == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GoogleMap(
                            mapType: _currentMapType,
                            initialCameraPosition: CameraPosition(
                                target: currentPosition, zoom: 15),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            myLocationEnabled: true,
                            markers: _markers,
                            onTap: (point) async {
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      point.latitude, point.longitude);
                              Placemark place = placemarks[0];
                              setState(() {
                                _markers.clear();
                                selectedPosition = point;
                                _markers.add(Marker(
                                  markerId:
                                      MarkerId(selectedPosition.toString()),
                                  position: selectedPosition!,
                                  infoWindow: InfoWindow(
                                    title: 'my_location_title'.tr,
                                    snippet: selectedPosition?.latitude
                                            .toString()
                                            .substring(10) ??
                                        '' +
                                            ',  ' +
                                            (selectedPosition?.longitude
                                                    .toString()
                                                    .substring(10) ??
                                                ''),
                                  ),
                                  icon: BitmapDescriptor.defaultMarker,
                                ));
                                street = place.street ?? '';
                                administrativeArea =
                                    place.administrativeArea ?? '';
                                postalCode = place.postalCode ?? '';
                                country = place.country ?? '';
                              });
                            },
                          ),
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                _currentMapType =
                                    _currentMapType == MapType.normal
                                        ? MapType.satellite
                                        : MapType.normal;
                              });
                            },
                            heroTag: 'btn1',
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.map, size: 36.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              addLocation();
                            },
                            heroTag: 'btn2',
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.add_box, size: 36.0),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: street != null
                          ? Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              height: 60,
                              width: 280,
                              child: SingleChildScrollView(
                                child: Text(
                                  street! +
                                      ', ' +
                                      (administrativeArea ?? '') +
                                      ', ' +
                                      (postalCode ?? '') +
                                      ', ' +
                                      (country ?? ''),
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              );
            },
          )),
        );
      },
    );
  }

  Future _isActiveConfirmDialog(
      BuildContext context, String selectedLocationID) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'confirm_select'.tr,
              style: TextStyle(fontFamily: "OpenSans", color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'make_location_default'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            child: Text(
                              "no".tr,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.white)),
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            child: Text(
                              "yes".tr,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              _isActiveLocation(selectedLocationID);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.white)),
                              backgroundColor: Colors.red[900],
                              padding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _isActiveLocation(String id) async {
    await db
        .collection('users')
        .doc(authController.user!.value.uid)
        .collection('locations')
        .where('isActive', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.length != 0) {
        querySnapshot.docs.forEach((doc) {
          db
              .collection('users')
              .doc(authController.user!.value.uid)
              .collection('locations')
              .doc(doc.id)
              .update({'isActive': false});
        });
      }
    });
    db
        .collection('users')
        .doc(authController.user!.value.uid)
        .collection('locations')
        .doc(id)
        .update({'isActive': true});
    Navigator.of(context).pop();
  }

  Future _isDeleteConfirmDialog(
      BuildContext context, String selectedLocationID) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'confirm_delete'.tr,
              style: TextStyle(fontFamily: "OpenSans", color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'delete_this_location'.tr,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            child: Text(
                              "no".tr,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.white)),
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          child: ElevatedButton(
                            child: Text(
                              "yes".tr,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () async {
                              await db
                                  .collection('users')
                                  .doc(authController.user!.value.uid)
                                  .collection('locations')
                                  .doc(selectedLocationID)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.white)),
                              backgroundColor: Colors.red[900],
                              padding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'location'.tr,
            style: TextStyle(fontFamily: "OpenSans", color: Colors.black),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 10.0,
      ),
      body: GetBuilder(
          init: authController,
          builder: (_) {
            return Container(
                width: width,
                height: height,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: db
                            .collection('users')
                            .doc(authController.user!.value.uid)
                            .collection('locations')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData && snapshot.data == null)
                            return new Container(
                              height: height * 0.5,
                              alignment: Alignment.center,
                              child: Text('no_location_available'.tr),
                            );
                          return ListView(
                              children: snapshot.data!.docs.map<Widget>((docs) {
                            return GestureDetector(
                              onLongPress: () {
                                _isActiveConfirmDialog(context, docs.id);
                              },
                              onTap: () {
                                authController
                                    .alert1('please_tap_longer_setting'.tr);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        docs['isActive'] == true ? 0 : 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black38,
                                            width: 0.5))),
                                child: ListTile(
                                    leading: Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.pin_drop_rounded,
                                          size: 30,
                                          color: docs['isActive'] == true
                                              ? Colors.blue
                                              : Colors.grey,
                                        )),
                                    title: docs['isActive'] == true
                                        ? Text(
                                            'my_location',
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container(),
                                    subtitle: Text(docs['street'] +
                                        ', ' +
                                        docs['administrativeArea'] +
                                        ', ' +
                                        docs['postalCode'] +
                                        ', ' +
                                        docs['country']),
                                    trailing: Container(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          docs['isActive'] == true
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.blue[600],
                                                  ),
                                                  onPressed: () {})
                                              : Container(),
                                          IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                _isDeleteConfirmDialog(
                                                    context, docs.id);
                                              })
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }).toList());
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentLocationPickerDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: Colors.blue[600],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.flight,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'add_new_location'.tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
