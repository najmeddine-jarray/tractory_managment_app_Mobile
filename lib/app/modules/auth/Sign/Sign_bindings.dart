import 'package:get/get.dart';
import './Sign_controller.dart';

class SignBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignController());
  }
}
