import 'package:flutter/material.dart';
import 'package:link_up/introscreens/onboard.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(child: OnBoardingScreens()),
            ],
          ),
        ),
      ),
    );
  }
}
