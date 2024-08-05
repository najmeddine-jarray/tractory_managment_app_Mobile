import 'package:get/get.dart';
import 'package:tractory/app/data/services/invoice_Services.dart';
import 'package:tractory/app/modules/invoice/invoice_controller.dart';
import '../../data/services/usage_Services.dart';
import './usage_controller.dart';

class UsageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsageService>(() => UsageService());
    Get.lazyPut<UsageController>(() => UsageController());
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}
