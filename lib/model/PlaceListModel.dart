import 'dart:convert';

RestaurantList welcomeFromJson(String str) =>
    RestaurantList.fromJson(json.decode(str));

String welcomeToJson(RestaurantList data) => json.encode(data.toJson());

class RestaurantList {
  List<dynamic>? htmlAttributions;
  String? nextPageToken;
  List<Result>? results;
  String? status;

  RestaurantList({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) =>
      new RestaurantList(
        htmlAttributions:
            new List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: json["next_page_token"],
        results: new List<Result>.from(
            json["results"].map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions":
            new List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": new List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
      };
}

class Result {
  Geometry geometry;
  String icon = "";
  String id = "";
  String name = "";
  OpeningHours openingHours;
  List<Photo> photos = [];
  String placeId = "";
  PlusCode? plusCode;
  double rating = 0.0;
  String reference = "";
  String scope = "";
  List<String> types;
  int userRatingsTotal = 0;
  String vicinity = "";

  Result({
    required this.geometry,
    required this.icon,
    required this.id,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        id: json["id"] ?? '',
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"] ?? {}),
        photos:
            new List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] != null
            ? PlusCode.fromJson(json["plus_code"])
            : null,
        rating: json["rating"].toDouble(),
        reference: json["reference"],
        scope: json["scope"],
        types: new List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
      );

  List<Photo> checkImageJson(dynamic data) {
    if (data["photos"] != null) {
      return new List<Photo>.from(data["photos"].map((x) => Photo.fromJson(x)));
    } else {
      return [];
    }
  }

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "icon": icon,
        "id": id,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "photos": new List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": new List<dynamic>.from(types.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
      };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => new Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => new Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => new Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}

class OpeningHours {
  bool openNow = false;

  OpeningHours({
    required this.openNow,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => new OpeningHours(
        openNow: _checkNull(json),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

bool _checkNull(dynamic data) {
  if (data == null) {
    return false;
  } else {
    return data?['open_now'] ?? false;
  }
}

class Photo {
  int height = 0;
  List<String> htmlAttributions = [];
  String photoReference = "";
  int width = 0;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => new Photo(
        height: json["height"],
        htmlAttributions: [],
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions":
            new List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCode {
  String compoundCode = "";
  String globalCode = "";

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) => new PlusCode(
        compoundCode: _checkStringNull(json),
        globalCode: _checkStringForGlobalCode(json),
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

String _checkStringForGlobalCode(dynamic data) {
  if (data == null) {
    return " ";
  } else {
    return data["global_code"];
  }
}

String _checkStringNull(dynamic data) {
  if (data == null) {
    return " ";
  } else {
    return data["compound_code"];
  }
}
