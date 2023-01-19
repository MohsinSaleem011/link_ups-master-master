import 'package:flutter/material.dart';

class OnboardingScreenOne extends StatefulWidget {
  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset('assets/Layer 3.png', fit: BoxFit.cover),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Image.asset(
                      'assets/Vector Smart Object 2.png',
                      width: 157,
                      height: 58,
                    ))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Linkup Vibes!",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Color(0xff38ABD8),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'The only App that brings Caribbean & Latin\n Americans Together from all over the World',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 14,
                color: Color(0xff2E2E2E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ));
  }
}
