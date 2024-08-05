import 'package:get/get.dart';
import '../../data/services/tractor_Services.dart';
import './tractor_controller.dart';

class TractorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TractorService>(() => TractorService());
    Get.lazyPut<TractorController>(() => TractorController());
  }
}
