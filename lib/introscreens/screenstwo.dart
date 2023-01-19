import 'package:flutter/material.dart';

class OnboardingScreenTwo extends StatefulWidget {
  @override
  State<OnboardingScreenTwo> createState() => _OnboardingScreenTwoState();
}

class _OnboardingScreenTwoState extends State<OnboardingScreenTwo> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/asasasas.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
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
              'With linkup Vibes, you can select which\n Caribbean or Latin American country you \nwant to see people from',
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
