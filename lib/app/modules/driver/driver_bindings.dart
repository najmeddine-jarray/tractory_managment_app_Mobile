import 'package:get/get.dart';
import '../../data/services/driver_Services.dart';
import './driver_controller.dart';

class DriverBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController());
    Get.lazyPut<DriverService>(() => DriverService());
  }
}
