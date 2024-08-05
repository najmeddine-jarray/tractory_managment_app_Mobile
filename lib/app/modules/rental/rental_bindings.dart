import 'package:get/get.dart';
import '../../data/services/rental_Services.dart';
import './rental_controller.dart';

class RentalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalService>(() => RentalService());
    Get.lazyPut<RentalController>(() => RentalController());
  }
}
