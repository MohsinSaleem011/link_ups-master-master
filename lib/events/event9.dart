import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:link_up/events/event_detail.dart';
import 'package:pay/pay.dart';

import '../ui/DrawerScreen.dart';

class Event9 extends StatefulWidget {
  final Function? onFinish;
  String? title;
  String? description;
  String? start_time;
  Timestamp? end_time;
  String? country;
  String? state;
  String? venue;
  String? uid;
  String? Disclaimer;
  String? Organizer;
  Uint8List? image;
  double? totalprice;

  Event9({
    this.totalprice,
    this.onFinish,
    this.image,
    this.Organizer,
    this.Disclaimer,
    this.title,
    this.description,
    this.end_time,
    this.start_time,
    this.country,
    this.state,
    this.venue,
    this.uid,
  });

  @override
  State<Event9> createState() => _Event9State();
}

class _Event9State extends State<Event9> {
  String totalprice1 = '';

  // final _paymentItems = [
  //   PaymentItem(
  //     label: 'Total',
  //     amount: '99.99',
  //     status: PaymentItemStatus.final_price,
  //   )
  // ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var checkOutUrl;
  var executeUrl;
  var accessToken;

  @override
  void initState() {
    totalprice1 = widget.totalprice!.toDouble().toString();
    print(totalprice1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: totalprice1.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

// totalprice1=widget.totalprice!.toDouble().toString();
// print(totalprice1);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/Group_163959__1_-removebg-preview.png"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Payment Method",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("assets/apple.png"),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "Apple Pay",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                // SizedBox(
                //   width: 180,
                // ),
                Image.asset("assets/Polygon_12-removebg-preview.png"),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      print("Paypal");
                      UsePaypal(
                          sandboxMode: true,
                          clientId:
                              "AaXe57eGbgOpiSGr872gfRA3poNPGwlT1SpwK2Nvijbo8EROEC80b5uq25FuQ-q5UZqezCN-reeQok21",
                          secretKey:
                              "EKQwWNBS7OhPl_wXUTWJOXPbQwGLs1Bq93hdSyFJOxpPaC71MVPpw2G_IeS2vXt1BdOCdy9V4w5PZ_kj",
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: [
                            {
                              "amount": {
                                "total": '10.12',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '10.12',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              "payment_options": {
                                "allowed_payment_method":
                                    "INSTANT_FUNDING_SOURCE"
                              },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": totalprice1.toString(),
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": "Jane Foster",
                                  "line1": "Travis County",
                                  "line2": "",
                                  "city": "Austin",
                                  "country_code": "US",
                                  "postal_code": "73301",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          });
                    },
                    child: Image.asset("assets/PayPal.png")),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "PayPal",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                // SizedBox(
                //   width: 203,
                // ),
                Image.asset("assets/Polygon_12-removebg-preview.png"),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          // image: DecorationImage(
                          //     image: AssetImage("assets/Group 163994.png"),
                          // fit: BoxFit.fill)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 70.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: GooglePayButton(
                                        paymentConfigurationAsset: 'gpay.json',
                                        paymentItems: _paymentItems,
                                        type: GooglePayButtonType.buy,
                                        margin:
                                            const EdgeInsets.only(top: 15.0),
                                        onPaymentResult: onGooglePayResult,
                                        loadingIndicator: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 17, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset("assets/Google-Pay-Logo.png"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      "Google Pay",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  // SizedBox(
                  //   width: 165,
                  // ),
                  Image.asset("assets/Polygon_12-removebg-preview.png"),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/card meth.png"),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "Pay by Debit/Card",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    // SizedBox(
                    //   width: 69,
                    // ),
                    Image.asset("assets/Polygon_12-removebg-preview.png"),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text("***************")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 67,
              ),
              Expanded(
                child: Text(
                  "Add Voucher",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(
              //   width: 62,
              // ),
              Text(
                "16asd4ASD",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 12,
              ),
              Image.asset("assets/Polygon_12-removebg-preview.png"),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          SizedBox(
            height: 160,
          ),
          // Text(widget.uid.toString()),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: InkWell(
                        onTap: () {
                          Get.to(EventDetail(
                            title: widget.title,
                            description: widget.description,
                            end_time: widget.end_time,
                            start_time: widget.start_time,
                            country: widget.country,
                            state: widget.state,
                            uuid: widget.uid,
                            venue: widget.venue,
                            disclai: widget.Disclaimer,
                            nameorganizer: widget.Organizer,
                            image: widget.image,
                          ));
                        },
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: AssetImage("assets/Group 163994.png"),
                                  fit: BoxFit.fill)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 70.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Ticket \n Confirmed",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 30),
                                      ),
                                      Image.asset(
                                        "assets/Group 163993.png",
                                        height: 90,
                                        width: 90,
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 30, left: 20),
                                  child: Text(
                                    "Your ticket successfully confirmed",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       alignment: Alignment.center,
                                //       width: 65.0,
                                //       child: ElevatedButton(
                                //         onPressed: () {
                                //           // Get.to(EventDetail());
                                //           Get.to(EventDetail());
                                //         },
                                //         child: Text(
                                //           "View",
                                //          style: TextStyle(color: Colors.white),
                                //         ),
                                //         style: ElevatedButton.styleFrom(
                                //           backgroundColor: Color(0xff38ABD8),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              height: 35,
              width: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: AssetImage("assets/Rectangle 23327.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Center(
                child: Text(
                  "CHECKOUT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
