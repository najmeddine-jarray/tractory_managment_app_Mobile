import 'package:get/get.dart';
import '../../data/services/equipment_Services.dart';
import './equipement_controller.dart';

class EquipementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EquipmentService>(() => EquipmentService());
    Get.lazyPut<EquipmentController>(() => EquipmentController());
  }
}
