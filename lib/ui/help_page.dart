import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('help_support'.tr),
      ),
      body: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              Text('slide_right_like'.tr),
              Text('will_only_be_match'.tr),
              Text('slide_left_pass'.tr),
              Text("if_dont_like_then".tr),
              Text("theres_even_more".tr),
              Text('undo_your_like'.tr),
              Text('slide_up_tap_like'.tr),
              Text('tap_boost_more'.tr)
            ],
          )),
    );
  }
}
