import 'package:get/get.dart';
import '../../data/services/usage_Services.dart';
import './usage_controller.dart';

class UsageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsageService>(() => UsageService());
    Get.lazyPut<UsageController>(() => UsageController());
  }
}
