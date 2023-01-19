import 'package:flutter/material.dart';
import 'package:link_up/ui/auth/auth_page.dart';

class OnboardingScreenSeven extends StatefulWidget {
  @override
  State<OnboardingScreenSeven> createState() => _OnboardingScreenSevenState();
}

class _OnboardingScreenSevenState extends State<OnboardingScreenSeven> {
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
                    'assets/Group 164008.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
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
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Linkup Membership",
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
              'Unlimited Calls \nUnlimited Video \nUnlimited Restaurant Search \nUnlimited Live \nTop Shelf Profile \nUnlimited Swipes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 14,
                color: Color(0xff2E2E2E),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 286,
                height: 38,
                child: ElevatedButton(
                  // color: Colors.red[700],
                  child: Text(
                    'Get Started',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff38ABD8),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => AuthPage()));
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
