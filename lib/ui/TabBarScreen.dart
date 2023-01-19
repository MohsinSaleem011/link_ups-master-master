import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/home_page.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              color: Colors.purpleAccent,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      indicatorColor: Colors.blue[600],
                      tabs: [
                        Tab(text: "account".tr),
                        Tab(text: "explore".tr),
                        Tab(text: "messages".tr),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                  child: Text(
                "0",
                style: TextStyle(fontFamily: "OpenSans", fontSize: 40),
              )),
              HomePage(),
              Center(
                  child: Text(
                "2",
                style: TextStyle(fontFamily: "OpenSans", fontSize: 40),
              )),
            ],
          )),
    );
  }
}
