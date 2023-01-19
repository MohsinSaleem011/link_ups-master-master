import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/get_controller/payment_controller.dart';
import 'package:link_up/helper/app_constant.dart';
import 'package:link_up/ui/DrawerScreen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home_page.dart';

class SubscriptionPage1 extends StatefulWidget {
  @override
  _SubscriptionPage1State createState() => _SubscriptionPage1State();
}

class _SubscriptionPage1State extends State<SubscriptionPage1> {
  AuthController authController = Get.find(tag: AuthController().toString());
  PaymentController paymentController =
      Get.find(tag: PaymentController().toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      paymentController.changeLoadingStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<PaymentController>(
        init: paymentController,
        builder: (_) {
          if (paymentController.isLoading.value == true) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return SafeArea(
            child: Scaffold(
                body: Column(children: [
              Container(
                height: 700,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/Group 163976.png"),
                    Column(
                      children: <Widget>[
                        Image.asset("assets/LinkUp App Login 2.png"),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Join our Elitec\nMembership \nTeam Today!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                            height: 220,
                            child: ListView.builder(
                              itemCount: AppConstant.packages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return packageCard(
                                    id: AppConstant.packages[index]['id'],
                                    title: AppConstant.packages[index]['title'],
                                    price: AppConstant.packages[index]['price'],
                                    duration: AppConstant.packages[index]
                                        ['duration'],
                                    activeSub: authController
                                            .user!.value.subscription.isNotEmpty
                                        ? authController
                                                    .user!.value.subscription[0]
                                                ['package_id'] ==
                                            AppConstant.packages[index]['id']
                                        : false,
                                    paymentController: paymentController);
                              },
                            )),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Container(
                        //     child: Text(
                        //       'no_thank'.tr.toUpperCase(),
                        //      style: TextStyle(
                        //         fontSize: 22,
                        //         color: Colors.white70,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),

                        //   ),
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(HomePage());
                          },
                          child: Center(
                            child: Text(
                              "No Thanks",
                              style: TextStyle(
                                  color: Color(0xff38abd8),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ])),
          );
        });
  }

  Widget packageCard(
      {required String id,
      required String title,
      required String price,
      required String duration,
      required bool activeSub,
      required PaymentController paymentController}) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      width: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '\$',
                        style: TextStyle(
                            color: Color(0xff38ABD8),
                            fontFamily: 'Arial',
                            fontSize: 16),
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff38ABD8),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                'per_month'.tr,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${'free_for'.tr}\n${duration} ${'months'.tr}',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  backgroundColor: Color(0xffC5CB2E),
                  surfaceTintColor: Colors.green,
                ),
                child: Text(
                  'upgrade'.tr,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  try {
                    if (await Permission.locationWhenInUse.status ==
                            PermissionStatus.granted ||
                        await Permission.locationAlways.status ==
                            PermissionStatus.granted) {
                      if (authController.user!.value.subscription.isNotEmpty) {
                        List activeSubscription = authController
                            .user!.value.subscription
                            .where((element) =>
                                DateTime.fromMillisecondsSinceEpoch(
                                        element['expiry'])
                                    .isAfter(DateTime.now()))
                            .toList();
                        if (activeSubscription.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('already_have_subscription'.tr),
                          ));
                        }
                      } else {
                        print('------------------------ purchaseAndPay');
                        paymentController.purchaseAndPay(
                            packageID: id,
                            price: price,
                            context: context,
                            userID: authController.user!.value.uid!,
                            duration: duration,
                            customerId:
                                authController.user!.value.stripeCustomerId);
                      }
                    } else {
                      await Permission.locationAlways.request();
                    }
                  } catch (e) {
                    print(e);
                    paymentController.changeLoadingStatus(false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      if (activeSub)
        Positioned(
          top: 0,
          right: 4,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              'Active',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
    ]);
  }
}
