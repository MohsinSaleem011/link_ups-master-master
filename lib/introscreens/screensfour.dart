import 'package:flutter/material.dart';

class OnboardingScreenFour extends StatefulWidget {
  @override
  State<OnboardingScreenFour> createState() => _OnboardingScreenFourState();
}

class _OnboardingScreenFourState extends State<OnboardingScreenFour> {
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
                    'assets/fawad.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Text(
              "Linkup to the club",
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
              'Want to linkupat the club? With Linkup, you can \n see all the club in your area not matter what \ncountry you are in. Send the location to a friend \nand start the party.',
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
