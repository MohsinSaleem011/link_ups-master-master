import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/app_config.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/helper/shared_pref_service.dart';
import 'package:link_up/model/LanguageModel.dart';
import 'package:link_up/ui/home_page.dart';
import 'package:link_up/ui/setting/location_setting_page.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  AuthController authController = Get.find(tag: AuthController().toString());

  String location = '';

  initDataLoading() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authController.user!.value.uid)
        .collection('locations')
        .where('isActive', isEqualTo: true)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        value.docs.forEach((doc) {
          setState(() {
            location = doc.data()['street'] +
                ', ' +
                doc.data()['administrativeArea'] +
                ', ' +
                doc.data()['postalCode'];
          });
        });
      }
    });
  }

  @override
  void initState() {
    initDataLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: authController,
        builder: (_) {
          return Scaffold(
            // appBar: AppBar(
            //   centerTitle: true,
            //   backgroundColor: Colors.green.shade900,
            //   title: Text(
            //     'account_setting'.tr,
            //   ),
            //   leading: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     icon: Icon(
            //       Icons.arrow_back_ios,
            //     ),
            //   ),
            //   elevation: 10,
            // ),
            body: ListView(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Group 163959.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    // padding: const EdgeInsets.fromLTRB(80, 20, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.pin_drop,
                                        //   size: 25,
                                        //   color:
                                        //       Colors.black.withOpacity(0.5),
                                        // ),
                                        SizedBox(width: 5),
                                        Text(
                                          "location".tr,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'my_location'.tr,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        if (location != null && location != '')
                                          Text(
                                            location,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      // icon: Icon(
                                      //   Icons.arrow_forward_ios,
                                      //   size: 20,
                                      // ),
                                      icon: Image.asset("assets/arrow.jpg"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LocationSettingPage()));
                                      })
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, right: 8.0),
                                    child: Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('distance'.tr,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        Text("40 Miles")
                                      ],
                                    ),
                                  ),
                                  RangeSlider(
                                    values:
                                        authController.distanceRangeValue.value,
                                    min: 1,
                                    max: 1000,
                                    divisions: 100,
                                    inactiveColor: Colors.grey,
                                    activeColor: Color(0xff38ABD8),
                                    labels: RangeLabels(
                                      authController
                                          .distanceRangeValue.value.start
                                          .round()
                                          .toString(),
                                      authController
                                          .distanceRangeValue.value.end
                                          .round()
                                          .toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        authController
                                            .updateDistanceValue(values);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 4, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // "age".tr,
                                          "Age",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text("18 - 100")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: RangeSlider(
                                      values:
                                          authController.ageRangeValues.value,
                                      min: 18,
                                      max: 100,
                                      divisions: 90,
                                      inactiveColor: Colors.grey,
                                      activeColor: Color(0xff38ABD8),
                                      labels: RangeLabels(
                                        authController
                                            .ageRangeValues.value.start
                                            .round()
                                            .toString(),
                                        authController.ageRangeValues.value.end
                                            .round()
                                            .toString(),
                                      ),
                                      onChanged: (RangeValues values) {
                                        authController
                                            .updateAgeRangeValue(values);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 18.0, top: 10),
                            //   child: Text(
                            //     "like_me_with".tr,
                            //    style: TextStyle(
                            //       fontSize: 18,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "like_me_with".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Radio(
                                    value: 'Female',
                                    groupValue:
                                        authController.user?.value.linkMeWith ??
                                            authController.linkmeWith.value,
                                    onChanged: (value) {
                                      authController
                                          .updateLinkMeWith(value.toString());
                                    },
                                  ),
                                  Text('female'.tr),
                                  // SizedBox(
                                  //   width: 2,
                                  // ),
                                  Radio(
                                    value: 'Male',
                                    groupValue:
                                        authController.user?.value.linkMeWith ??
                                            authController.linkmeWith.value,
                                    onChanged: (value) {
                                      print(value);
                                      authController
                                          .updateLinkMeWith(value.toString());
                                    },
                                  ),
                                  Text('male'.tr),
                                  // SizedBox(
                                  //   width: 2,
                                  // ),
                                  Radio(
                                    value: 'Both',
                                    groupValue:
                                        authController.user?.value.linkMeWith ??
                                            authController.linkmeWith.value,
                                    onChanged: (value) {
                                      authController
                                          .updateLinkMeWith(value.toString());
                                    },
                                  ),
                                  Text('both'.tr),
                                  // SizedBox(
                                  //   width: 2,
                                  // ),
                                ],
                              ),
                            ),
                            //   ],
                            // ),
                            // ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: double.infinity),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, right: 8.0),
                                    child: Text(
                                      "which_carribbean_or_latin_linkwith".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CountryCodePicker(
                                        initialSelection: authController
                                                .user
                                                ?.value
                                                .whichLatinCountryYouLinkedWith ??
                                            "BS",
                                        onChanged: (e) {
                                          authController.updateNationality(
                                              e.name!, e.code!, e.dialCode!);
                                        },
                                        countryList:
                                            Utils.carribAndLatinCountry,
                                        hideMainText: false,
                                        textStyle:
                                            TextStyle(color: Colors.black),
                                        showOnlyCountryWhenClosed: true,
                                      ),
                                      Image.asset('assets/arrow.jpg'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, right: 8.0),
                                    child: Text(
                                      "which_carrib_people_meet_from".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Container(
                                    width: 160,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Radio(
                                          value: 'all',
                                          groupValue: authController
                                              .meetFromPreference.value,
                                          onChanged: (value) {
                                            authController.updateMeetFromValues(
                                                '', 'all', '');
                                            authController
                                                .updateMeetFromPreference(
                                                    "all");
                                          },
                                        ),
                                        Text('all'.tr),
                                        Radio(
                                          value: 'other',
                                          groupValue: authController
                                              .meetFromPreference.value,
                                          onChanged: (value) {
                                            authController
                                                .updateMeetFromPreference(
                                                    value.toString());
                                          },
                                        ),
                                        Text('other'.tr),
                                      ],
                                    ),
                                  ),
                                  if (authController.meetFromPreference.value !=
                                      "all")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CountryCodePicker(
                                          initialSelection: authController
                                                  .user
                                                  ?.value
                                                  .linkMeWithCountryCode ??
                                              authController
                                                  .countryMeetFromCode.value,
                                          onChanged: (e) {
                                            authController.updateMeetFromValues(
                                                e.name!, e.code!, e.dialCode!);
                                          },
                                          countryList:
                                              Utils.carribAndLatinCountry,
                                          hideMainText: false,
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          showOnlyCountryWhenClosed: true,
                                        ),
                                        // Image.asset('assets/arrow.jpg'),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 170,
                                      child: Row(
                                        children: [
                                          // SizedBox(width: 5),
                                          Text(
                                            "preferred_language".tr,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 90,
                                      child: DropdownButton<LanguageModel>(
                                        isExpanded: true,
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: C,
                                          children: [
                                            // Container(
                                            //   width: 35,
                                            //   height: 23,
                                            //   child: Image.asset(
                                            //     authController
                                            //         .languageImage.value,
                                            //     fit: BoxFit.fill,
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   width: ,
                                            // ),
                                            Text(authController.language.value),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Image.asset('assets/arrow.jpg')
                                          ],
                                        ),
                                        items: LanguageModel.languageList()
                                            .map((LanguageModel value) {
                                          return new DropdownMenuItem<
                                              LanguageModel>(
                                            value: value,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 23,
                                                  child: Image.asset(
                                                    value.flag,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(value.language)
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (LanguageModel? val) {
                                          SharedPref.instance.shared.setString(
                                              'locale', val!.languageCode);
                                          Locale _l = AppConstant.getLocale(
                                              val.languageCode);
                                          Get.updateLocale(_l);
                                          if (val != null) {
                                            authController
                                                .updateLanguageFlag(val.flag);
                                            authController
                                                .updatelanguage(val.language);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Text(
                                      "hide_my_age".tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )),
                                // Divider(
                                //   color: Colors.grey,
                                // ),
                                Container(
                                  height: 40,
                                  width: 75,
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Switch(
                                    value: authController.dontShowMyAge.value,
                                    // activeColor: Colors.blue,
                                    inactiveThumbColor: Color(0xff38ABD8),
                                    inactiveTrackColor: Colors.grey[300],
                                    onChanged: (value) {
                                      authController.updateShowAgeStatus(value);
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: 10,
                                // )
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Icon(
                                    //   Icons.charging_station,
                                    //   size: 25,
                                    //   color: Colors.black.withOpacity(0.5),
                                    // ),
                                    // SizedBox(width: 6),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        "make_status_ghost".tr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                )),
                                // Divider(
                                //   color: Colors.grey,
                                // ),
                                SizedBox(width: 20),
                                Container(
                                  height: 40,
                                  width: 85,
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Switch(
                                    value: authController.isGhoststatus.value,
                                    // activeColor: Colors.blue,
                                    inactiveThumbColor: Color(0xff38ABD8),
                                    inactiveTrackColor: Colors.grey[300],
                                    onChanged: (value) {
                                      authController.updateIsGhostStatus(value);
                                    },
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                // SizedBox(
                                //   width: 40,
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.wheelchair_pickup_sharp,
                                            size: 25,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "live_streaming".tr,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: CupertinoSwitch(
                                          trackColor: Colors.amber,
                                          value: authController.user!.value
                                                  .subscription.isNotEmpty
                                              ? authController
                                                  .user!.value.subscription
                                                  .where((element) => DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              element['expiry'])
                                                      .isAfter(DateTime.now()))
                                                  .toList()
                                                  .isNotEmpty
                                              : false,
                                          activeColor: Colors.red,
                                          onChanged: (value) {
                                            authController
                                                .updateMembershipModel(
                                                    'islivestream', value);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 5, top: 5, right: 50),
                                    child: Text('turning_this_on_msg'.tr),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.wheelchair_pickup_sharp,
                                            size: 25,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "top_shelf".tr,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: CupertinoSwitch(
                                          value: authController.user!.value
                                                  .subscription.isNotEmpty
                                              ? authController
                                                  .user!.value.subscription
                                                  .where((element) => DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              element['expiry'])
                                                      .isAfter(DateTime.now()))
                                                  .toList()
                                                  .isNotEmpty
                                              : false,
                                          activeColor: Colors.red,
                                          onChanged: (value) {
                                            authController
                                                .updateMembershipModel(
                                                    'topshelf', value);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 5, top: 5, right: 50),
                                    child: Text('turning_this_msg_shelf'.tr),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.restaurant,
                                            size: 25,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "restaurants".tr,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: CupertinoSwitch(
                                          value: authController.user!.value
                                                  .subscription.isNotEmpty
                                              ? authController
                                                  .user!.value.subscription
                                                  .where((element) => DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              element['expiry'])
                                                      .isAfter(DateTime.now()))
                                                  .toList()
                                                  .isNotEmpty
                                              : false,
                                          activeColor: Colors.red,
                                          onChanged: (value) {
                                            authController
                                                .updateMembershipModel(
                                                    'restaurant', value);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 5, top: 5, right: 50),
                                    child:
                                        Text('turning_this_msg_restaurant'.tr),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Icon(
                                            Icons.room_preferences,
                                            size: 25,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "clubs_and_fates".tr,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 0, top: 10.0, right: 15),
                                        child: CupertinoSwitch(
                                          value: authController.user!.value
                                                  .subscription.isNotEmpty
                                              ? authController
                                                  .user!.value.subscription
                                                  .where((element) => DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              element['expiry'])
                                                      .isAfter(DateTime.now()))
                                                  .toList()
                                                  .isNotEmpty
                                              : true,
                                          activeColor: Colors.red,
                                          onChanged: (value) {
                                            authController
                                                .updateMembershipModel(
                                                    'clubs', value);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.only(
                                  //       left: 5, top: 5, right: 50),
                                  //   child: Text('turning_this_clubs_msg'.tr),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       horizontal: 12.0, vertical: 15.0),
                                  //   width: width,
                                  //   height: 40,
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       // Navigator.push(context, MaterialPageRoute(builder: (_){
                                  //       //   return HomePage();
                                  //       // }));
                                  //        authController.addSetting(context);
                                  //     },
                                  //     child: Text(
                                  //       "Update",
                                  //      style: TextStyle(
                                  //         color: Colors.white,
                                  //       ),
                                  //     ),
                                  //     style: ElevatedButton.styleFrom(
                                  //         backgroundColor: Color(0xff38abd8)),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 60,
                      // ),
                      // GestureDetector(
                      //   child: Container(
                      //     width: width * 0.5,
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       color: Colors.green[900],
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           topRight: Radius.circular(10),
                      //           bottomLeft: Radius.circular(10),
                      //           bottomRight: Radius.circular(10)),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.green.shade900.withOpacity(0.5),
                      //           spreadRadius: 7,
                      //           blurRadius: 7,
                      //           offset: Offset(
                      //               0, 3), // changes position of shadow
                      //         ),
                      //       ],
                      //     ),
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       "update".tr,
                      //      style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     authController.addSetting(context);
                      //   },
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 0, right: 50),
                        child: Text('turning_this_clubs_msg'.tr),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 15.0),
                          width: width,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (_){
                              //   return HomePage();
                              // }));
                              authController.addSetting(context);
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff38abd8)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
