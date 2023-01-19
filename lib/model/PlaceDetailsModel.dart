// To parse this JSON data, do
//
//     final restaurantReviews = restaurantReviewsFromJson(jsonString);

import 'dart:convert';

RestaurantReviews restaurantReviewsFromJson(String str) =>
    RestaurantReviews.fromJson(json.decode(str));

String restaurantReviewsToJson(RestaurantReviews data) =>
    json.encode(data.toJson());

class RestaurantReviews {
  List<dynamic> htmlAttributions;
  Result result;
  String status;

  RestaurantReviews({
    required this.htmlAttributions,
    required this.result,
    required this.status,
  });

  factory RestaurantReviews.fromJson(Map<String, dynamic> json) =>
      new RestaurantReviews(
        htmlAttributions:
            new List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: Result.fromJson(json["result"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions":
            new List<dynamic>.from(htmlAttributions.map((x) => x)),
        "result": result.toJson(),
        "status": status,
      };
}

class Result {
  List<AddressComponent> addressComponents;
  String adrAddress;
  String formattedAddress;
  String formattedPhoneNumber;
  Geometry geometry;
  String icon;
  String id;
  String internationalPhoneNumber;
  String name;
  OpeningHours? openingHours;
  List<Photo> photos;
  String placeId;
  PlusCode? plusCode;
  double rating;
  String reference;
  List<Review> reviews;
  String scope;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;

  Result({
    required this.addressComponents,
    required this.adrAddress,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.icon,
    required this.id,
    required this.internationalPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.reviews,
    required this.scope,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    required this.website,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
        addressComponents: new List<AddressComponent>.from(
            json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"],
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        id: json["id"] ?? '',
        internationalPhoneNumber: json["international_phone_number"],
        name: json["name"],
        openingHours: json["opening_hours"] != null
            ? OpeningHours.fromJson(json["opening_hours"] ?? {})
            : null,
        photos:
            new List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] != null
            ? PlusCode.fromJson(json["plus_code"])
            : null,
        rating: json["rating"].toDouble(),
        reference: json["reference"],
        reviews: new List<Review>.from(
            json["reviews"].map((x) => Review.fromJson(x))),
        scope: json["scope"] ?? '',
        types: new List<String>.from(json["types"].map((x) => x)),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
        website: json["website"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "address_components":
            new List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry.toJson(),
        "icon": icon,
        "id": id,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "opening_hours": openingHours?.toJson(),
        "photos": new List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "rating": rating,
        "reference": reference,
        "reviews": new List<dynamic>.from(reviews.map((x) => x.toJson())),
        "scope": scope,
        "types": [],
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
        "website": website,
      };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      new AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: new List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": new List<dynamic>.from(types.map((x) => x)),
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
  bool openNow;
  List<Period> periods;
  List<String> weekdayText;

  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => new OpeningHours(
        openNow: _checkPlaceAvailbility(json),
        periods: _getPeriod(json),
        weekdayText: _getWeekDay(json),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": new List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": new List<dynamic>.from(weekdayText.map((x) => x)),
      };
}

List<String> _getWeekDay(dynamic data) {
  if (data != null) {
    return new List<String>.from(data["weekday_text"].map((x) => x));
  } else {
    return [];
  }
}

List<Period> _getPeriod(dynamic data) {
  if (data != null) {
    return new List<Period>.from(
        data["periods"].map((x) => Period.fromJson(x)));
  } else {
    return [];
  }
}

bool _checkPlaceAvailbility(dynamic data) {
  if (data == null) {
    return false;
  } else {
    return data['open_now'] ?? false;
  }
}

class Period {
  Open open;

  Period({
    required this.open,
  });

  factory Period.fromJson(Map<String, dynamic> json) => new Period(
        open: Open.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
      };
}

class Open {
  int day;
  String time;

  Open({
    required this.day,
    required this.time,
  });

  factory Open.fromJson(Map<String, dynamic> json) => new Open(
        day: json["day"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => new Photo(
        height: json["height"],
        htmlAttributions:
            new List<String>.from(json["html_attributions"].map((x) => x)),
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
  String compoundCode;
  String globalCode;

  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic> json) => new PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Review {
  String authorName;
  String authorUrl;
  String language;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;

  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
  });

  factory Review.fromJson(Map<String, dynamic> json) => new Review(
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        language: json["language"],
        profilePhotoUrl: json["profile_photo_url"],
        rating: json["rating"],
        relativeTimeDescription: json["relative_time_description"],
        text: json["text"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
      };
}
