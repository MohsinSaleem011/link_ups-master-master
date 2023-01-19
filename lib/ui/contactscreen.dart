import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
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
            'Contact Us',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thank you for using our app!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions, comments, or concerns, please don\'t hesitate to reach out to us.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                'You can contact us via email at mailto:support@example.com \n or by phone at \n 555-555-5555.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We\'re here to help and we value your feedback.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you!',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}