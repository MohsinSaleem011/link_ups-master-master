import 'dart:async';

import 'package:flutter/material.dart';
import 'package:link_up/events/CurrentLocation.dart';
import 'package:link_up/events/chat_message_new.dart';

class SplashEvents extends StatefulWidget {
  SplashEvents({Key? key}) : super(key: key);

  @override
  State<SplashEvents> createState() => _SplashEventsState();
}

class _SplashEventsState extends State<SplashEvents> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  CurrentLocation()))
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F5F8),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Image.asset("assets/events_splash2.png"),
        const SizedBox(
          height: 20,
        ),
        Image.asset("assets/events_splash.png"),
      ]),
    );
  }
}
