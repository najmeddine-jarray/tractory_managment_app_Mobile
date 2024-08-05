import 'package:get/get.dart';
import 'package:tractory/app/data/services/client_Services.dart';
import 'package:tractory/app/data/services/driver_Services.dart';
import 'package:tractory/app/data/services/equipment_Services.dart';
import 'package:tractory/app/data/services/expense_Services.dart';
import 'package:tractory/app/data/services/invoice_Services.dart';
import 'package:tractory/app/data/services/rental_Services.dart';
import 'package:tractory/app/data/services/tractor_Services.dart';
import 'package:tractory/app/data/services/usage_Services.dart';
import 'package:tractory/app/modules/client/client_controller.dart';
import 'package:tractory/app/modules/driver/driver_controller.dart';
import 'package:tractory/app/modules/equipement/equipement_controller.dart';
import 'package:tractory/app/modules/expense/expense_controller.dart';
import 'package:tractory/app/modules/home/Home_controller.dart';
import 'package:tractory/app/modules/invoice/invoice_controller.dart';
import 'package:tractory/app/modules/rental/rental_controller.dart';
import 'package:tractory/app/modules/report/report_controller.dart';
import 'package:tractory/app/modules/tractor/tractor_controller.dart';
import 'package:tractory/app/modules/usage/usage_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<InvoiceController>(() => InvoiceController());
    Get.lazyPut<DriverController>(() => DriverController());
    Get.lazyPut<DriverService>(() => DriverService());
    Get.lazyPut<RentalService>(() => RentalService());
    Get.lazyPut<RentalController>(() => RentalController());
    Get.lazyPut<ClientService>(() => ClientService()); // Register ClientService
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<EquipmentService>(() => EquipmentService());
    Get.lazyPut<EquipmentController>(() => EquipmentController());
    Get.lazyPut<ExpenseService>(() => ExpenseService());
    Get.lazyPut<ExpenseController>(() => ExpenseController());
    Get.lazyPut<TractorService>(() => TractorService());
    Get.lazyPut<TractorController>(() => TractorController());
    Get.lazyPut<UsageService>(() => UsageService());
    Get.lazyPut<UsageController>(() => UsageController());
    Get.lazyPut<ReportController>(() => ReportController());
  }
}
