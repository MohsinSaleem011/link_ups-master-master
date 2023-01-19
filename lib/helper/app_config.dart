import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(this._context, this._height, this._heightPadding, this._width,
      this._widthPadding) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String currency = 'usd';

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding * v;
  }

  double buttonHeight() {
    return 40.0;
  }

  List<String> abuseList = [
    'Underage User',
    'Nudity or Sexual Content',
    'Span/Scam',
    'Hate speech',
    'Illegal Activity',
    'Suicide',
    'Threats of violence',
    'Child exploitation',
    'Bullying'
  ];

  String googleApiKey = 'AIzaSyBQneXaNwEI9t0F_peH7EOxJnpHTIAaYr4';
}

class Utils {
  Utils._internal();

  static const List<Map<String, String>> carribAndLatinCountry = [
    {
      "name": "Anguilla",
      "code": "AI",
      "dial_code": "+1",
    },
    {
      "name": "Antigua and Barbuda",
      "code": "AG",
      "dial_code": "+1268",
    },
    {
      "name": "Argentina",
      "code": "AR",
      "dial_code": "+54",
    },
    {
      "name": "Aruba",
      "code": "AW",
      "dial_code": "+297",
    },
    {
      "name": "Bahamas",
      "code": "BS",
      "dial_code": "+1242",
    },
    {
      "name": "Barbados",
      "code": "BB",
      "dial_code": "+1246",
    },
    {
      "name": "Belize",
      "code": "BZ",
      "dial_code": "+501",
    },
    {
      "name": "Bolivia",
      "code": "BO",
      "dial_code": "+591",
    },
    {
      "name": "Bonaire",
      "code": "BQ",
      "dial_code": "+599",
    },
    {
      "name": "Brasil",
      "code": "BR",
      "dial_code": "+55",
    },
    {
      "name": "British Virgin Islands",
      "code": "VG",
      "dial_code": "+1",
    },
    {
      "name": "Cayman Islands",
      "code": "KY",
      "dial_code": "+1",
    },
    {
      "name": "Chile",
      "code": "CL",
      "dial_code": "+56",
    },
    {
      "name": "Colombia",
      "code": "CO",
      "dial_code": "+57",
    },
    {
      "name": "Costa Rica",
      "code": "CR",
      "dial_code": "+506",
    },
    {
      "name": "Cuba",
      "code": "CU",
      "dial_code": "+53",
    },
    {
      "name": "Curaçao",
      "code": "CW",
      "dial_code": "+599",
    },
    {
      "name": "Dominica",
      "code": "DM",
      "dial_code": "+1767",
    },
    {
      "name": "Dominican Republic",
      "code": "DO",
      "dial_code": "+1",
    },
    {
      "name": "Ecuador",
      "code": "EC",
      "dial_code": "+593",
    },
    {
      "name": "El Salvador",
      "code": "SV",
      "dial_code": "+503",
    },
    {
      "name": "Falkland Islands",
      "code": "FK",
      "dial_code": "+500",
    },
    {
      "name": "Federal Dependencies of Venezuela",
      "code": "VE",
      "dial_code": "+58",
    },
    {
      "name": "French Guiana",
      "code": "GF",
      "dial_code": "+594",
    },
    {
      "name": "Grenada",
      "code": "GD",
      "dial_code": "+1473",
    },
    {
      "name": "Guadeloupe",
      "code": "GP",
      "dial_code": "+590",
    },
    {
      "name": "Guatemala",
      "code": "GT",
      "dial_code": "+502",
    },
    {
      "name": "Guyana",
      "code": "GY",
      "dial_code": "+592",
    },
    {
      "name": "Haïti",
      "code": "HT",
      "dial_code": "+509",
    },
    {
      "name": "Honduras",
      "code": "HN",
      "dial_code": "+504",
    },
    {
      "name": "Jamaica",
      "code": "JM",
      "dial_code": "+1876",
    },
    {
      "name": "Martinique",
      "code": "MQ",
      "dial_code": "+596",
    },
    {
      "name": "Mexico",
      "code": "MX",
      "dial_code": "+52",
    },
    {
      "name": "Montserrat",
      "code": "MS",
      "dial_code": "+1",
    },
    {
      "name": "Nicaragua",
      "code": "NI",
      "dial_code": "+505",
    },
    {
      "name": "Nueva Esparta",
      "code": "NE",
      "dial_code": "+58",
    },
    {
      "name": "Panamá",
      "code": "PA",
      "dial_code": "+507",
    },
    {
      "name": "Paraguay",
      "code": "PY",
      "dial_code": "+595",
    },
    {
      "name": "Perú",
      "code": "PE",
      "dial_code": "+51",
    },
    {
      "name": "Puerto Rico",
      "code": "PR",
      "dial_code": "+1",
    },
    {
      "name": "Saba",
      "code": "SB",
      "dial_code": "+599",
    },
    {
      "name": "Saint Barthelemy (fr)",
      "code": "BL",
      "dial_code": "+590",
    },
    {
      "name": "Saint Kitts and Nevis",
      "code": "KN",
      "dial_code": "+1869",
    },
    {
      "name": "Saint Lucia",
      "code": "LC",
      "dial_code": "+1758",
    },
    {
      "name": "Sint Maarten",
      "code": "SX",
      "dial_code": "+721",
    },
    {
      "name": "Saint Vincent and the Grenadines",
      "code": "VC",
      "dial_code": "+1784",
    },
    {
      "name": "Suriname",
      "code": "SR",
      "dial_code": "+597",
    },
    {
      "name": "Saint Martin (FR)",
      "code": "MF",
      "dial_code": "+590",
    },
    {
      "name": "Trinidad and Tobago",
      "code": "TT",
      "dial_code": "+1868",
    },
    {
      "name": "Turks and Caicos",
      "code": "TC",
      "dial_code": "+1",
    },
    {
      "name": "U.S. Virgin Islands",
      "code": "VI",
      "dial_code": "+1",
    },
    {
      "name": "Uruguay",
      "code": "UY",
      "dial_code": "+598",
    },
    {
      "name": "Venezuela",
      "code": "VE",
      "dial_code": "+58",
    },
  ];
}
