import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  AuthController authController = Get.find(tag: AuthController().toString());
  bool _isInAsyncCall = false;
  TextEditingController phoneNumberController = new TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String countryCode = "+1242", phoneNumber = '+1242 423 2342';
  String? smsCode, _verificationId;
  bool _isEnableSMS = false,
      _isEnteredOTP = false,
      _isCodeSentStatus = false,
      _isCodeReceiveStatus = false;
  int? _otp, enteredOtp;
  int _start = 120;
  Timer? _timer;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _onCountryChange(CountryCode countryCode) {
    this.countryCode = countryCode.toString();
  }

  void _isEnableButton(String text, int position) {
    setState(() {
      if (position == 1) {
        if (text.length >= 7) {
          _isEnableSMS = true;
        } else {
          _isEnableSMS = false;
        }
      } else if (position == 2) {
        enteredOtp = int.parse(text);
        if (text.length >= 6) {
          _isEnteredOTP = true;
        } else {
          _isEnteredOTP = false;
        }
      }
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start = 120;
            _isCodeReceiveStatus = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> sendingSMS() async {
    _start = 120;
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        this._isCodeSentStatus = true;
        _isInAsyncCall = false;
      });
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((userCredential) {
        if (userCredential.user?.uid != null) {
          authController.firebaseFirestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .get()
              .then((doc) async {
            if (doc.data() != null) {
              setState(() {
                _isInAsyncCall = false;
              });
              authController.alert1('user_already_exist'.tr);
            } else {
              authController.firebaseFirestore
                  .collection('users')
                  .doc(userCredential.user?.uid)
                  .set({
                'phoneCode': countryCode,
                'phone': phoneNumberController.text.trim(),
                'email': '',
                'lastActive': '',
                'status': true,
                'createdAt': Timestamp.now().millisecondsSinceEpoch,
                'updatedAt': Timestamp.now().millisecondsSinceEpoch,
              }).then((value) {
                // UserModel _user = authController.user!.value;
                // _user.phoneCode = countryCode;
                // _user.phoneCode = phoneNumberController.text.trim();
                // authController.updateUser(_user);
                // // user.phoneCode = countryCode;
                // // user.phone = phoneNumberController.text.trim();
                // setState(() {
                //   _timer?.cancel();
                //   _isInAsyncCall = false;
                // });
                // authController.alert1('User has been successfully registered!');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => SignUpSecondPage(),
                //     ));
              });
            }
          });
        } else {
          setState(() {
            authController.alert1('invalid_code_authentication'.tr);
          });
        }
      }).catchError((error) {
        authController.alert1('something_has_gone'.tr);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print("error: $authException.message");
    };
    final PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) async {
      this._verificationId = verificationId;
      setState(() {
        this._isCodeSentStatus = true;
        _isInAsyncCall = false;
        startTimer();
      });
      authController.alert1('code_has_been_sent'.tr);
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 120),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      setState(() {
        _isInAsyncCall = false;
      });
      authController.alert1("${'failed_to_verify'.tr}: $e");
    }
  }

  void _submitOTP() {
    /// when used different phoneNumber other than the current (running) device
    /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: _verificationId ?? '', smsCode: enteredOtp.toString());
    _firebaseAuth.signInWithCredential(_credential).then((result) {
      authController.firebaseFirestore
          .collection('users')
          .doc(result.user?.uid)
          .get()
          .then((doc) async {
        if (doc.data() != null) {
          setState(() {
            _isInAsyncCall = false;
          });
          authController.alert1('user_already_exist'.tr);
        } else {
          authController.firebaseFirestore
              .collection('users')
              .doc(result.user?.uid)
              .set({
            'phoneCode': countryCode,
            'phone': phoneNumberController.text.trim(),
            'email': '',
            'lastActive': '',
            'status': true,
            'createdAt': Timestamp.now().millisecondsSinceEpoch,
            'updatedAt': Timestamp.now().millisecondsSinceEpoch,
          }).then((value) {
            // user.phoneCode = countryCode;
            // user.phone = phoneNumberController.text.trim();
            // UserModel _user = authController.user!.value;
            // _user.phoneCode = countryCode;
            // _user.phone = phoneNumberController.text.trim();
            // authController.updateUser(_user);
            // setState(() {
            //   _timer?.cancel();
            //   _isInAsyncCall = false;
            // });
            // authController.alert1('User has been successfully registered!');
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SignUpSecondPage(),
            //     ));
          });
        }
      });
    }).catchError((e) {
      setState(() {
        _isInAsyncCall = false;
      });
      authController.alert1(e.toString());
    });
  }

  void moveNextPage() {
    if (enteredOtp == _otp) {
      _timer?.cancel();
      Navigator.pushNamed(context, RoutePath.sign_up_second);
    } else {
      authController.alert1('verification_incorrect'.tr);
    }
  }

  @override
  void initState() {
    _firebaseAuth.setLanguageCode('en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: GetBuilder(
            init: authController,
            builder: (_) {
              return Container(
                width: width,
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // GestureDetector(
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 20,
                      //         height: 15,
                      //         margin: EdgeInsets.only(left: 20),
                      //         decoration: BoxDecoration(
                      //             border: Border.all(
                      //               color: Colors.white,
                      //             ),
                      //             color: Colors.white,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20))),
                      //         child: Icon(
                      //           Icons.arrow_back,
                      //           color: Colors.black,
                      //           size: 25,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      //   onTap: () {
                      //     Navigator.pushNamed(context, RoutePath.auth_page);
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 22,
                      // ),
                      Container(
                        // width: width * 0.6,
                        width: width,
                        height: 250,
                        // child: Image.asset(name),
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage('assets/newbg.png',),
                        //   ),
                        // ),
                        child: Image.asset(
                          'assets/newbg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: width * 0.9,
                        child: _isCodeSentStatus
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'is_your_phone_number'.tr,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    phoneNumber,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent[700]),
                                  ),
                                  SizedBox(height: 23),
                                  PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    animationType: AnimationType.fade,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.underline,
                                      // shape: PinCodeFieldShape.box,
                                      // borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: Colors.white,
                                      inactiveFillColor: Colors.grey,
                                    ),
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    errorAnimationController: errorController,
                                    cursorColor: Colors.black,
                                    onCompleted: (v) {
                                      _isEnableButton(v, 2);
                                    },
                                    onChanged: (value) {
                                      _isEnableButton(value, 2);
                                    },
                                    beforeTextPaste: (text) {
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return true;
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  _isCodeReceiveStatus
                                      ? Row(
                                          children: [
                                            Text(
                                              "i_didnt_received_code".tr,
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 14,
                                                  color:
                                                      Colors.greenAccent[700]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              child: Text(
                                                'resend'.tr,
                                                style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _isInAsyncCall = true;
                                                });
                                                sendingSMS();
                                              },
                                            )
                                          ],
                                        )
                                      : Text(
                                          '${'resend_code'.tr}:' +
                                              '$_start' +
                                              'seconds'.tr,
                                          style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontSize: 14,
                                              color: Colors.black87),
                                        ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: _isEnteredOTP
                                        ? () {
                                            setState(() {
                                              _isInAsyncCall = true;
                                            });
                                            _submitOTP();
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 66, vertical: 14),
                                      backgroundColor: Colors.greenAccent[700],
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      'next'.tr,
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone number",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextFormField(
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                      // labelText: "phone_number".tr,
                                      hintText: "enter_phone_number".tr,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: UnderlineInputBorder(
                                          // borderRadius:
                                          //     BorderRadius.circular(20)
                                          ),
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: CountryCodePicker(
                                          alignLeft: false,
                                          onChanged: _onCountryChange,
                                          initialSelection: '+1242',
                                          favorite: ['Bs', 'Bb'],
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) {
                                      phoneNumber = countryCode + text.trim();
                                      _isEnableButton(text, 1);
                                    },
                                    validator: (number) {
                                      // Basic validation
                                      if (number.toString().isEmpty) {
                                        return "please_enter_phone_number".tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'we_will_send_verification_code'.tr,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 14,
                                        color: Color(0xff38ABD8),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: width / 1.2,
                                        height: 45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff38ABD8),
                                          ),
                                          child: Text(
                                            'get_an_sms'.tr,
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                          onPressed: _isEnableSMS
                                              ? () {
                                                  setState(() {
                                                    _isInAsyncCall = true;
                                                  });
                                                  sendingSMS();
                                                }
                                              : null,
                                        ),
                                      )),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
