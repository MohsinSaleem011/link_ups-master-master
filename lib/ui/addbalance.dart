import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:link_up/ui/Balance.dart';

class AddBalance extends StatelessWidget {
  const AddBalance({Key? key}) : super(key: key);

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
                    "Add Amount",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Add Amount",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        "300",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              builder: (context) => Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 50),
                                          child: Text(
                                            "Select Payment Method",
                                            style: TextStyle(
                                                fontFamily: "OpenSans",
                                                color: Color.fromARGB(
                                                    255, 56, 171, 216),
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/PayPal.png"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Paypal",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Credit/Debit card with Easier way to pay -\nonline and on your mobile.",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 14,
                                                        color: Colors.black38),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 45,
                                              ),
                                              Icon(
                                                Icons.circle_outlined,
                                                color: Colors.black38,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.paypal,
                                                size: 40,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Stripe",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Accept all major debit and credit cards from\ncustomers from customers in every country",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 14,
                                                        color: Colors.black38),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 22,
                                              ),
                                              Icon(
                                                Icons.circle_outlined,
                                                color: Colors.black38,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.paypal,
                                                size: 40,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Razorpay",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Card, UPI Net banking,\nWallet (Phone Pe, Amazon Pay, Freecharge)",
                                                    style: TextStyle(
                                                        fontFamily: "OpenSans",
                                                        fontSize: 14,
                                                        color: Colors.black38),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Icon(
                                                Icons.circle_outlined,
                                                color: Colors.black38,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          indent: 20,
                                          endIndent: 20,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 260,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  214, 220, 22, 1),
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Center(
                                            child: Text(
                                              "Pay Now | 300\$",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: Boxcontainer('100')),
                    Boxcontainer('200'),
                    Boxcontainer('300'),
                    Boxcontainer('400')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Boxcontainer('500'),
                    Boxcontainer('600'),
                    Boxcontainer('700'),
                    Boxcontainer('800')
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return History();
                    }));
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

  Container Boxcontainer(String? title) {
    return Container(
      height: 40,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 56, 171, 216)),
          borderRadius: BorderRadius.circular(3)),
      child: Center(
        child: Text(
          title!,
          style: TextStyle(fontFamily: "OpenSans", fontSize: 18),
        ),
      ),
    );
  }
}
