import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:link_up/get_controller/base_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/helper/shared_pref_service.dart';
import 'package:link_up/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;

class AuthController extends BaseController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController aboutMeController = new TextEditingController();
  TextEditingController jobController = new TextEditingController();
  TextEditingController universityController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController dobController =
      new TextEditingController(text: 'Select Your Birthday');
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  List<String> _selectedInterest = [];
  // List<String> selectedInterest = [];
  String? interestRequired;
  RxString phoneNumberCode = ''.obs;
  RxString gender = 'Male'.obs;
  RxInt birthday = DateTime.now().millisecondsSinceEpoch.obs;
  RxInt age = 0.obs;
  RxString linkmeWith = 'Female'.obs;
  RxString nationalityName = 'Bahamas'.obs;
  RxString nationalityCode = 'BS'.obs;
  RxString nationalityDialCode = '+1242'.obs;
  RxString countryMeetFromName = "Bahamas".obs;
  RxString countryMeetFromCode = "BS".obs;
  RxString countryMeetFromDialCode = "+1242".obs;
  RxString meetFromPreference = 'all'.obs;
  RxBool isGhoststatus = false.obs;
  RxBool dontShowMyAge = false.obs;
  List<String> morePhotosURLs = [];
  List<String> genders = ['Male', 'Female'];
  RxBool newMatchesNotification = true.obs;
  RxBool newMessageNotification = true.obs;
  RxBool promotionNotification = true.obs;
  Rx<String> actLocation = "".obs;
  List<bool> photoFlag = [];
  String? selectedImageURL;
  File? imageFile;
  String? avatar;
  List listNotification = [].obs;
  RxString NewCountry="".obs;
  RxString NewState="".obs;
  RxString NewCity="".obs;

  //
  // For Origin Country
  //
  RxString countryPhoneCode = "+1242".obs;
  RxString countryCode = "BS".obs;
  RxString countryName = "Bahamas".obs;
  RxString languageImage = "assets/flag/gb.png".obs;
  RxString language = "English".obs;
  RxString statename="".obs;
  RxString statecode="".obs;
  RxString statePhonecode="".obs;
  RxMap<String, dynamic> demoInterestList = {
    'Photograph': false,
    'Gardening': false,
    'Cooking': false,
    'Fashion': false,
    'Shopping': false,
    'Travelling': false,
    'Sports': false,
    'Dancing': false,
    'Biking': false,
    'Movies': false,
  }.obs;
  Rx<RangeValues> ageRangeValues = RangeValues(20, 60).obs;
  Rx<RangeValues> distanceRangeValue = RangeValues(10, 200).obs;

  Rx<UserModel>? user;
   void onCountryChange(String Country) {
    NewCountry.value = Country;
    update();
  }

  void updateLoading(bool value) {
    loading = RxBool(value);
    update();
  }

  updateIsGhostStatus(bool value) {
    isGhoststatus = RxBool(value);
    update();
  }

  updateShowAgeStatus(bool value) {
    dontShowMyAge = RxBool(value);
    update();
  }

  updatelanguage(String value) {
    language = RxString(value);
    update();
  }

  updateLanguageFlag(String value) {
    languageImage = RxString(value);
    update();
  }

  void updateNewMatchesNotification(bool value) {
    newMatchesNotification = RxBool(value);
    update();
  }

  void updateMessageNotification(bool value) {
    newMessageNotification = RxBool(value);
    update();
  }

  void updatePromotionNotification(bool value) {
    promotionNotification = RxBool(value);
    update();
  }

  morePhotoDelete(int index) {
    morePhotosURLs.removeAt(index);
    photoFlag.removeAt(index);
    UserModel _user = user!.value;
    _user.morePhotos = morePhotosURLs;
    updateUser(_user);
  }

  void updateInterestList(dynamic value, dynamic key) {
    demoInterestList[key] = value;
    print(demoInterestList);
          update();
    }
    
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      updateDOB(picked.millisecondsSinceEpoch);
      dobController.text = timeStampToDate(picked.millisecondsSinceEpoch);
    }
  }

  Future<void> getUser(String uid, BuildContext context) async {
    try {
      var event = await firebaseFirestore.collection('users').doc(uid).get();

      UserModel _user = UserModel.fromJson(event.data()!);

      String? _token = await messaging.getToken();
      if (_token != '' && _token != null) {
        _user.fcmToken = _token;
        user = Rx<UserModel>(_user);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .set(_user.toJson());
      }
      var _tmpuser = _user;
      if (_tmpuser.firstName != '') {
        firstnameController.text = _tmpuser.firstName;
      }
      if (_tmpuser.lastName != '') {
        lastnameController.text = _tmpuser.lastName;
      }
      if (_tmpuser.country != '') {
        countryName = RxString(_tmpuser.country);
      }
      if (_tmpuser.phoneNumberDialCode != '') {
        phoneNumberCode = RxString(_tmpuser.phoneNumberDialCode);
      }
      if (_tmpuser.phoneNumber != '') {
        phoneNumberController.text = _tmpuser.phoneNumber;
      }
      if (_tmpuser.gender != '') {
        gender = RxString(_tmpuser.gender);
      }
      if (_tmpuser.birthday != 0) {
        updateDOB(_tmpuser.birthday);
        birthday = RxInt(_tmpuser.birthday);
      }
      if (_tmpuser.birthday != 0) {
        dobController.text = timeStampToDate(_tmpuser.birthday);
      }
      if (_tmpuser.aboutMe != '') {
        aboutMeController.text = _tmpuser.aboutMe;
      }
      if (_tmpuser.whyarewehere != '') {
        actLocation.value = _tmpuser.whyarewehere;
      }
       if (_tmpuser.newCountry1 != '') {
        NewCountry.value = _tmpuser.newCountry1;
      }
       if (_tmpuser.newState1 != '') {
        NewState.value = _tmpuser.newState1;
      }
       if (_tmpuser.newCity1 != '') {
        NewCity.value = _tmpuser.newCity1;
      }
      if (_tmpuser.job != '') {
        jobController.text = _tmpuser.job;
      }
      if (_tmpuser.university != '') {
        universityController.text = _tmpuser.university;
      }
      if (_tmpuser.linkMeWithCountryCode != '') {
        meetFromPreference = RxString(_tmpuser.linkMeWithCountryCode);
      }
      newMatchesNotification = RxBool(_tmpuser.newMatchNotification);
      newMessageNotification = RxBool(_tmpuser.newMessageNotification);
      promotionNotification = RxBool(_tmpuser.promotionNotification);

      if (_tmpuser.interests.length > 0) {
        _tmpuser.interests.forEach((element) {
          demoInterestList.forEach((key, value) {
            if (key == element) {
              demoInterestList[key] = true;
            }
          });
        });
      }
      if (user!.value.subscription.isNotEmpty
          ? user!.value.subscription
              .where((element) =>
                  DateTime.fromMillisecondsSinceEpoch(element['expiry'])
                      .isAfter(DateTime.now()))
              .toList()
              .isNotEmpty
          : false) {
        updateUserSubscription(true);
      } else {
        updateUserSubscription(false);
      }
      update();
    } catch (e) {
      print(e);
      signOut(context);
    }
  }

  updateAgeRangeValue(RangeValues value) {
    ageRangeValues = Rx(value);
    update();
  }

  updateMeetFromPreference(String value) {
    meetFromPreference = RxString(value);
    update();
  }

  void updateImageFile(dynamic value) {
    imageFile = value;
    update();
  }

  updateNationality(String name, String code, String dial) {
    nationalityName = RxString(name);
    nationalityCode = RxString(code);
    nationalityDialCode = RxString(dial);
    update();
  }

  updateMeetFromValues(String name, String code, String dial) {
    countryMeetFromName = RxString(name);
    countryMeetFromCode = RxString(code);
    countryMeetFromDialCode = RxString(dial);
    update();
  }

  updateLinkMeWith(String value) {
    linkmeWith = RxString(value);
    user?.value.linkMeWith = value;
    update();
  }

  updateDistanceValue(RangeValues value) {
    distanceRangeValue =
        Rx(RangeValues(value.start.ceilToDouble(), value.end.ceilToDouble()));
    update();
  }

  updateMembershipModel(String key, bool value) {
    if (key == 'topshelf') {
      user?.value.isTopShelf = value;
    }
    if (key == 'restaurant') {
      user?.value.isRestaurant = value;
    }
    if (key == 'clubs') {
      user?.value.isClub = value;
    }
    if (key == 'islivestream') {
      user?.value.isLiveStream = value;
    }
    update();
  }

  updateUserSubscription(value) {
    user?.value.isTopShelf = value;
    user?.value.isRestaurant = value;
    user?.value.isClub = value;
    user?.value.isLiveStream = value;
    update();
  }

  updatePhoneNumberCode(String value) {
    phoneNumberCode = RxString(value);
    update();
  }

  updateDOB(int value) {
    birthday = RxInt(value);
    var _age = DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(value))
                .inDays >
            365
        ? (DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(value))
                .inDays /
            365)
        : 0;
    age = RxInt(_age.floor());
    update();
  }

  updateOriginCountry(Country country) {
    countryName = RxString(country.name);
    countryCode = RxString(country.countryCode);
    countryPhoneCode = RxString(country.phoneCode);
    update();
  }

  updateUserName({required String firstName, required String lastName}) {
    UserModel _user = user!.value;
    _user.firstName = firstName;
    _user.lastName = lastName;
    user = Rx<UserModel>(_user);
    update();
  }


  updateGender(String value) {
    gender = RxString(value);
    update();
  }

  updateUser(UserModel userObj) {
    user = Rx<UserModel>(userObj);
    update();
  }

  Future<void> updateProfile({required BuildContext context}) async {
    updateLoading(true);

    demoInterestList.forEach((key, value) {
      if (value) {
        _selectedInterest.add(key);
      }
      
    }); 
    UserModel _user = user!.value;

    if (_user.stripeCustomerId != '') {
      var res = await retrieveStripeCustomer(_user.stripeCustomerId);
      if (res['name'] == null) {
        await updateStripeCustomer(
            _user.stripeCustomerId,
            firstnameController.text.trim() +
                ' ' +
                lastnameController.text.trim());
      }
    }

    _user.avatar =
        morePhotosURLs.length > 0 ? morePhotosURLs.first : _user.avatar;
    _user.morePhotos = morePhotosURLs;
    _user.firstName = firstnameController.text.trim();
    _user.lastName = lastnameController.text.trim();
    _user.country = countryName.value;
    _user.countryCode = countryCode.value;
    _user.phoneNumberDialCode = phoneNumberCode.value;
    _user.phoneNumber = phoneNumberController.text.trim();
    _user.gender = gender.value;
    _user.birthday = birthday.value;
    _user.age = age.value;
    _user.aboutMe = aboutMeController.text;
    _user.job = jobController.text;
    _user.university = universityController.text;
    _user.interests = _selectedInterest;
    interestRequired = _selectedInterest.toString();
    _user.newMatchNotification = newMatchesNotification.value;
    _user.newMessageNotification = newMessageNotification.value;
    _user.promotionNotification = promotionNotification.value;
    _user.createdAt = DateTime.now().millisecondsSinceEpoch;
    _user.updatedAt = DateTime.now().millisecondsSinceEpoch;
    _user.whyarewehere=actLocation.value;
    _user.newCountry1=NewCountry.value;
    _user.newState1=NewState.value;
    _user.newCity1=NewCity.value;
    
    await firebaseFirestore
        .collection('users')
        .doc(_user.uid)
        .update(_user.toJson());
    updateLoading(false);
  }

  // Future<void> updateUserStatus({required BuildContext context}) async {
  //   updateLoading(true);

  //   UserModel _user = user!.value;
  //   _user.userStatus = actLocation.value;

  //   await firebaseFirestore.collection('users').doc(_user.uid).update({
  //     "user_status": actLocation.value,
  //   });
  //   updateLoading(false);
  // }

  String timeStampToDateTime(int timestamp) {
    String resultString;
    var format;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if ((date.year == DateTime.now().year) &&
        (date.month == DateTime.now().month) &&
        (date.day == DateTime.now().day)) {
      format = DateFormat('hh:mm a');
      resultString = format.format(date);
    } else if ((date.year == DateTime.now().year) &&
        (date.month == DateTime.now().month) &&
        (date.day == DateTime.now().day - 1)) {
      resultString = 'Yesterday';
    } else if ((date.year == DateTime.now().year) &&
        (date.month == DateTime.now().month) &&
        ((date.day < DateTime.now().day - 1) ||
            (date.day > DateTime.now().day - 7))) {
      resultString = DateFormat('EE')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    } else if ((date.year == DateTime.now().year) &&
        (date.month == DateTime.now().month - 1) &&
        (date.day > DateTime.now().day + 24)) {
      resultString = DateFormat('EE')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    } else {
      format = DateFormat('MM/dd/yyyy');
      resultString = format.format(date);
    }
    return resultString;
  }

  String timeStampToTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('hh:mm a').format(date);
  }

  String timeStampToDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  int getMinuteFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp).minute;
  }

  int yearToTimestamp(int year) {
    return DateTime.fromMillisecondsSinceEpoch(year).minute;
  }

  int getAge(int timestamp) {
    int age = DateTime.now().year -
        DateTime.fromMillisecondsSinceEpoch(timestamp).year;
    return age;
  }

  addSetting(BuildContext context) async {
    UserModel _userModel = user!.value;
    _userModel.distanceFilter = [
      distanceRangeValue.value.start.toString(),
      distanceRangeValue.value.end.toString()
    ];
    _userModel.ageFilter = [
      ageRangeValues.value.start.toString(),
      ageRangeValues.value.end.toString()
    ];
    _userModel.isGhost = isGhoststatus.value;
    _userModel.language = language.value;
    _userModel.linkMeWith = linkmeWith.value;
    _userModel.whichLatinCountryYouLinkedWith = nationalityCode.value;
    _userModel.linkMeWithCountryCode = (meetFromPreference.value != 'all'
            ? countryMeetFromCode
            : meetFromPreference.value)
        .toString();
    _userModel.showMyAge = dontShowMyAge.value;
    updateLoading(true);
    await firebaseFirestore
        .collection('users')
        .doc(_userModel.uid)
        .update(_userModel.toJson());
    updateLoading(false);

    alert1('The information has been updated successfully!');
    Navigator.pushNamed(context, RoutePath.home_screen);
  }

  removeLocalCache() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('user_id');
    _prefs.remove('username');
    _prefs.remove('password');

    user = null;

    firstnameController.text = '';
    lastnameController.text = '';
    phoneNumberController.text = '';
    aboutMeController.text = '';
    jobController.text = '';
    universityController.text = '';
    emailController.text = '';
    passwordController.text = '';
    update();
  }

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await removeLocalCache();
    await _googleSignIn.signOut();
    user = null;
    // Navigator.of(context, rootNavigator: true)
    //     .pushNamed(RoutePath.login_screen);
    Get.offAllNamed(RoutePath.login_screen);
    // Navigator.of(context).pushNamed(RoutePath.login_screen);
  }

  void deleteUser(BuildContext context) async {
    try {
      updateLoading(true);
      var _username = SharedPref.instance.shared.getString('username');
      var _password = SharedPref.instance.shared.getString('password');
      User? _user = FirebaseAuth.instance.currentUser;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: _username!, password: _password!);
      UserCredential result =
          await _user!.reauthenticateWithCredential(credentials);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('matches')
          .doc(result.user!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('swipes')
          .doc(result.user!.uid)
          .delete();
      await result.user!.delete();
      signOut(context);
      updateLoading(false);
    } catch (e) {
      updateLoading(false);
    }
  }

  void login(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      if (userCredential.user != null) {
        await getUser(userCredential.user!.uid, context);
        if (user?.value.status == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('user_id', user?.value.toJson()['uid']);
          await pref.setString('username', emailController.text.trim());
          await pref.setString('password', passwordController.text.trim());
          Navigator.pushNamed(context, RoutePath.home_screen);
        } else {
          alert1(
              'You are disabled by administrator. Please contact to administrator');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        alert1('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        alert1('Wrong password provided for that user.');
      } else {
        alert1(e.toString());
      }
    }
  }

  Future createStripeCustomer(
      String uid, String email, String description) async {
    Map<String, dynamic> body = {"email": email, "description": description};
    var response = await http.post(
      Uri.parse(
          'https://us-central1-linkup-cfa21.cloudfunctions.net/createStripeCustomer'),
      body: body,
    );
    var jsonBody = jsonDecode(response.body);
    print(jsonBody);
    return jsonBody['body']['id'];
  }

  Future retrieveStripeCustomer(String id) async {
    Map<String, dynamic> body = {"id": id};
    var response = await http.post(
        Uri.parse(
            'https://us-central1-linkup-cfa21.cloudfunctions.net/retrieveStripeCustomer'),
        body: body);
    var jsonBody = jsonDecode(response.body);
    return jsonBody['body'];
  }

  Future updateStripeCustomer(String custId, String name) async {
    Map<String, dynamic> body = {"id": custId, "name": name};
    var response = await http.post(
        Uri.parse(
            'https://us-central1-linkup-cfa21.cloudfunctions.net/updateStripeCustomer'),
        body: body);
    var jsonBody = jsonDecode(response.body);
    return jsonBody['body'];
  }

  void register(BuildContext context) async {
    try {
      updateLoading(true);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('username', emailController.text.trim());
      await pref.setString('password', passwordController.text.trim());

      if (userCredential.user?.uid != null && userCredential.user?.uid != '') {
        var stripeCusId = await createStripeCustomer(
        userCredential.user!.uid, emailController.text.trim(), '');
        String? _token = await messaging.getToken();
        UserModel userModel = UserModel(
          newCountry1: NewCountry.value,
          newState1: NewState.value,
          newCity1: NewCity.value,
          whyarewehere: actLocation.value,
          uid: userCredential.user!.uid,
          fcmToken: _token ?? '',
          firstName: '',
          lastName: '',
          email: emailController.text.trim(),
          country: 'Bahamas',
          countryCode: 'BS',
          phoneNumberDialCode: '+1242',
          linkWithMePhoneCode: '+1242',
          linkMeWithCountryCode: 'BS',
          whichLatinCountryYouLinkedWith: 'BS',
          phoneNumber: '',
          gender: '',
          language: 'english',
          linkMeWith: 'Female',
          birthday: DateTime.now().millisecondsSinceEpoch,
          age: 0,
          aboutMe: '',
          avatar: '',
          job: '',
          morePhotos: [],
          status: true,
          university: '',
          ageFilter: ['18', '50'],
          distanceFilter: ['10.0', '1000.0'],
          interests: [],
          subscription: [],
          isClub: false,
          isRestaurant: false,
          isGhost: false,
          isTopShelf: false,
          isLiveStream: false,
          newMatchNotification: true,
          newMessageNotification: true,
          promotionNotification: true,
          stripeCustomerId: stripeCusId,
          lastActive: DateTime.now().millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        );
        user = Rx(userModel);
        update();
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('user_id', userCredential.user!.uid);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set(userModel.toJson())
            .then((value) async {
          alert1('User has been successfully registered!');
          await FirebaseFirestore.instance
              .collection('swipes')
              .doc(userCredential.user?.uid)
              .set({'seen': FieldValue.arrayUnion([])});
          updateLoading(false);

          Navigator.pushNamed(context, RoutePath.sign_up_second);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alert1('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        alert1('The email address is already in use by another account.');
      }
    } catch (e) {
      alert1(e.toString());
    }
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user?.uid != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'email': userCredential.user?.email,
            'lastActive': DateTime.now().millisecondsSinceEpoch,
            'status': true,
            'createdAt': Timestamp.now().millisecondsSinceEpoch,
            'updatedAt': Timestamp.now().millisecondsSinceEpoch,
          }).then((value) {
            alert1('User has been successfully registered!');
            Navigator.pushNamed(context, RoutePath.sign_up_second);
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          alert1('The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          alert1('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        alert1('Error occurred using Google Sign-In. Try again.');
      }
    } else {}
  }

  Future getImage(String type) async {
    ImagePicker _picker = ImagePicker();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';

    var imageFile = await _picker.pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Random().nextInt(100000);
    if (imageFile != null) {
      Img.Image image = Img.decodeImage(await imageFile.readAsBytes())!;
      Img.Image smallerImg = Img.copyResize(image, width: 500);

      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

      imageFile = XFile(compressImg.path);

      int timestamp = new DateTime.now().millisecondsSinceEpoch;
      Reference storageReference1 = FirebaseStorage.instance.ref().child(
          'users/' +
              (usrID) +
              '/' +
              (firstnameController.text.trim()) +
              timestamp.toString() +
              '(' +
              (morePhotosURLs.length > 0
                  ? (morePhotosURLs).length.toString()
                  : 0.toString()) +
              ')' +
              '.jpg');
      UploadTask uploadTask1 = storageReference1.putFile(compressImg);
      try {
        updateLoading(true);
        await uploadTask1.whenComplete(() async {
          try {
            String downloadURL = await storageReference1.getDownloadURL();
            user?.value.avatar = downloadURL;
            morePhotosURLs.add(downloadURL);
            photoFlag.add(false);
            updateLoading(false);

            update();
            return downloadURL;
          } catch (onError) {
            print(onError);
            update();
          }
        });
        updateLoading(false);
      } catch (e) {
        updateLoading(false);
        print(e);
      }
    }
  }

  uploadMainImageToStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';
    if (imageFile != null) {
      int timestamp = new DateTime.now().millisecondsSinceEpoch;
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'users/' +
              (usrID) +
              '/' +
              (firstnameController.text.trim()) +
              timestamp.toString() +
              '.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile!);

      await uploadTask.whenComplete(() async {
        try {
          selectedImageURL = await storageReference.getDownloadURL();
        } catch (onError) {
          print('Error');
        }
      });
    }
  }

  Future<void> fetchNotification() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.value.uid)
        .collection('notifications')
        .snapshots()
        .listen((notifications) {
      listNotification = notifications.docs.map((e) => e.data()).toList();
      listNotification.sort((a, b) =>
          DateTime.fromMillisecondsSinceEpoch(a['time'])
              .compareTo(DateTime.fromMillisecondsSinceEpoch(b['time'])));
      update();
    });
  }

  Future<void> clearNotification() async {
    var notifications = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.value.uid)
        .collection('notifications')
        .get();
    for (var noti in notifications.docs) {
      noti.reference.delete();
    }
    listNotification = [];
    update();
  }
}
