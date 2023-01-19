import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/get_controller/base_controller.dart';
import 'package:link_up/model/ad_model.dart';
import 'package:link_up/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends BaseController {
  AuthController authController = Get.find(tag: AuthController().toString());

  var firestore = FirebaseFirestore.instance;
  RxList swipeCards = [].obs;
  RxList<UserModel> exploreList = <UserModel>[].obs;
  RxInt missedMessageLength = 0.obs;
  Rx? timer;

  Future<void> fetchExploreList(
      {required String nationality,
      required String userID,
      required String linkMeWith}) async {
    swipeCards.clear();
    exploreList.clear();
    if (authController.user != null) {
      if (authController.user!.value.linkMeWithCountryCode == 'all') {
        if (authController.user!.value.linkMeWith == 'Both') {
          firestore
              .collection('users')
              .where('age',
                  isLessThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[1].toString())
                      .floor())
              .where('age',
                  isGreaterThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[0].toString())
                      .floor())
              .where('status', isEqualTo: true)
              .where('is_ghost', isEqualTo: false)
              .orderBy('age')
              .snapshots()
              .listen((querySnapshot) async {
            swipeCards.clear();
            exploreList.clear();
            var response =
                await firestore.collection('swipes').doc(userID).get();
            List alreadySeen = await response.data()?['seen'] ?? [];
            querySnapshot.docs.forEach((doc) {
              UserModel _model = UserModel.fromJson(doc.data());
              if (!alreadySeen.contains(_model.uid)) {
                if (_model.uid != authController.user!.value.uid) {
                  if (!(exploreList
                      .any((element) => element.uid == _model.uid))) {
                    exploreList.add(_model);
                  }
                }
              }
              update();
            });
            //
            // To change ad after index, just change % number
            //
            var ads = await FirebaseFirestore.instance.collection('ads').get();
            int adindex = 0;

            // List<AdModel> adsList =
            //     ads.docs.map((e) => AdModel.fromJson(e.data())).toList();
            List<AdModel?> adsList = ads.docs.map((e) {
              try {
                var _ad = AdModel.fromJson(e.data());
                return _ad != null ? _ad : null;
              } catch (e) {}
            }).toList();
            adsList.removeWhere((element) => element == null);

            if (exploreList.isNotEmpty && adsList.isNotEmpty) {
              for (var j = 1; j < exploreList.length + 1; j++) {
                if (j % 2 == 0) {
                  if (swipeCards.contains(adsList[adindex]) == false &&
                      adindex <= adsList.length - 1) {
                    swipeCards.add(adsList[adindex]);
                  }
                  swipeCards.add(exploreList[j - 1]);
                  if (adindex < adsList.length - 1) {
                    adindex = adindex + 1;
                  }
                } else {
                  swipeCards.add(exploreList[j - 1]);
                }
              }
            } else {
              swipeCards.addAll(exploreList);
            }
            update();
          });
        } else {
          firestore
              .collection('users')
              .where('gender', isEqualTo: authController.user!.value.linkMeWith)
              .where('age',
                  isLessThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[1].toString())
                      .floor())
              .where('age',
                  isGreaterThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[0].toString())
                      .floor())
              .where('status', isEqualTo: true)
              .where('is_ghost', isEqualTo: false)
              .orderBy('age')
              .snapshots()
              .listen((querySnapshot) async {
            swipeCards.clear();
            exploreList.clear();
            var response =
                await firestore.collection('swipes').doc(userID).get();
            List alreadySeen = await response.data()?['seen'] ?? [];
            querySnapshot.docs.forEach((doc) {
              UserModel _model = UserModel.fromJson(doc.data());
              if (!alreadySeen.contains(_model.uid)) {
                if (_model.uid != authController.user!.value.uid) {
                  if (!(exploreList
                      .any((element) => element.uid == _model.uid))) {
                    exploreList.add(_model);
                  }
                }
              }
              update();
            });

            //
            // To change ad after index, just change % number
            //
            var ads = await FirebaseFirestore.instance.collection('ads').get();
            int adindex = 0;
            List<AdModel?> adsList = ads.docs.map((e) {
              try {
                var _ad = AdModel.fromJson(e.data());
                return _ad != null ? _ad : null;
              } catch (e) {}
            }).toList();
            adsList.removeWhere((element) => element == null);

            if (exploreList.isNotEmpty && adsList.isNotEmpty) {
              for (var j = 1; j < exploreList.length + 1; j++) {
                if (j % 2 == 0) {
                  if (swipeCards.contains(adsList[adindex]) == false &&
                      adindex <= adsList.length - 1) {
                    swipeCards.add(adsList[adindex]);
                  }
                  swipeCards.add(exploreList[j - 1]);
                  if (adindex < adsList.length - 1) {
                    adindex = adindex + 1;
                  }
                } else {
                  swipeCards.add(exploreList[j - 1]);
                }
              }
            } else {
              swipeCards.addAll(exploreList);
            }
            update();
          });
        }
      } else {
        if (authController.user!.value.linkMeWith == 'Both') {
          firestore
              .collection('users')
              .where('age',
                  isLessThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[1].toString())
                      .floor())
              .where('age',
                  isGreaterThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[0].toString())
                      .floor())
              .where('which_latin_country_you_linked_with',
                  isEqualTo: authController.user!.value.linkMeWithCountryCode)
              .where('status', isEqualTo: true)
              .where('is_ghost', isEqualTo: false)
              .orderBy('age')
              .snapshots()
              .listen((querySnapshot) async {
            swipeCards.clear();
            exploreList.clear();
            var response =
                await firestore.collection('swipes').doc(userID).get();
            List alreadySeen = await response.data()?['seen'] ?? [];

            querySnapshot.docs.forEach((doc) {
              UserModel _model = UserModel.fromJson(doc.data());
              if (!alreadySeen.contains(_model.uid)) {
                if (_model.uid != authController.user!.value.uid) {
                  if (!(exploreList
                      .any((element) => element.uid == _model.uid))) {
                    exploreList.add(_model);
                  }
                }
              }
              update();
            });
            //
            // To change ad after index, just change % number
            //
            var ads = await FirebaseFirestore.instance.collection('ads').get();
            int adindex = 0;
            // List<AdModel> adsList =
            //     ads.docs.map((e) => AdModel.fromJson(e.data())).toList();
            List<AdModel?> adsList = ads.docs.map((e) {
              try {
                var _ad = AdModel.fromJson(e.data());
                return _ad != null ? _ad : null;
              } catch (e) {}
            }).toList();
            adsList.removeWhere((element) => element == null);

            if (exploreList.isNotEmpty && adsList.isNotEmpty) {
              for (var j = 1; j < exploreList.length + 1; j++) {
                if (j % 2 == 0) {
                  if (swipeCards.contains(adsList[adindex]) == false &&
                      adindex <= adsList.length - 1) {
                    swipeCards.add(adsList[adindex]);
                  }
                  swipeCards.add(exploreList[j - 1]);
                  if (adindex < adsList.length - 1) {
                    adindex = adindex + 1;
                  }
                } else {
                  swipeCards.add(exploreList[j - 1]);
                }
              }
            } else {
              swipeCards.addAll(exploreList);
            }
            update();
          });
        } else {
          firestore
              .collection('users')
              .where('gender', isEqualTo: authController.user!.value.linkMeWith)
              .where('age',
                  isLessThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[1].toString())
                      .floor())
              .where('age',
                  isGreaterThanOrEqualTo: double.parse(
                          authController.user!.value.ageFilter[0].toString())
                      .floor())
              .where('which_latin_country_you_linked_with',
                  isEqualTo: authController.user!.value.linkMeWithCountryCode)
              .where('status', isEqualTo: true)
              .where('is_ghost', isEqualTo: false)
              .orderBy('age')
              .snapshots()
              .listen((querySnapshot) async {
            swipeCards.clear();
            exploreList.clear();
            var response =
                await firestore.collection('swipes').doc(userID).get();
            List alreadySeen = await response.data()?['seen'] ?? [];

            querySnapshot.docs.forEach((doc) {
              UserModel _model = UserModel.fromJson(doc.data());
              if (!alreadySeen.contains(_model.uid)) {
                if (_model.uid != authController.user!.value.uid) {
                  if (!(exploreList
                      .any((element) => element.uid == _model.uid))) {
                    exploreList.add(_model);
                  }
                }
              }
              update();
            });
            //
            // To change ad after index, just change % number
            //
            var ads = await FirebaseFirestore.instance.collection('ads').get();
            int adindex = 0;
            // List<AdModel> adsList =
            //     ads.docs.map((e) => AdModel.fromJson(e.data())).toList();
            List<AdModel?> adsList = ads.docs.map((e) {
              try {
                var _ad = AdModel.fromJson(e.data());
                return _ad != null ? _ad : null;
              } catch (e) {}
            }).toList();
            adsList.removeWhere((element) => element == null);

            if (exploreList.isNotEmpty && adsList.isNotEmpty) {
              for (var j = 1; j < exploreList.length + 1; j++) {
                if (j % 2 == 0) {
                  if (swipeCards.contains(adsList[adindex]) == false &&
                      adindex <= adsList.length - 1) {
                    swipeCards.add(adsList[adindex]);
                  }
                  swipeCards.add(exploreList[j - 1]);
                  if (adindex < adsList.length - 1) {
                    adindex = adindex + 1;
                  }
                } else {
                  swipeCards.add(exploreList[j - 1]);
                }
              }
            } else {
              swipeCards.addAll(exploreList);
            }
            update();
          });
        }
      }
    }
    swipeCards.reversed;
  }

  void missedMessage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _userid = pref.getString('user_id');
    String usrID = _userid ?? '';
    if (usrID != '') {
      FirebaseFirestore.instance
          .collection('users')
          .doc(usrID)
          .collection('messages')
          .get()
          .then((val) {
        if (val.docs.length != 0) {
          int i = 0;
          val.docs.forEach((doc) async {
            await FirebaseFirestore.instance
                .collection('chats')
                .doc(doc.id)
                .collection('message')
                .where('senderID', isNotEqualTo: usrID)
                .where('isRead', isEqualTo: false)
                .get()
                .then((value) {
              if (value.docs.length != 0) {
                i++;
                missedMessageLength = RxInt(i);
              }
            });
          });
        }
      });
      periodicMissedMsg();
    }
  }

  Future<void> periodicMissedMsg() async {
    timer = Rx(Timer.periodic(Duration(seconds: 20), (Timer timer) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var _userid = pref.getString('user_id');
      String usrID = _userid ?? '';
      FirebaseFirestore.instance
          .collection('users')
          .doc(usrID)
          .collection('messages')
          .get()
          .then((val) {
        if (val.docs.length != 0) {
          int i = 0;
          val.docs.forEach((doc) async {
            await FirebaseFirestore.instance
                .collection('chats')
                .doc(doc.id)
                .collection('message')
                .where('senderID', isNotEqualTo: usrID)
                .where('isRead', isEqualTo: false)
                .get()
                .then((value) {
              if (value.docs.length != 0) {
                i++;
                missedMessageLength = RxInt(i);
              }
            });
          });
          new Timer(const Duration(seconds: 2), () {
            if (i == 0) {
              missedMessageLength = RxInt(0);
            }
          });
        }
      });
    }));
  }
}
