import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/router/route_path.dart';
import 'package:link_up/introscreens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find(tag: AuthController().toString());

  checkAuth(BuildContext context) async {
    var _shared = await SharedPreferences.getInstance();
    String? _id = _shared.getString('user_id');
    if (_id != null && _id != '') {
      String id = _id;
      authController.getUser(id, context).then((value) {
        Navigator.pushNamed(context, RoutePath.home_screen);
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => Welcome()));
    }
  }

  @override
  void initState() {
    checkAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
          init: authController,
          builder: (_) {
            return Container(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'assets/asd.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 620),
                          child: Center(
                            child: Text(
                              "Linking Caribbean and Latin American \n                 People Everywhere.",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Color.fromARGB(255, 56, 171, 216),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 710),
                          child: Center(
                              child: Image.asset("assets/image/doted.jpg")),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20,),
                    // Text("Linking Caribbean and Latin American People Everywhere.",style: TextStyle(
                    //   color: Colors.blue,
                    //   fontSize: 17,
                    //   fontWeight: FontWeight.bold,
                    // ),),
                    //  SizedBox(height: 20,),
                    //  Image.asset("assets/image/doted.jpg"),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
