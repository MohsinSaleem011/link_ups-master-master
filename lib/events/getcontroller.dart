import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  Rx<TextEditingController> eventscontroller = TextEditingController().obs;

  RxString? category = ''.obs;
  RxString? title = ''.obs;
  RxString? description = ''.obs;
  RxString? start_date = ''.obs;
  RxString? end_date = ''.obs;
  RxString? location = ''.obs;
  Rx<TextEditingController> codecONTROLLER = TextEditingController().obs;
  RxString? code = ''.obs;
  RxString? discount = ''.obs;
  RxString? percentage = ''.obs;
  // var discountint=int.parse(discount.toString()).obs;
  RxString discountcode = ''.obs;
  RxString? ticketid = ''.obs;
  RxInt percentageoramount = 0.obs;
  RxDouble? currrentlongitude = 0.0.obs;
  RxDouble? currentlatitude = 0.0.obs;
  void getCurrentLocation() async {
    print('getting location');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currrentlongitude!.value = position.longitude.toDouble();
    currentlatitude!.value = position.latitude.toDouble();
    // print(currrentlongitude!.value);
    // print(currentlatitude!.value);
    // update();
    // print(currrentlongitude!.value);
    // print(currentlatitude!.value);
  }

  void setdiscount(String? discountcode, String? ticketid) {
    var _collection1 = FirebaseFirestore.instance
        .collection('coupons')
        .where('ticket_id', isEqualTo: ticketid);
    _collection1.get().then((doc) {
      print(doc.docs[0].data()['code']);
      if (doc.docs[0].data()['discount_type'] == "amount") {
        discount!.value = doc.docs[0].data()['discount'];
        percentage!.value = '';
        percentageoramount.value = 1;
        print('if amount percentage value ');
        print(percentage!.value);
        print('if amount discount value ');
        print('percentage working');
        print(discount!.value);
      } else if (doc.docs[0].data()['discount_type'] == "percentage") {
        percentage!.value = doc.docs[0].data()['discount'];
        discount!.value = '';
        percentageoramount.value = 2;

        print('if percentage percentage value ');

        print(percentage!.value);
        print('if percentage discount value ');
        print(discount!.value);
      }
    });
  }

  Widget getbutton() {
    print(codecONTROLLER.value.text.toString());
    print(discountcode);
    if (discountcode == codecONTROLLER.value.text.toString()) {
      return Container(
          child: Image.asset(
        "assets/Economy.png",
        height: 40,
      ));
    } else {
      return Text('No Coupon Available');
    }
  }
}
