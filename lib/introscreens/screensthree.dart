import 'package:flutter/material.dart';

class OnboardingScreenThree extends StatefulWidget {
  @override
  State<OnboardingScreenThree> createState() => _OnboardingScreenThreeState();
}

class _OnboardingScreenThreeState extends State<OnboardingScreenThree> {
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
                    'assets/asasasasfedhkaghskd.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
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
              'Go Live at your favorite Fete, party, club or festival \n Show the World how party on linkup.',
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
