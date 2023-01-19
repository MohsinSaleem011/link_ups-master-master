import 'package:url_launcher/url_launcher.dart';

class DrawerManager {
  static final DrawerManager _singleton = DrawerManager._internal();
  factory DrawerManager() => _singleton;
  DrawerManager._internal();
  static DrawerManager get shared => _singleton;

//This is for the latitude
  var latitude = "";
  var longitude = "";
  var radius = "2000";
  var title = "Enter Your Location";
  var currentTitle = "";
  var isFromDrawer = true;

  double currentlati = 0;
  double currentlong = 0;
}

class Language {
  final String code;
  final String name;
  const Language(this.name, this.code);
  int get hashCode => code.hashCode;
  bool operator ==(Object other) => other is Language && other.code == code;
}

class MapUtils {
  static openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
