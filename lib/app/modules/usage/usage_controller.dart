import 'dart:convert';

import 'package:get/get.dart';
import 'package:tractory/app/data/models/client_Model.dart';
import '../../data/models/usage_Model.dart';
import '../../data/models/tractor_Model.dart';
import '../../data/models/equipment_Model.dart';
import '../../data/models/driver_Model.dart';
import '../../data/models/rental_Model.dart';
import '../../data/models/invoice_Model.dart';
import '../../data/services/client_Services.dart';
import '../../data/services/usage_Services.dart';
import '../../data/services/tractor_Services.dart';
import '../../data/services/equipment_Services.dart';
import '../../data/services/driver_Services.dart';
import '../../data/services/rental_Services.dart';
import '../../data/services/invoice_Services.dart';

class UsageController extends GetxController {
  var usageList = <Usage>[].obs;
  var tractorList = <Tractor>[].obs;
  var equipmentList = <Equipment>[].obs;
  var driverList = <Driver>[].obs;
  var rentalList = <Rental>[].obs;
  var invoiceList = <Invoice>[].obs;
  var clientList = <Client>[].obs; // Add clientList

  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading(true);
      // Fetch all data concurrently
      await Future.wait<void>([
        fetchUsage(),
        fetchTractors(),
        fetchEquipment(),
        fetchDrivers(),
        fetchRentals(),
        fetchInvoices(),
        fetchClients(), // Include fetchClients
      ]);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchClients() async {
    try {
      isLoading(true);
      var clientService = Get.find<ClientService>();
      var clients = await clientService.getAllClients();
      clientList.assignAll(clients);
      String clientJson =
          jsonEncode(clientList.map((item) => item.toJson()).toList());
      print('Fetched Client Data: $clientJson');
    } catch (e) {
      print("Error fetching clients: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUsage() async {
    try {
      isLoading(true);
      var usageService = Get.find<UsageService>();
      var usage = await usageService.getAllUsage();
      usageList.assignAll(usage);
      String usageJson =
          jsonEncode(usageList.map((item) => item.toJson()).toList());
      print('Fetched Usage Data: $usageJson');
    } catch (e) {
      print("Error fetching usage: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTractors() async {
    try {
      var tractorService = Get.find<TractorService>();
      var tractors = await tractorService.getAllTractors();
      tractorList.assignAll(tractors);
      String tractorJson =
          jsonEncode(tractorList.map((item) => item.toJson()).toList());
      print('Fetched Tractor Data: $tractorJson');
    } catch (e) {
      print("Error fetching tractors: $e");
    }
  }

  Future<void> fetchEquipment() async {
    try {
      var equipmentService = Get.find<EquipmentService>();
      var equipment = await equipmentService.getAllEquipment();
      equipmentList.assignAll(equipment);
      String equipmentJson =
          jsonEncode(equipmentList.map((item) => item.toJson()).toList());
      print('Fetched Equipment Data: $equipmentJson');
    } catch (e) {
      print("Error fetching equipment: $e");
    }
  }

  Future<void> fetchDrivers() async {
    try {
      var driverService = Get.find<DriverService>();
      var drivers = await driverService.getAllDrivers();
      driverList.assignAll(drivers);
      String driverJson =
          jsonEncode(driverList.map((item) => item.toJson()).toList());
      print('Fetched Driver Data: $driverJson');
    } catch (e) {
      print("Error fetching drivers: $e");
    }
  }

  Future<void> fetchRentals() async {
    try {
      var rentalService = Get.find<RentalService>();
      var rentals = await rentalService.getAllRentals();
      rentalList.assignAll(rentals);
      String rentalJson =
          jsonEncode(rentalList.map((item) => item.toJson()).toList());
      print('Fetched Rental Data: $rentalJson');
    } catch (e) {
      print("Error fetching rentals: $e");
    }
  }

  Future<void> fetchInvoices() async {
    try {
      var invoiceService = Get.find<InvoiceService>();
      var invoices = await invoiceService.getAllInvoices();
      invoiceList.assignAll(invoices);
      String invoiceJson =
          jsonEncode(invoiceList.map((item) => item.toJson()).toList());
      print('Fetched Invoice Data: $invoiceJson');
    } catch (e) {
      print("Error fetching invoices: $e");
    }
  }

  Future<void> addUsage(Usage usage) async {
    try {
      var usageService = Get.find<UsageService>();
      await usageService.addUsage(usage);
      fetchUsage();
      fetchInvoices();
    } catch (e) {
      fetchUsage();
      fetchInvoices();

      print("Error adding usage: $e");
    }
  }

  void updateUsage(Usage usage) async {
    try {
      var usageService = Get.find<UsageService>();
      await usageService.updateUsage(usage);
      fetchUsage();
      fetchInvoices();
    } catch (e) {
      fetchUsage();
      fetchInvoices();

      print("Error updating usage: $e");
    }
  }

  void deleteUsage(int id) async {
    try {
      var usageService = Get.find<UsageService>();
      await usageService.deleteUsage(id);
      fetchUsage();
    } catch (e) {
      print("Error deleting usage: $e");
    }
  }
}
