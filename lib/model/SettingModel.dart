class SettingModel {
  List<dynamic> age;
  List<dynamic> distance;
  bool ghostStatus;
  String language;
  String linkWith;
  String meetFrom;
  String meetFromCode;
  String meetFromDialCode;
  String meetFromPreference;
  String nationality;
  String nationalityCode;
  String nationalityDialCode;
  bool isClub;
  bool isTopShelf;
  bool isRestaurant;
  int timestamp;

  SettingModel({
    required this.age,
    required this.distance,
    required this.ghostStatus,
    required this.language,
    required this.linkWith,
    required this.nationality,
    required this.timestamp,
    required this.isClub,
    required this.isRestaurant,
    required this.isTopShelf,
    required this.nationalityCode,
    required this.nationalityDialCode,
    required this.meetFrom,
    required this.meetFromCode,
    required this.meetFromDialCode,
    required this.meetFromPreference,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return new SettingModel(
      age: json['age'],
      distance: json['distance'],
      ghostStatus: json['ghostStatus'],
      language: json['language'],
      linkWith: json['linkWith'],
      nationality: json['nationality'],
      timestamp: json['timestamp'],
      isClub: json['is_club'],
      isRestaurant: json['is_restaurant'],
      isTopShelf: json['is_top_shelf'],
      nationalityCode: json['nationality_code'],
      nationalityDialCode: json['nationality_dial_code'],
      meetFrom: json['meet_from'],
      meetFromCode: json['meet_from_code'],
      meetFromDialCode: json['meet_from_dial_code'],
      meetFromPreference: json['meet_from_preference'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['age'] = age;
    map['distance'] = distance;
    map['ghostStatus'] = ghostStatus;
    map['language'] = language;
    map['linkWith'] = linkWith;
    map['nationality'] = nationality;
    map['timestamp'] = timestamp;
    map['is_club'] = isClub;
    map['is_restaurant'] = isRestaurant;
    map['is_top_shelf'] = isTopShelf;
    map['nationality_code'] = nationalityCode;
    map['nationality_dial_code'] = nationalityDialCode;
    map['meet_from'] = meetFrom;
    map['meet_from_code'] = meetFromCode;
    map['meet_from_dial_code'] = meetFromDialCode;
    map['meet_from_preference'] = meetFromPreference;
    return map;
  }
}
