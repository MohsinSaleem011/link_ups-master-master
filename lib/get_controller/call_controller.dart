import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:link_up/get_controller/base_controller.dart';
import 'package:link_up/model/Call.dart';

class CallController extends BaseController {
  Call? call;
  RxBool cancelled = false.obs;

  //Get the Call from Provider
  Call? get cll => call;

  //Set the Call on the Provider
  set cll(Call? val) {
    call = val;
  }

  void updateCancelled(bool value) {
    cancelled = RxBool(value);
    update();
  }
}
