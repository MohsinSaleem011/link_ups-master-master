import 'package:flutter/material.dart';

class SharedManager {
  // singleton
  static final SharedManager _singleton = SharedManager._internal();
  factory SharedManager() => _singleton;
  SharedManager._internal();
  static SharedManager get shared => _singleton;

  // variables
  String? username;
  String? password;

  String getImageURL(String refrences) {
    var googleImage =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$refrences&sensor=false&key=AIzaSyDXMEfylOCYGgpFigoFzf-FS6yixy40Mas";

    return googleImage;
  }

  final String placeId = '';
  String themeType = 'light';

  ThemeData getThemeType() {
    return new ThemeData(
      primarySwatch: Colors.red,
      brightness: _getBrightness(),
    );
  }

  Brightness _getBrightness() {
    if (themeType == "dark") {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }
}

class AppColors {
  static const Color PRIMARY_COLOR = Colors.red;
  static Color WHITE = hexToColor("#ffffff");
  static Color FBBG_COLOR = hexToColor("#5B7CB4");
  static Color GPBG_COLOR = hexToColor("#D95946");
  static const Color PRIMARY_COLOR_LIGHT = Color(0xFFA5CFF1);
  static const Color PRIMARY_COLOR_DARK = Color(0xFF0D3656);
  static const Color ACCENT_COLOR = Color(0xFFF2DA04);
  static const Color BACK = Colors.black;
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
