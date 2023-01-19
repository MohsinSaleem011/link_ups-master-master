class ContactModel {
  final String contactId;
  final String name;
  final String avatar;

  ContactModel({
    required this.contactId,
    required this.name,
    required this.avatar,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return new ContactModel(
      contactId: json['contactId'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["contactId"] = contactId;
    map["name"] = name;
    map["avatar"] = avatar;
    return map;
  }
}
