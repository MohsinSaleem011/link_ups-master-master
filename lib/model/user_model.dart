import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.newCity1,
    required this.newCountry1,
    required this.newState1,

    this.uid,
    this.fcmToken,
    required this.aboutMe,
    required this.avatar,
    required this.birthday,
    required this.age,
    required this.country,
    required this.countryCode,
    required this.phoneNumberDialCode,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.interests,
    required this.job,
    required this.morePhotos,
    required this.linkWithMePhoneCode,
    required this.phoneNumber,
    required this.status,
    required this.whyarewehere,
    required this.university,
    required this.ageFilter,
    required this.distanceFilter,
    required this.isGhost,
    required this.isClub,
    required this.isRestaurant,
    required this.isTopShelf,
    required this.isLiveStream,
    required this.language,
    required this.linkMeWith,
    required this.linkMeWithCountryCode,
    required this.whichLatinCountryYouLinkedWith,
    required this.newMatchNotification,
    required this.newMessageNotification,
    required this.promotionNotification,
    required this.lastActive,
    required this.createdAt,
    required this.updatedAt,
    required this.subscription,
    required this.stripeCustomerId,
    this.showMyAge = false,
  });
  @JsonKey(name: 'uid')
  String? uid;
  @JsonKey(name: 'fcmToken')
  String? fcmToken;
  @JsonKey(name: 'about_me', defaultValue: '')
  String aboutMe;
  @JsonKey(name: 'avatar', defaultValue: '')
  String avatar;
  @JsonKey(name: 'birthday', defaultValue: 0)
  int birthday;
  @JsonKey(name: 'age',defaultValue: 20)
  int age;
  @JsonKey(name: 'country', defaultValue: 'Bahamas')
  String country;
  @JsonKey(name: 'country_code', defaultValue: 'BS')
  String countryCode;
  @JsonKey(name: 'phone_number_dial_code', defaultValue: '+1242')
  String phoneNumberDialCode;
  @JsonKey(name: 'email', defaultValue: '')
  String email;
  @JsonKey(name: 'first_name', defaultValue: '')
  String firstName;
  @JsonKey(name: 'last_name', defaultValue: '')
  String lastName;
  @JsonKey(name: 'new_country', defaultValue: '')
  String newCountry1;
  @JsonKey(name: 'new_state', defaultValue: '')
  String  newState1;
  @JsonKey(name: 'new_city', defaultValue: '')
  String newCity1;
  @JsonKey(name: 'gender', defaultValue: 'Male')
  String gender;
  @JsonKey(name: 'interests', defaultValue: [])
  List<String> interests;
  @JsonKey(name: 'job', defaultValue: '')
  String job;
  @JsonKey(name: 'more_photos', defaultValue: [])
  List<String> morePhotos;
  @JsonKey(name: 'link_with_me_phone_code', defaultValue: '+1242')
  String linkWithMePhoneCode;
  @JsonKey(name: 'phone_number', defaultValue: '')
  String phoneNumber;
  @JsonKey(name: 'status', defaultValue: true)
  bool status;
  @JsonKey(name: 'whyare', defaultValue: 'Bahamas')
  String whyarewehere;
  @JsonKey(name: 'university', defaultValue: '')
  String university;
  @JsonKey(name: 'age_filter', defaultValue: ['19', '50'])
  List<String> ageFilter;
  @JsonKey(name: 'distance_filter', defaultValue: ['10', '1000'])
  List<String> distanceFilter;
  @JsonKey(name: 'which_latin_country_you_linked_with', defaultValue: 'Bahamas')
  String whichLatinCountryYouLinkedWith;
  @JsonKey(name: 'is_ghost', defaultValue: false)
  bool isGhost;
  @JsonKey(name: 'is_club', defaultValue: false)
  bool isClub;
  @JsonKey(name: 'is_restaurant', defaultValue: false)
  bool isRestaurant;
  @JsonKey(name: 'is_top_shelf', defaultValue: false)
  bool isTopShelf;
  @JsonKey(name: 'is_live_streaming', defaultValue: false)
  bool isLiveStream;
  @JsonKey(name: 'language', defaultValue: 'English')
  String language;
  @JsonKey(name: 'link_me_with', defaultValue: 'Female')
  String linkMeWith;
  @JsonKey(name: 'link_me_with_country_code', defaultValue: 'BS')
  String linkMeWithCountryCode;
  @JsonKey(name: 'new_match_notification', defaultValue: true)
  bool newMatchNotification;
  @JsonKey(name: 'new_message_notification', defaultValue: true)
  bool newMessageNotification;
  @JsonKey(name: 'promotion_notification', defaultValue: true)
  bool promotionNotification;
  @JsonKey(name: 'last_active')
  int lastActive;
  @JsonKey(name: 'created_at')
  int createdAt;
  @JsonKey(name: 'updated_at')
  int updatedAt;
  @JsonKey(name: 'show_age', defaultValue: false)
  bool showMyAge;
  @JsonKey(name: 'subscription', defaultValue: [])
  List subscription;
  @JsonKey(name: 'stripe_customer_id', defaultValue: '')
  String stripeCustomerId;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
