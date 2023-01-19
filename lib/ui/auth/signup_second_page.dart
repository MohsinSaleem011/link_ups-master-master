import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/ui/auth/loginprofile.dart';

class SignUpSecondPage extends StatefulWidget {
  @override
  _SignUpSecondPageState createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  AuthController authController = Get.find(tag: AuthController().toString());

  TextEditingController dobController =
      new TextEditingController(text: 'Select Your Birthday');
  File? _image;
  List<String> _genders = ['Male', 'Female'];
  FirebaseFirestore db = FirebaseFirestore.instance;
  String selectedCountry = 'BS';
  // imagePickerDialog(BuildContext context) async {
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       width: double.minPositive,
  //       height: 110,
  //       color: Colors.white,
  //       padding: EdgeInsets.only(
  //         left: 25,
  //       ),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 10,
  //           ),

  //         ],
  //       ),
  //     ),
  //   );
  // }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
    if (picked != null)
      setState(() {
        authController.updateDOB(picked.millisecondsSinceEpoch);
        dobController.text =
            authController.timeStampToDate(picked.millisecondsSinceEpoch);
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    authController.firstnameController.clear();
    authController.lastnameController.clear();
    authController.aboutMeController.clear();
    authController.jobController.clear();
    authController.universityController.clear();
    authController.phoneNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            height: 350,
            child: Stack(
              children: [
                Image.asset("assets/Group 163959.png"),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    child: Center(
                      child: _image == null
                          ? Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 5, color: Color(0xff38ABD8))),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_image!),
                            ),
                    ),
                    // onTap: () {
                    //   /// Get profile image
                    //   imagePickerDialog(context);
                    // },
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LoginProfile();
                  }));
                  authController.getImage('gallary');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/gallery.png",
                      width: 150,
                      height: 200,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return LoginProfile();
                  }));
                  // getImageCamera();
                  var response = await authController.getImage('camera');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset("assets/Group 164010.png")],
                ),
              ),
            ],
          )
        ],
      ),
      // body: GetBuilder(
      //     init: authController,
      //     builder: (_) {
      //       if (authController.loading.value == true) {
      //         return Scaffold(
      //           body: Center(child: CircularProgressIndicator()),
      //         );
      //       } else
      //         return Container(
      //           width: width,
      //           height: height,
      //           child: SingleChildScrollView(
      //             child: Column(
      //               children: <Widget>[
      //                 Container(
      //                   width: MediaQuery.of(context).size.width,
      //                   child: Column(
      //                     children: [
      //                       if (authController.user?.value.avatar == '')

      //                       SizedBox(
      //                         height: 30,
      //                       ),
      // if (authController.user?.value.avatar != '')
      //   Column(
      //     children: [
      //       TextFormField(
      //         controller:
      //             authController.firstnameController,
      //         decoration: InputDecoration(
      //           labelText: "first_name".tr,
      //           hintText: "enter_first_name".tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Icon(Icons.person),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         controller:
      //             authController.lastnameController,
      //         decoration: InputDecoration(
      //           labelText: "last_name".tr,
      //           hintText: "enter_last_name".tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Icon(Icons.person),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           showCountryPicker(
      //             context: context,
      //             exclude: <String>['KN', 'MF'],
      //             showPhoneCode: true,
      //             onSelect: (Country country) {
      //               selectedCountry =
      //                   country.countryCode;
      //               setState(() {});
      //               authController
      //                   .updateOriginCountry(country);
      //             },
      //           );
      //         },
      //         child: Container(
      //           height: 60,
      //           padding: EdgeInsets.symmetric(
      //               horizontal: 15),
      //           decoration: BoxDecoration(
      //               color: Colors.transparent,
      //               border: Border.all(
      //                   color: Colors.grey
      //                       .withOpacity(0.9)),
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           child: Row(
      //             mainAxisAlignment:
      //                 MainAxisAlignment.spaceBetween,
      //             children: [
      //               Container(
      //                 width: 87,
      //                 child: Row(
      //                   children: [
      //                     Icon(
      //                       Icons.home_work_sharp,
      //                       size: 20,
      //                       color: Colors.black
      //                           .withOpacity(0.5),
      //                     ),
      //                     SizedBox(width: 5),
      //                     Text(
      //                       "country".tr,
      //                      style: TextStyle(
      //                           fontSize: 14,
      //                           color: Colors.black
      //                               .withOpacity(0.5),
      //                           fontWeight:
      //                               FontWeight.bold),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Container(
      //                 width: 250,
      //                 child: Row(
      //                   mainAxisAlignment:
      //                       MainAxisAlignment
      //                           .spaceBetween,
      //                   children: [
      //                     Text(
      //                       authController.countryName
      //                                   .value.length <=
      //                               30
      //                           ? authController
      //                               .countryName.value
      //                           : authController
      //                               .countryName.value
      //                               .substring(0, 29),
      //                       style:
      //                           TextStyle(fontSize: 16),
      //                     ),
      //                     Icon(Icons.arrow_drop_down),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         controller:
      //             authController.phoneNumberController,
      //         decoration: InputDecoration(
      //           labelText: "phone_number".tr,
      //           hintText: "enter_phone_number".tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding:
      //                 const EdgeInsets.only(left: 8.0),
      //             child: CountryCodePicker(
      //               alignLeft: false,
      //               onChanged: (e) {
      //                 authController
      //                     .updatePhoneNumberCode(
      //                         e.code!);
      //               },
      //               initialSelection: selectedCountry,
      //               favorite: ['Bs', 'Bb'],
      //             ),
      //           ),
      //         ),
      //         keyboardType: TextInputType.number,
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Container(
      //         height: 60,
      //         padding:
      //             EdgeInsets.symmetric(horizontal: 17),
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //                 color:
      //                     Colors.grey.withOpacity(0.9)),
      //             borderRadius:
      //                 BorderRadius.circular(20)),
      //         child: Center(
      //           child: DropdownButtonFormField<String>(
      //             value: authController.gender.value,
      //             items: _genders.map((gender) {
      //               return new DropdownMenuItem(
      //                 value: gender,
      //                 child: Text(
      //                   gender.toString(),
      //                  style: TextStyle(fontSize: 15),
      //                 ),
      //               );
      //             }).toList(),
      //             hint: Text("select_gender".tr),
      //             decoration: InputDecoration(
      //                 border: InputBorder.none),
      //             onChanged: (value) {
      //               setState(() {
      //                 authController
      //                     .updateGender(value!);
      //               });
      //             },
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           _selectDate(context);
      //         },
      //         child: TextFormField(
      //           controller: dobController,
      //           enabled: false,
      //           decoration: InputDecoration(
      //             labelText: "dob".tr,
      //             hintText: "select_dob".tr,
      //             floatingLabelBehavior:
      //                 FloatingLabelBehavior.always,
      //             prefixIcon: Icon(
      //               Icons.date_range,
      //               size: 25,
      //               color:
      //                   Colors.black.withOpacity(0.5),
      //             ),
      //             disabledBorder: OutlineInputBorder(
      //               borderSide: BorderSide(
      //                   color: Colors.black
      //                       .withOpacity(0.4)),
      //               borderRadius:
      //                   BorderRadius.circular(20),
      //             ),
      //             border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20),
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         controller:
      //             authController.aboutMeController,
      //         maxLines: 4,
      //         decoration: InputDecoration(
      //           labelText: 'about_me'.tr,
      //           hintText: 'about_me'.tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Icon(
      //               Icons.work,
      //               size: 20,
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         controller: authController.jobController,
      //         decoration: InputDecoration(
      //           labelText: "job_title".tr,
      //           hintText: "job_title".tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Icon(
      //               Icons.work,
      //               size: 20,
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       TextFormField(
      //         controller:
      //             authController.universityController,
      //         decoration: InputDecoration(
      //           labelText: "university".tr,
      //           hintText: "university".tr,
      //           floatingLabelBehavior:
      //               FloatingLabelBehavior.always,
      //           border: OutlineInputBorder(
      //               borderRadius:
      //                   BorderRadius.circular(20)),
      //           prefixIcon: Padding(
      //             padding: const EdgeInsets.all(12.0),
      //             child: Icon(
      //               Icons.work,
      //               size: 20,
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //     ],
      //   ),
      // if (authController.user?.value.avatar != '')
      //   Container(
      //     width: width * 0.9,
      //     child: Container(
      //         alignment: Alignment.bottomCenter,
      //         child: SizedBox(
      //           width: double.infinity,
      //           height: 45,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //                backgroundColor: Colors.red[700],
      //             ),

      //             child: Text(
      //               'submit'.tr,
      //              style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 18),
      //             ),
      //             onPressed: () async {
      //               FocusScope.of(context).unfocus();

      //               if (authController
      //                       .user?.value.avatar !=
      //                   '') {
      //                 if (authController.firstnameController.text.trim().isEmpty ||
      //                     authController
      //                         .lastnameController.text
      //                         .trim()
      //                         .isEmpty ||
      //                     authController.countryName
      //                         .value.isEmpty ||
      //                     authController
      //                         .phoneNumberController
      //                         .text
      //                         .trim()
      //                         .isEmpty ||
      //                     authController
      //                         .jobController.text
      //                         .trim()
      //                         .isEmpty ||
      //                     authController.age.value ==
      //                         0) {
      //                   authController.alert1(
      //                       'please_fill_all_field'.tr);
      //                 } else if (authController
      //                         .age.value <
      //                     18) {
      //                   authController.alert1(
      //                       'minimum_age_should_be'.tr);
      //                 } else {
      //                   await authController
      //                       .updateProfile(
      //                           context: context);
      //                   new Timer(
      //                       const Duration(seconds: 2),
      //                       () {
      //                     Navigator.pushNamed(context,
      //                         RoutePath.sign_up_third);
      //                   });
      //                 }
      //               } else {
      //                 authController.alert1(
      //                     'please_upload_profile'.tr);
      //               }
      //             },
      //           ),
      //         )),
      //   ),
      // SizedBox(
      //   height: 20,
      // ),
    );
  }
}
