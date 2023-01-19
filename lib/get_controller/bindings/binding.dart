import 'package:get/get.dart';
import 'package:link_up/get_controller/ChatController.dart';
import 'package:link_up/get_controller/auth_controller.dart';
import 'package:link_up/get_controller/base_controller.dart';
import 'package:link_up/get_controller/call_controller.dart';
import 'package:link_up/get_controller/home_controller.dart';
import 'package:link_up/get_controller/map_controller.dart';
import 'package:link_up/get_controller/payment_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseController(), tag: BaseController().toString());
    Get.put(AuthController(), tag: AuthController().toString());
    Get.put(HomeController(), tag: HomeController().toString());
    Get.put(ChatController(), tag: ChatController().toString());
    Get.put(CallController(), tag: CallController().toString());
    Get.put(PaymentController(), tag: PaymentController().toString());
    Get.put(MapController(), tag: MapController().toString());
  }
}
