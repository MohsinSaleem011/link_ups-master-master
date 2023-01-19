import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/helper/app_config.dart';
import 'package:link_up/model/subscription_model.dart';
import 'package:link_up/ui/home_page.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;

  void changeLoadingStatus(bool value) {
    isLoading = RxBool(value);
    update();
  }

  purchaseAndPay(
      {required String packageID,
      required String price,
      required BuildContext context,
      required String userID,
      required String duration,
      required String customerId}) async {
    changeLoadingStatus(true);
    var transaction = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('transaction')
        .doc();
    try {
      final url = Uri.parse(
          "https://us-central1-linkup-cfa21.cloudfunctions.net/stripePaymentTest");
      Map<String, dynamic> _d = customerId != ''
          ? {
              "amount": (double.parse(price) * 100).toString(),
              "currency": App.currency,
              "customer_id": customerId
            }
          : {
              "amount": (double.parse(price) * 100).toString(),
              "currency": App.currency
            };
      print('-----------------url');
      print(url);
      print(_d);
      final response = await http.post(url, body: _d);
      print('----------------------- response');
      print(response.body);
      print(transaction.id);
      var jsonBody = jsonDecode(response.body);
      Map<String, dynamic>? paymentIntentData;
      paymentIntentData = jsonBody;
      if (paymentIntentData!["paymentIntent"] != "" &&
          paymentIntentData["paymentIntent"] != null) {
        String _intent = paymentIntentData["paymentIntent"];

        transaction.set({"intent": paymentIntentData, "status": "pending"});

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: _intent,
            applePay: false,
            googlePay: false,
            merchantCountryCode: "US",
            merchantDisplayName: "LinkUp",
            testEnv: false,
            customerId: customerId, // paymentIntentData['customer'],
            customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          ),
        );

        await Stripe.instance.presentPaymentSheet();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('transaction')
            .doc(transaction.id)
            .update({"status": "success"});
        Subscription _subscription = Subscription(
            packageId: packageID,
            transactionId: transaction.id,
            userId: userID,
            timeStamp: DateTime.now().millisecondsSinceEpoch,
            expiry: DateTime.now()
                .add(Duration(days: (int.parse(duration) * 30)))
                .millisecondsSinceEpoch);
        await addSubscription(userID, _subscription);
        AuthController authController =
            Get.find(tag: AuthController().toString());

        authController.getUser(userID, context);
        changeLoadingStatus(false);

        Get.offAll(HomePage());
      }
    } catch (e) {
      changeLoadingStatus(false);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('transaction')
          .doc(transaction.id)
          .update({"status": "failed"});
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.error.localizedMessage ?? 'Something went wrong!'),
        ));
      }
    }
  }

  Future<void> addSubscription(String userID, Subscription subscription) async {
    await FirebaseFirestore.instance.collection('users').doc(userID).update({
      "subscription": FieldValue.arrayUnion([subscription.toJson()])
    });
  }
}
