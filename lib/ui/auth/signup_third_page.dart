import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/app_config.dart';
import 'package:link_up/model/LanguageModel.dart';

class SignUpThirdPage extends StatefulWidget {
  @override
  _SignUpThirdPageState createState() => _SignUpThirdPageState();
}

class _SignUpThirdPageState extends State<SignUpThirdPage> {
  AuthController authController = Get.find(tag: AuthController().toString());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GetBuilder(
            init: authController,
            builder: (_) {
              if (authController.loading.value == true) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else
                return Container(
                  width: width,
                  height: height,
                  padding: EdgeInsets.only(
                      left: width * 0.025, right: width * 0.025),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          'we_need_little_more_nfo'.tr,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('distance_mile'.tr,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              RangeSlider(
                                values: authController.distanceRangeValue.value,
                                min: 1,
                                max: 1000,
                                divisions: 100,
                                inactiveColor: Colors.grey,
                                labels: RangeLabels(
                                  authController.distanceRangeValue.value.start
                                      .round()
                                      .toString(),
                                  authController.distanceRangeValue.value.end
                                      .round()
                                      .toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  authController.updateDistanceValue(values);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 10),
                                child: Text(
                                  "link_me_with".tr,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Radio(
                                      value: 'Female',
                                      groupValue:
                                          authController.linkmeWith.value,
                                      onChanged: (value) {
                                        authController
                                            .updateLinkMeWith(value.toString());
                                      },
                                    ),
                                    Text('female'.tr),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      value: 'Male',
                                      groupValue:
                                          authController.linkmeWith.value,
                                      onChanged: (value) {
                                        authController
                                            .updateLinkMeWith(value.toString());
                                      },
                                    ),
                                    Text('male'.tr),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      value: 'Both',
                                      groupValue: authController
                                              .user?.value.linkMeWith ??
                                          authController.linkmeWith.value,
                                      onChanged: (value) {
                                        authController
                                            .updateLinkMeWith(value.toString());
                                      },
                                    ),
                                    Text('both'.tr),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: double.infinity),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 10),
                                child: Text(
                                  "which_carribbean_or_latin_linkwith".tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans", fontSize: 17),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                children: [
                                  CountryCodePicker(
                                    initialSelection: "BS",
                                    onChanged: (e) {
                                      authController.updateNationality(
                                          e.name!, e.code!, e.dialCode!);
                                    },
                                    countryList: Utils.carribAndLatinCountry,
                                    hideMainText: false,
                                    textStyle: TextStyle(color: Colors.black),
                                    showOnlyCountryWhenClosed: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 10),
                                child: Text(
                                  "which_carrib_people_meet_from".tr,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 17,
                                  ),
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
                                            .updateMeetFromPreference("all");
                                      },
                                    ),
                                    Text('all'.tr),
                                    Radio(
                                      value: 'other',
                                      groupValue: authController
                                          .meetFromPreference.value,
                                      onChanged: (value) {
                                        authController.updateMeetFromPreference(
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
                                  children: [
                                    CountryCodePicker(
                                      initialSelection: authController
                                          .countryMeetFromCode.value,
                                      onChanged: (e) {
                                        authController.updateMeetFromValues(
                                            e.name!, e.code!, e.dialCode!);
                                      },
                                      // countryList: Utils.carribAndLatinCountry,
                                      hideMainText: false,
                                      textStyle: TextStyle(color: Colors.black),
                                      showOnlyCountryWhenClosed: true,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 10),
                                child: Text(
                                  "age_title".tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans", fontSize: 17),
                                ),
                              ),
                              Container(
                                child: RangeSlider(
                                  values: authController.ageRangeValues.value,
                                  min: 18,
                                  max: 100,
                                  divisions: 82,
                                  inactiveColor: Colors.grey,
                                  labels: RangeLabels(
                                    authController.ageRangeValues.value.start
                                        .round()
                                        .toString(),
                                    authController.ageRangeValues.value.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    authController.updateAgeRangeValue(values);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Text(
                                        "preferred_language".tr,
                                        style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 140,
                                  child: DropdownButton<LanguageModel>(
                                    isExpanded: true,
                                    icon: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 23,
                                          child: Image.asset(
                                            authController.languageImage.value,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(authController.language.value)
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
                                              width: 35,
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
                                      if (val != null) {
                                        authController
                                            .updatelanguage(val.language);
                                        authController
                                            .updateLanguageFlag(val.flag);
                                      }
                                    },
                                  ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Container(
                            height: 50,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Text(
                                        "make_status_ghost".tr,
                                        style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: authController.isGhoststatus.value,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    authController.updateIsGhostStatus(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  authController.addSetting(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[800],
                                ),
                                child: Text(
                                  'next'.tr,
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                              // RaisedButton(
                              //   color: Colors.blue[800],
                              //   child: Text(
                              //     'next'.tr,
                              //    style: TextStyle(
                              //         color: Colors.white, fontSize: 18),
                              //   ),
                              //   onPressed: () {
                              //     authController.addSetting(context);
                              //   },
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                );
            }),
      ),
    );
  }
}
