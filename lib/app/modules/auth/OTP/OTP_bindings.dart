import 'package:get/get.dart';
import './OTP_controller.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}
