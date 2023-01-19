import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class ShortCutController extends GetxController {
  List<String> Location1=["Women,Men,Everyone"].obs;
 Rx<String> artlocation="Women".obs;
  void gender(String selectedgender){
    artlocation=selectedgender.obs;
           update();
  }
}