import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';

class SignUpUsingEmail extends StatefulWidget {
  @override
  _SignUpUsingEmailState createState() => _SignUpUsingEmailState();
}

class _SignUpUsingEmailState extends State<SignUpUsingEmail> {
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.find(tag: AuthController().toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.updateLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder(
        init: authController,
        builder: (_) {
          if (authController.loading.value == true) {
            return Scaffold(
              // backgroundColor: ,
              body: Center(child: CircularProgressIndicator()),
            );
          } else
            return SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  Navigator.of(context).pushNamed('/Auth');
                  return false;
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  body: Container(
                    width: width,
                    height: height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          // SizedBox(
                          //   height: 5,
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
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(20))),
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
                                      // icon: const Icon(Icons.email),
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
                                    controller:
                                        authController.passwordController,
                                    obscureText: _hidePassword,
                                    decoration: InputDecoration(
                                      // prefixIcon: const Icon(Icons.lock),
                                      hintText: 'enter_password'.tr,
                                      // labelText: 'password'.tr,
                                      contentPadding: EdgeInsets.only(
                                          left: 0.0,
                                          top: 0.0,
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
                                    height: 30,
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
                                            'sign_up'.tr,
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              authController.register(context);
                                            }
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "already_have_an_account".tr,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.grey),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'sign_in'.tr,
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Color(0xff38ABD8),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
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
              ),
            );
        });
  }
}
