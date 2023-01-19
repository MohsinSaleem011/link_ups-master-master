import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:link_up/ui/addbalance.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            // Image.asset("assets/Group 163959background.png"),
            Container(
              height: 210,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 140),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/ror.png",
                          height: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "\$65",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Your current balance",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.white,
                        fontSize: 20),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "History",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Wallet(),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Get.to(AddBalance());
                  },
                  child: Container(
                    height: 40,
                    width: 260,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(214, 220, 22, 1),
                        borderRadius: BorderRadius.circular(3)),
                    child: Center(
                      child: Text(
                        "ADD AMOUNT",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding Wallet() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Image.asset(
            "assets/ror.png",
            height: 40,
            color: Color.fromARGB(255, 56, 171, 216),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet used in Booking\nId#138",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "16th Nov, 12:10 PM",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 120,
          ),
          Text(
            "105\$",
            style: TextStyle(
                fontFamily: "OpenSans",
                color: Color.fromARGB(255, 56, 171, 216),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
