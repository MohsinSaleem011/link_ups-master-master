import 'dart:async';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_limited_checkbox/flutter_limited_checkbox.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/ui/home_page.dart';
import 'package:link_up/ui/setting/account_setting_page.dart';
import 'package:link_up/ui/why_we_are_here.dart';

import '../../model/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = Get.find(tag: AuthController().toString());
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  List<FlutterLimitedCheckBoxModel> mySingleValueList = [];
  String _selectedCountry = 'India';
  String _selectedState = 'Gujarat';
  String _selectedCity = 'Ahmedabad';

  imagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // insetPadding: EdgeInsets.all(19),
          child: Container(
            width: 190,
            height: 250,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white
                //
                ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 148),
                child: Image.asset(
                  "assets/image/popup.jpg",
                  width: 320,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 58),
                child: Text(
                  "Upload Photos from",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.folder,
                            size: 50,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            authController.getImage('gallery');
                          },
                        ),
                        Text(
                          // 'browse_image'.tr,
                          'Your Photos',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.camera_alt,
                            size: 50,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            authController.getImage('camera');
                          },
                        ),
                        Text(
                          // 'take_photo'.tr,
                          'Camera',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       height: 100,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.blue,
            //         image: DecorationImage(
            //             image: AssetImage("assets/image/hjhhjhj.png"),
            //             fit: BoxFit.cover),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 10, left: 35),
            //         child: Text(
            //           "Upload Photos from",
            //          style: TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Column(
            //           children: [
            //             GestureDetector(
            //               child: Icon(
            //                 Icons.folder,
            //                 size: 50,
            //               ),
            //               onTap: () {
            //                 Navigator.pop(context);
            //                 authController.getImage('gallery');
            //               },
            //             ),
            //             Text(
            //               // 'browse_image'.tr,
            //               'Your Photos',
            //              style: TextStyle(color: Colors.black),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           width: 50,
            //         ),
            //         Column(
            //           children: [
            //             GestureDetector(
            //               child: Icon(
            //                 Icons.camera_alt,
            //                 size: 50,
            //               ),
            //               onTap: () {
            //                 Navigator.pop(context);
            //                 authController.getImage('camera');
            //               },
            //             ),
            //             Text(
            //               // 'take_photo'.tr,
            //               'Camera',
            //              style: TextStyle(color: Colors.black),
            //             )
            //           ],
            //         ),
            //       ],
            //     )
            //   ],
            // ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Saturday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Sunday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Monday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Tuesday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Wednesday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Thursday", isSelected: false));
    mySingleValueList.add(FlutterLimitedCheckBoxModel(
        selectId: 1, selectTitle: "Friday", isSelected: false));
    authController.getUser(FirebaseAuth.instance.currentUser!.uid, context);
    if (authController.NewCountry.value == null) {
      authController.NewCountry.value = _selectedCountry;
    }
    if (authController.NewState.value == null) {
      authController.NewState.value = _selectedState;
    }
    if (authController.NewCity.value == null) {
      authController.NewCity.value = _selectedCity;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _user = authController.user!.value;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

    return GetBuilder(
        init: authController,
        builder: (_) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              "assets/Group 163959.png",
                              fit: BoxFit.cover,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.asset(
                            "assets/Vector Smart Object 2.png",
                            width: 150,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, top: 50, right: 10),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 80,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.center,
                                clipBehavior: Clip.none,
                                fit: StackFit.passthrough,
                                children: <Widget>[
                                  Container(
                                    width: width * 0.3,
                                    height: width * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: authController.morePhotosURLs.length > 1
                                              ? (NetworkImage(authController
                                                  .morePhotosURLs.first))
                                              : (authController.imageFile != null
                                                      ? FileImage(authController
                                                          .imageFile!)
                                                      : (authController.user?.value
                                                                      .avatar !=
                                                                  null &&
                                                              authController
                                                                      .user
                                                                      ?.value
                                                                      .avatar !=
                                                                  ''
                                                          ? NetworkImage(
                                                              authController.user!
                                                                  .value.avatar)
                                                          : (AssetImage('assets/image/sample_avatar.png'))))
                                                  as ImageProvider),
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: authController.imageFile == null
                                          ? GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              onTap: () {
                                                imagePickerDialog(context);
                                              },
                                            )
                                          : GestureDetector(
                                              child: Container(
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                              onTap: () {
                                                authController
                                                    .updateImageFile(null);
                                              },
                                            ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: (){
                                  //     Get.to(WhyAre());
                                  //   },
                                  //   child: Text(authController.actLocation.toString(),style: TextStyle(color: Colors.white),)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (authController.user!.value.email != '')
                                    Text(
                                      authController.user!.value.email,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "first_name".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: authController.firstnameController,
                                decoration: InputDecoration(
                                  hintText: "enter_first_name".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "last_name".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: authController.lastnameController,
                                decoration: InputDecoration(
                                  hintText: "enter_last_name".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Country".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => Container(
                                  alignment: Alignment.centerLeft,
                                  child: authController.NewCountry.value != null
                                      ? Text("Country :" +
                                          authController.NewCountry.value)
                                      : Text(''),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          authController.NewState.value != null
                                              ? Text("State :" +
                                                  authController.NewState.value)
                                              : Text(''),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                width: 250,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white
                                                    //
                                                    ),
                                                child: Stack(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 148),
                                                    child: Image.asset(
                                                      "assets/image/popup.jpg",
                                                      width: 320,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, left: 58),
                                                    child: Text(
                                                      "Country State City",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Form(
                                                    child: SelectState(
                                                        onCountryChanged:
                                                            (country) {
                                                      setState(() {
                                                        authController
                                                            .NewCountry
                                                            .value = country;
                                                      });
                                                      // }
                                                    }, onStateChanged: (state) {
                                                      setState(() {
                                                        authController.NewState
                                                            .value = state;
                                                      });
                                                      // }
                                                    }, onCityChanged: (city) {
                                                      setState(() {
                                                        authController.NewCity
                                                            .value = city;
                                                      });
                                                      // }
                                                    }),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 260, left: 95),
                                                    child: MaterialButton(
                                                        shape: StadiumBorder(),
                                                        color: Color.fromARGB(
                                                            255, 56, 171, 216),
                                                        child: Text(
                                                          "Update",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.arrow_circle_right))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => Container(
                                  alignment: Alignment.centerLeft,
                                  child: authController.NewCity.value != null
                                      ? Text("City :" +
                                          authController.NewCity.value)
                                      : Text(''),
                                ),
                              ),
                              //                       StatefulBuilder(
                              //                         builder: ((context, setState) {
                              //                           return SelectState(
                              //                               onCountryChanged: (country) {
                              //                             if (authController.NewCountry.value !=
                              //                                 null) {
                              //                               setState(() {
                              //                                 Obx(()=>Text(authController.NewCountry.value));
                              //                               });
                              //                             } else {
                              //                               setState(() {
                              //                                 authController.NewCountry.value =
                              //                                     country;
                              //                               });
                              //                             }
                              //                           }, onStateChanged: (state) {
                              //                             if (authController.NewState.value != null) {
                              //                               setState(() {
                              //                                 Obx(()=>Text(authController.NewState.value));
                              //                               });
                              //                             } else {
                              //                               setState(() {
                              //                                 authController.NewState.value = state;
                              //                               });
                              //                             }
                              //                           }, onCityChanged: (city) {
                              //                             if (authController.NewCity.value != null) {
                              //                               setState(() {
                              //                                 Obx(()=>Text(authController.NewCity.value));
                              //                               });
                              //                             } else {
                              //                               setState(() {
                              //                                 authController.NewCity.value = city;
                              //                               });
                              //                             }
                              //                           });
                              // })),
                              // return SelectState(
                              //   onCountryChanged: (country) {
                              //     if(authController.NewCountry.value==null)
                              //     authController.NewCountry.value=authController.NewCountry.value;
                              //     setState(() {
                              //       authController.NewCountry.value =
                              //           country;
                              //     });
                              //   },
                              //   onStateChanged: (state) {
                              //     setState(() {
                              //       authController.NewState.value = state;
                              //     });
                              //   },
                              //   onCityChanged: (city) {
                              //     setState(() {
                              //       authController.NewCity.value = city;
                              //     });
                              //   },
                              // );
                              //   }),
                              // ),
                              // StatefulBuilder(builder: ((context, setState) {
                              //   return CSCPicker(
                              //     layout: Layout.vertical,

                              //     ///Enable disable state dropdown [OPTIONAL PARAMETER]
                              //     showStates: true,

                              //     /// Enable disable city drop down [OPTIONAL PARAMETER]
                              //     showCities: true,

                              //     ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                              //     flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                              //     ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                              //     dropdownDecoration: BoxDecoration(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(30)),
                              //         color: Colors.white,
                              //         border: Border.all(
                              //             color: Colors.grey.shade300,
                              //             width: 1)),

                              //     ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                              //     disabledDropdownDecoration: BoxDecoration(
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(30)),
                              //         color: Colors.grey.shade300,
                              //         border: Border.all(
                              //             color: Colors.grey.shade300,
                              //             width: 1)),

                              //     ///selected item style [OPTIONAL PARAMETER]
                              //     selectedItemStyle: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 14,
                              //     ),

                              //     ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                              //     dropdownHeadingStyle: TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.bold),

                              //     ///DropdownDialog Item style [OPTIONAL PARAMETER]
                              //     dropdownItemStyle: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 14,
                              //     ),

                              //     ///Dialog box radius [OPTIONAL PARAMETER]
                              //     dropdownDialogRadius: 10.0,

                              //     defaultCountry: DefaultCountry.Bahamas_The,

                              //     ///Search bar radius [OPTIONAL PARAMETER]
                              //     searchBarRadius: 10.0,

                              //     ///triggers once country selected in dropdown
                              //     onCountryChanged: (value) {
                              //       setState(() {
                              //         ///store value in country variable
                              //         countryValue = value;
                              //       });
                              //     },

                              //     ///triggers once state selected in dropdown
                              //     onStateChanged: (value) {
                              //       setState(() {
                              //         ///store value in state variable
                              //         stateValue = value!;
                              //       });
                              //     },

                              //     ///triggers once city selected in dropdown
                              //     onCityChanged: (value) {
                              //       setState(() {
                              //         ///store value in city variable
                              //         cityValue = value!;
                              //       });
                              //     },
                              //   );
                              // })),

                              // ///print newly selected country state and city in Text Widget
                              // TextButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         address =
                              //             "$cityValue, $stateValue, $countryValue";
                              //       });
                              //     },
                              //     child: Text("Print Data")),
                              // Text(address!)
                              // Container(
                              //     width: width / 1.2,
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         showCountryPicker(
                              //           context: context,
                              //           exclude: <String>['KN', 'MF'],
                              //           showPhoneCode: true,
                              //           onSelect: (Country country) {
                              //             authController
                              //                 .updateOriginCountry(country);
                              //           },
                              //         );
                              //       },
                              //       child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               authController.countryName.value
                              //                           .length <=
                              //                       30
                              //                   ? authController
                              //                       .countryName.value
                              //                   : authController
                              //                       .countryName.value
                              //                       .substring(0, 29),
                              //              style: TextStyle(fontSize: 16),
                              //             ),
                              //             Icon(
                              //               Icons.arrow_drop_down,
                              //               color: Color(0xff38ABD8),
                              //             ),
                              //           ]),
                              //     ),
                              //     ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller:
                                    authController.phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: "Enter Phone Number".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Container(
                              //   height: 60,
                              //   padding: EdgeInsets.symmetric(horizontal: 17),
                              //   child: Center(
                              //     child: DropdownButtonFormField<String>(
                              //       // focusColor: Color(0xff38ABD8),
                              //       iconEnabledColor: Color(0xff38ABD8),
                              //       value: authController.gender.value,
                              //       items: authController.genders.map((gender) {
                              //         return new DropdownMenuItem(
                              //           value: gender,
                              //           child: Text(
                              //             gender.toString(),
                              //            style: TextStyle(fontSize: 15),
                              //           ),
                              //         );
                              //       }).toList(),
                              //       hint: Text("select gender"),
                              //       decoration: InputDecoration(
                              //           border: InputBorder.none),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           authController.updateGender(value!);
                              //         });
                              //       },
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
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
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Date of Birth".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  authController.selectDate(context);
                                },
                                child: TextFormField(
                                  controller: authController.dobController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "select_dob".tr,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Why are you here",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_user.whyarewehere),
                                    // Image.asset("assets/Polygon 10.jpg")
                                    IconButton(
                                      icon: Icon(Icons.play_arrow),
                                      color: Color(0xff38ABD8),
                                      onPressed: () {
                                        Get.to(WhyAre());
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "About Me".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: authController.aboutMeController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  hintText: 'Lorem Ispum dolr sit amit',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "Job Title".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: authController.jobController,
                                decoration: InputDecoration(
                                  hintText: "job_title".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text(
                                    "University".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: authController.universityController,
                                decoration: InputDecoration(
                                  // labelText: "university".tr,
                                  hintText: "university".tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "more_photos".tr,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 130, 0),
                                child: Container(
                                  width: width * 0.6,
                                  height: 96,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      // image: DecorationImage(
                                      //   image: AssetImage(
                                      //     "assets/photos.png",
                                      //   ),
                                      //   fit: BoxFit.contain,
                                      // ),
                                      ),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          authController.morePhotosURLs.length +
                                              1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            color: Color(0xff38ABD8),
                                            borderRadius:
                                                BorderRadius.circular(55),
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: (authController.morePhotosURLs
                                                          .length >
                                                      0 &&
                                                  index <
                                                      authController
                                                          .morePhotosURLs
                                                          .length)
                                              ? Stack(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    42)),
                                                        child: SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Image.network(
                                                              authController
                                                                      .morePhotosURLs[
                                                                  index],
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          }),
                                                        )),
                                                    Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                          child: Container(
                                                            child: Icon(
                                                              Icons
                                                                  .cancel_rounded,
                                                              color: Colors
                                                                  .red[900],
                                                              size: 25,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            authController
                                                                .morePhotoDelete(
                                                                    index);
                                                          },
                                                        ))
                                                  ],
                                                )
                                              : GestureDetector(
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.add,
                                                          size: 40,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    imagePickerDialog(context);
                                                  },
                                                ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      // Icon(
                                      //   Icons.favorite,
                                      //   size: 25,
                                      //   color: Colors.black.withOpacity(0.5),
                                      // ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${'interest'.tr}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              Container(
                                height: height * 0.4,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: ListView(
                                  children: authController.demoInterestList.keys
                                      .map((String key) {
                                    return new CheckboxListTile(
                                      value:
                                          authController.demoInterestList[key],
                                      activeColor: Color(0xff38ABD8),
                                      checkColor: Colors.white,
                                      onChanged: (bool? value) {
                                        authController.updateInterestList(
                                            value, key);
                                      },
                                      title: new Text(key),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    );
                                  }).toList(),
                                ),
                              ),
                              //   ListView(
                              //     children:
                              //        authController.demoInterestList.keys.map((String key) {
                              // return   FlutterLimitedCheckbox(limitedValueList:authController.demoInterestList[key] , limit: 4,
                              // onChanged: (List<FlutterLimitedCheckBoxModel>List) {
                              //   authController.updateInterestList(value, key);
                              // },
                              // );
                              //        }).toList()
                              //   ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                child: Container(
                                  width: width * 1,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xff38ABD8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "update".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () async {
                                  authController.updateProfile(
                                      context: context);
                                  new Timer(const Duration(seconds: 2), () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return AccountSettingPage();
                                    }));
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 35,
                          left: 15,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
