// lib/controllers/equipment_controller.dart
import 'package:get/get.dart';
import 'package:tractory/app/data/services/equipment_Services.dart';
import '../../data/models/equipment_Model.dart';

class EquipmentController extends GetxController {
  var equipmentList = <Equipment>[].obs;
  var filteredEquipment = <Equipment>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchEquipment();
    super.onInit();
  }

  void fetchEquipment() async {
    try {
      isLoading(true);
      var equipmentService = Get.find<EquipmentService>();
      var equipment = await equipmentService.getAllEquipment();
      equipmentList.assignAll(equipment);
      filteredEquipment.assignAll(equipment); // Initialize filteredEquipment
    } catch (e) {
      errorMessage('Failed to load equipment');
    } finally {
      isLoading(false);
    }
  }

  void filterEquipment(String query) {
    if (query.isEmpty) {
      filteredEquipment
          .assignAll(equipmentList); // Show all equipment if query is empty
    } else {
      filteredEquipment.assignAll(equipmentList.where((equipment) =>
          equipment.name.toLowerCase().contains(query) ||
          equipment.type.toLowerCase().contains(query)));
    }
  }

  void addEquipment(Equipment equipment) async {
    try {
      var equipmentService = Get.find<EquipmentService>();
      await equipmentService.createEquipment(equipment);
      fetchEquipment(); // Refresh the list
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateEquipment(Equipment equipment) async {
    try {
      var equipmentService = Get.find<EquipmentService>();
      await equipmentService.updateEquipment(equipment);
      fetchEquipment(); // Refresh the list
    } catch (e) {
      print('Error: $e');
    }
  }

  void deleteEquipment(int id) async {
    try {
      var equipmentService = Get.find<EquipmentService>();
      await equipmentService.deleteEquipment(id);
      fetchEquipment(); // Refresh the list
    } catch (e) {
      print('Error: $e');
    }
  }
}
