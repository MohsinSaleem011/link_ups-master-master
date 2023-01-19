import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:link_up/introscreens/screenseven.dart';
import 'package:link_up/introscreens/screensfour.dart';
import 'package:link_up/introscreens/screensix.dart';
import 'package:link_up/introscreens/screensone.dart';
import 'package:link_up/introscreens/screensthree.dart';
import 'package:link_up/introscreens/screenstwo.dart';

class OnBoardingScreens extends StatefulWidget {
  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

int currentPage = 0;

final _controller = PageController(initialPage: 0);
List<Widget> _pages = [
  Column(children: [Expanded(child: OnboardingScreenOne())]),
  Column(children: [Expanded(child: OnboardingScreenTwo())]),
  Column(children: [Expanded(child: OnboardingScreenThree())]),
  Column(children: [Expanded(child: OnboardingScreenFour())]),
  Column(children: [Expanded(child: OnboardingScreenSix())]),
  Column(children: [Expanded(child: OnboardingScreenSeven())]),
];

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 20),
          child: DotsIndicator(
            dotsCount: _pages.length,
            position: currentPage.toDouble(),
            decorator: DotsDecorator(
              color: Color(0xff39A9D7), // Inactive color
              activeColor: Color(0xffCCD218),
            ),
          ),
        ),
      ],
    );
  }
}
