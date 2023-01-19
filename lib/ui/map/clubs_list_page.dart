import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClubsListPage extends StatefulWidget {
  const ClubsListPage({Key? key}) : super(key: key);

  @override
  _ClubsListPageState createState() => _ClubsListPageState();
}

class _ClubsListPageState extends State<ClubsListPage> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  static const LatLng _center = const LatLng(45.521563, -122.08400000000002);
  LatLng _lastMapPosition = _center;
  late LatLng currentPosition;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.521563, -122.677433),
    zoom: 15.0,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Set<Marker> _createMarker() {
    return {
      Marker(markerId: MarkerId("marker_1"), position: _lastMapPosition),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  void _getUserLocation() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        Geolocator.requestPermission();
      }
    });
    // _locationPermission = await Geolocator.requestPermission();

    await GeolocatorPlatform.instance
        .getCurrentPosition()
        .then((Position position) {
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            currentPosition == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    mapType: _currentMapType,
                    initialCameraPosition:
                        CameraPosition(target: currentPosition, zoom: 15),

                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    // liteModeEnabled: true,
                    markers: _markers,
                  ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      heroTag: 'btn1',
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    // FloatingActionButton(
                    //   onPressed: _onAddMarkerButtonPressed,
                    //   heroTag: 'btn2',
                    //   materialTapTargetSize: MaterialTapTargetSize.padded,
                    //   backgroundColor: Colors.green,
                    //   child: const Icon(Icons.add_location_sharp, size: 36.0),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: currentPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
