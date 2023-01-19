class SoulMateModel {
  String uid;
  String avatar;
  String firstname;
  String lastname;
  String country;
  String phone;
  String gender;
  int age;
  String job;

  SoulMateModel({
    required this.uid,
    required this.avatar,
    required this.firstname,
    required this.lastname,
    required this.country,
    required this.phone,
    required this.gender,
    required this.age,
    required this.job,
  });

  factory SoulMateModel.fromJson(Map<String, dynamic> json) {
    return new SoulMateModel(
      uid: json['uid'],
      avatar: json['avatar'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      country: json['country'],
      phone: json['phone'],
      gender: json['gender'],
      age: json['birthday'],
      job: json['job'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['uid'] = uid;
    map['avatar'] = avatar;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['country'] = country;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birthday'] = age;
    map['job'] = job;
    return map;
  }
}
