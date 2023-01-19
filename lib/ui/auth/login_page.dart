import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find(tag: AuthController().toString());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: authController,
        builder: (_) {
          return SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                Navigator.pushNamed(context, RoutePath.auth_page);
                return false;
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // GestureDetector(
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 20,
                      //         height: 15,
                      //         margin: EdgeInsets.only(left: 10),
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
                      //   height: height * 0.1,
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
                      Container(
                        width: width * 0.9,
                        padding: EdgeInsets.only(top: 10, bottom: 50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextFormField(
                                controller: authController.emailController,
                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  hintText: 'enter_your_email'.tr,
                                  // labelText: 'email'.tr,
                                  contentPadding: EdgeInsets.only(
                                      left: 0.0,
                                      top: 0.0,
                                      right: 0.0,
                                      bottom: 10.0),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'please_enter_email'.tr;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextFormField(
                                controller: authController.passwordController,
                                obscureText: _hidePassword,
                                decoration: InputDecoration(
                                  // prefixIcon: const Icon(Icons.lock),
                                  hintText: 'enter_password'.tr,
                                  // labelText: 'password'.tr,
                                  contentPadding: EdgeInsets.only(
                                      left: 0.0,
                                      // top: 2.0,
                                      right: 0.0,
                                      bottom: 10.0),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       _hidePassword = !_hidePassword;
                                  //     });
                                  //   },
                                  //   color: Theme.of(context).focusColor,
                                  //   icon: Icon(
                                  //     _hidePassword
                                  //         ? Icons.visibility
                                  //         : Icons.visibility_off,
                                  //     color: Colors.black.withOpacity(0.5),
                                  //   ),
                                  // ),
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'please_enter_password'.tr;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutePath.forget_password);
                                  },
                                  child: Text(
                                    'forget_password'.tr,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      color: Color(0xff38ABD8),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: width / 1.2,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authController.login(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff38ABD8),
                                      ),
                                      child: Text(
                                        'log_in'.tr,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    ),
                                    // RaisedButton(
                                    //   color: Colors.green[700],
                                    //   child: Text(
                                    //     'log_in'.tr,
                                    //    style: TextStyle(
                                    //  fontFamily: "OpenSans",
                                    //         color: Colors.white, fontSize: 18),
                                    //   ),
                                    //   onPressed: () {
                                    //     if (_formKey.currentState!.validate()) {
                                    //       authController.login(context);
                                    //     }
                                    //   },
                                    // ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "dont_have_account".tr,
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RoutePath.sign_up_email);
                                    },
                                    child: Text(
                                      'sign_up'.tr,
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Color(0xff38ABD8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
