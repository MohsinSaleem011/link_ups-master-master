import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/image/loading_background.png'),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: CircularProgressIndicator(
                  // backgroundColor: Colors.green,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
