import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(20.5937, 78.9629));
// GoogleMapController googleMapController;
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController c) {
          // to control the camera position of the map
          _controller = c;
        },
      ),
    );
  }
}
