import 'package:flutter/material.dart';

class OnboardingScreenSix extends StatefulWidget {
  @override
  State<OnboardingScreenSix> createState() => _OnboardingScreenSixState();
}

class _OnboardingScreenSixState extends State<OnboardingScreenSix> {
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
                    'assets/six.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Text(
              "Linkup Vibes Resturant",
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
              'Want to take your new date to a nice resturant? \nSelect the food section on the app and all the \nresturant in your area will be visible',
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
