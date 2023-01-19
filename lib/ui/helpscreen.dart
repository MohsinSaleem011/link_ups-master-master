import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            'assets/Group_163959__3_-removebg-preview.png',
            fit: BoxFit.fill,
          ),
        ),
        leadingWidth: 20,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 10),
          child: Icon(Icons.menu),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 10),
          child: Text(
            'Help',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'This is a help page for our app. Here you can find information on how to use the different features of our app. If you have any additional questions or need further assistance, please contact us at mailto:support@example.com or 555-555-5555. We are happy to help!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
