import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/ui/home_page.dart';

import 'loginsetttngs.dart';

class LoginProfile extends StatefulWidget {
  @override
  LoginProfileState createState() => LoginProfileState();
}

class LoginProfileState extends State<LoginProfile> {
  AuthController authController = Get.find(tag: AuthController().toString());
  String selectedCountry = 'BS';

  // imagePickerDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         // shape:
  //         //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         // insetPadding: EdgeInsets.all(19),
  //         child: Container(
  //           width: 190,
  //           height: 250,

  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.white
  //             //
  //           ),
  //           child: Stack(children: [
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 148),
  //               child: Image.asset(
  //                 "assets/image/popup.jpg",
  //                 width: 320,
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20, left: 58),
  //               child: Text(
  //                 "Upload Photos from",
  //                style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 19,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),

  //             Padding(
  //               padding: const EdgeInsets.only(top:140),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Column(
  //                     children: [
  //                       GestureDetector(
  //                         child: Icon(
  //                           Icons.folder,
  //                           size: 50,
  //                         ),
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                           authController.getImage('gallery');
  //                         },
  //                       ),
  //                       Text(
  //                         // 'browse_image'.tr,
  //                         'Your Photos',
  //                        style: TextStyle(color: Colors.black),
  //                       )
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: 50,
  //                   ),
  //                   Column(
  //                     children: [
  //                       GestureDetector(
  //                         child: Icon(
  //                           Icons.camera_alt,
  //                           size: 50,
  //                         ),
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                           authController.getImage('camera');
  //                         },
  //                       ),
  //                       Text(
  //                         // 'take_photo'.tr,
  //                         'Camera',
  //                        style: TextStyle(color: Colors.black),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ]),
  //           // child: Column(
  //           //   mainAxisAlignment: MainAxisAlignment.start,
  //           //   children: [
  //           //     Container(
  //           //       height: 100,
  //           //       width: double.infinity,
  //           //       decoration: BoxDecoration(
  //           //         shape: BoxShape.rectangle,
  //           //         borderRadius: BorderRadius.circular(10),
  //           //         color: Colors.blue,
  //           //         image: DecorationImage(
  //           //             image: AssetImage("assets/image/hjhhjhj.png"),
  //           //             fit: BoxFit.cover),
  //           //       ),
  //           //       child: Padding(
  //           //         padding: const EdgeInsets.only(top: 10, left: 35),
  //           //         child: Text(
  //           //           "Upload Photos from",
  //           //          style: TextStyle(color: Colors.white, fontSize: 16),
  //           //         ),
  //           //       ),
  //           //     ),
  //           //     SizedBox(
  //           //       height: 20,
  //           //     ),
  //           //     Row(
  //           //       crossAxisAlignment: CrossAxisAlignment.center,
  //           //       mainAxisAlignment: MainAxisAlignment.center,
  //           //       children: [
  //           //         Column(
  //           //           children: [
  //           //             GestureDetector(
  //           //               child: Icon(
  //           //                 Icons.folder,
  //           //                 size: 50,
  //           //               ),
  //           //               onTap: () {
  //           //                 Navigator.pop(context);
  //           //                 authController.getImage('gallery');
  //           //               },
  //           //             ),
  //           //             Text(
  //           //               // 'browse_image'.tr,
  //           //               'Your Photos',
  //           //              style: TextStyle(color: Colors.black),
  //           //             )
  //           //           ],
  //           //         ),
  //           //         SizedBox(
  //           //           width: 50,
  //           //         ),
  //           //         Column(
  //           //           children: [
  //           //             GestureDetector(
  //           //               child: Icon(
  //           //                 Icons.camera_alt,
  //           //                 size: 50,
  //           //               ),
  //           //               onTap: () {
  //           //                 Navigator.pop(context);
  //           //                 authController.getImage('camera');
  //           //               },
  //           //             ),
  //           //             Text(
  //           //               // 'take_photo'.tr,
  //           //               'Camera',
  //           //              style: TextStyle(color: Colors.black),
  //           //             )
  //           //           ],
  //           //         ),
  //           //       ],
  //           //     )
  //           //   ],
  //           // ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    authController.getUser(FirebaseAuth.instance.currentUser!.uid, context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          padding: const EdgeInsets.only(top: 70),
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
                              // Stack(
                              //   alignment: AlignmentDirectional.center,
                              //   clipBehavior: Clip.none,
                              //   fit: StackFit.passthrough,
                              //   children: <Widget>[
                              //     Container(
                              //       width: width * 0.7,
                              //       height: width * 0.3,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(100),
                              //         image: DecorationImage(
                              //             fit: BoxFit.fill,
                              //             image: authController.morePhotosURLs.length > 1
                              //                 ? (NetworkImage(authController
                              //                     .morePhotosURLs.first))
                              //                 : (authController.imageFile != null
                              //                         ? FileImage(authController
                              //                             .imageFile!)
                              //                         : (authController.user?.value
                              //                                         .avatar !=
                              //                                     null &&
                              //                                 authController
                              //                                         .user
                              //                                         ?.value
                              //                                         .avatar !=
                              //                                     ''
                              //                             ? NetworkImage(
                              //                                 authController.user!
                              //                                     .value.avatar)
                              //                             : (AssetImage('assets/image/sample_avatar.png'))))
                              //                     as ImageProvider),
                              //       ),
                              //       child: Align(
                              //         alignment: Alignment.topRight,
                              //         child: authController.imageFile == null
                              //             ? GestureDetector(
                              //                 child: Container(
                              //                   padding: EdgeInsets.all(5),
                              //                   decoration: BoxDecoration(
                              //                     color: Colors.blue,
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             100),
                              //                   ),
                              //                   child: Icon(
                              //                     Icons.edit,
                              //                     color: Colors.white,
                              //                     size: 20,
                              //                   ),
                              //                 ),
                              //                 onTap: () {
                              //                   // imagePickerDialog(context);
                              //                 },
                              //               )
                              //             : GestureDetector(
                              //                 child: Container(
                              //                   child: Icon(
                              //                     Icons.cancel_rounded,
                              //                     color: Colors.red,
                              //                     size: 30,
                              //                   ),
                              //                 ),
                              //                 onTap: () {
                              //                   authController
                              //                       .updateImageFile(null);
                              //                 },
                              //               ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     if (authController.user!.value.email != '')
                              //       Text(
                              //         authController.user!.value.email,
                              //        style: TextStyle(fontSize: 16),
                              //       ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 75,
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
                                    "Last Name",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Country",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    exclude: <String>['KN', 'MF'],
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      selectedCountry = country.countryCode;
                                      setState(() {});
                                      authController
                                          .updateOriginCountry(country);
                                    },
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 250,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              authController.countryName.value
                                                          .length <=
                                                      30
                                                  ? authController
                                                      .countryName.value
                                                  : authController
                                                      .countryName.value
                                                      .substring(0, 29),
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff2E2E2E),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller:
                                    authController.phoneNumberController,
                                decoration: InputDecoration(
                                  // labelText: "phone_number".tr,
                                  hintText: "+244 234576482",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,

                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CountryCodePicker(
                                      alignLeft: false,
                                      onChanged: (e) {
                                        authController
                                            .updatePhoneNumberCode(e.code!);
                                      },
                                      initialSelection: selectedCountry,
                                      favorite: ['Bs', 'Bb'],
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Container(
                              //     child: Text(
                              //       "Country".tr,
                              //      style: TextStyle(
                              //           fontSize: 18,
                              //           color: Color(0xff2E2E2E),
                              //           fontWeight: FontWeight.bold),
                              //       textAlign: TextAlign.start,
                              //     ),
                              //   ),
                              // ),
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
                              //     )),
                              // Divider(
                              //   color: Colors.black,
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Container(
                              //     child: Text(
                              //       "Phone Number",
                              //      style: TextStyle(
                              //           fontSize: 18,
                              //           color: Color(0xff2E2E2E),
                              //           fontWeight: FontWeight.bold),
                              //       textAlign: TextAlign.start,
                              //     ),
                              //   ),
                              // ),
                              // TextFormField(
                              //   controller:
                              //       authController.phoneNumberController,
                              //   decoration: InputDecoration(
                              //     hintText: "Enter Phone Number".tr,
                              //     floatingLabelBehavior:
                              //         FloatingLabelBehavior.always,
                              //        prefixIcon: Padding(
                              //           padding:
                              //               const EdgeInsets.only(left: 8.0),
                              //           child: CountryCodePicker(
                              //             alignLeft: false,
                              //             onChanged: (e) {
                              //               authController
                              //                   .updatePhoneNumberCode(
                              //                       e.code!);
                              //             },
                              //             initialSelection: selectedCountry,
                              //             favorite: ['Bs', 'Bb'],
                              //           ),
                              //         ),
                              //   ),
                              //   keyboardType: TextInputType.number,

                              // ),
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
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Container(
                              //     child: Text(
                              //       "Why are you here",
                              //      style: TextStyle(
                              //           fontSize: 18,
                              //           color: Color(0xff2E2E2E),
                              //           fontWeight: FontWeight.bold),
                              //       textAlign: TextAlign.start,
                              //     ),
                              //   ),
                              // ),

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
                              // SizedBox(
                              //   height: 30,
                              // ),
                              // Container(
                              //     alignment: Alignment.centerLeft,
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           "more_photos".tr,
                              //          style: TextStyle(
                              //             fontSize: 17,
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //       ],
                              //     )),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(0, 0, 130, 0),
                              //   child: Container(
                              //     width: width * 0.6,
                              //     height: 96,
                              //     alignment: Alignment.centerLeft,
                              //     decoration: BoxDecoration(
                              //         // image: DecorationImage(
                              //         //   image: AssetImage(
                              //         //     "assets/photos.png",
                              //         //   ),
                              //         //   fit: BoxFit.contain,
                              //         // ),
                              //         ),
                              //     child: ListView.builder(
                              //         scrollDirection: Axis.horizontal,
                              //         physics:
                              //             const AlwaysScrollableScrollPhysics(),
                              //         shrinkWrap: true,
                              //         itemCount:
                              //             authController.morePhotosURLs.length +
                              //                 1,
                              //         itemBuilder: (context, index) {
                              //           return Container(
                              //             margin: EdgeInsets.only(left: 10),
                              //             decoration: BoxDecoration(
                              //               border: Border.all(
                              //                   color: Colors.grey, width: 1),
                              //               color: Color(0xff38ABD8),
                              //               borderRadius:
                              //                   BorderRadius.circular(55),
                              //             ),
                              //             width: 100,
                              //             height: 100,
                              //             child: (authController.morePhotosURLs
                              //                             .length >
                              //                         0 &&
                              //                     index <
                              //                         authController
                              //                             .morePhotosURLs
                              //                             .length)
                              //                 ? Stack(
                              //                     children: [
                              //                       ClipRRect(
                              //                           borderRadius:
                              //                               BorderRadius.all(
                              //                                   Radius.circular(
                              //                                       42)),
                              //                           child: SizedBox(
                              //                             width: 100,
                              //                             height: 100,
                              //                             child: Image.network(
                              //                                 authController
                              //                                         .morePhotosURLs[
                              //                                     index],
                              //                                 fit: BoxFit.cover,
                              //                                 loadingBuilder:
                              //                                     (BuildContext
                              //                                             context,
                              //                                         Widget
                              //                                             child,
                              //                                         ImageChunkEvent?
                              //                                             loadingProgress) {
                              //                               if (loadingProgress ==
                              //                                   null)
                              //                                 return child;
                              //                               return Center(
                              //                                 child:
                              //                                     CircularProgressIndicator(
                              //                                   value: loadingProgress
                              //                                               .expectedTotalBytes !=
                              //                                           null
                              //                                       ? loadingProgress
                              //                                               .cumulativeBytesLoaded /
                              //                                           loadingProgress
                              //                                               .expectedTotalBytes!
                              //                                       : null,
                              //                                 ),
                              //                               );
                              //                             }),
                              //                           )),
                              //                       Align(
                              //                           alignment:
                              //                               Alignment.topRight,
                              //                           child: GestureDetector(
                              //                             child: Container(
                              //                               child: Icon(
                              //                                 Icons
                              //                                     .cancel_rounded,
                              //                                 color: Colors
                              //                                     .red[900],
                              //                                 size: 25,
                              //                               ),
                              //                             ),
                              //                             onTap: () {
                              //                               authController
                              //                                   .morePhotoDelete(
                              //                                       index);
                              //                             },
                              //                           ))
                              //                     ],
                              //                   )
                              //                 : GestureDetector(
                              //                     child: Container(
                              //                       child: Column(
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment
                              //                                 .center,
                              //                         children: <Widget>[
                              //                           Icon(
                              //                             Icons.add,
                              //                             size: 40,
                              //                             color: Colors.black,
                              //                           ),
                              //                         ],
                              //                       ),
                              //                     ),
                              //                     onTap: () {
                              //                       // imagePickerDialog(context);
                              //                     },
                              //                   ),
                              //           );
                              //         }),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   mainAxisSize: MainAxisSize.max,
                              //   children: [
                              //     Container(
                              //         child: Row(
                              //       children: [
                              //         // Icon(
                              //         //   Icons.favorite,
                              //         //   size: 25,
                              //         //   color: Colors.black.withOpacity(0.5),
                              //         // ),
                              //         SizedBox(width: 5),
                              //         Text(
                              //           "${'interest'.tr}",
                              //          style: TextStyle(
                              //               fontSize: 17,
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       ],
                              //     )),
                              //   ],
                              // ),
                              // Container(
                              //   height: height * 0.4,
                              //   padding: EdgeInsets.symmetric(vertical: 10),
                              //   child: ListView(
                              //     children: authController.demoInterestList.keys
                              //         .map((String key) {
                              //       return new CheckboxListTile(
                              //         value:
                              //             authController.demoInterestList[key],
                              //         activeColor: Color(0xff38ABD8),
                              //         checkColor: Colors.white,
                              //         onChanged: (bool? value) {
                              //           authController.updateInterestList(
                              //               value, key);
                              //         },
                              //         title: new Text(key),
                              //         controlAffinity:
                              //             ListTileControlAffinity.leading,
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Container(
                                    width: width * 1,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xff38ABD8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  authController.updateProfile(
                                      context: context);
                                  new Timer(const Duration(seconds: 2), () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return LoginSetting();
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
